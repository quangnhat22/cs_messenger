import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:app/components/features/video_call/exts/video_call_exts.dart';
import 'package:app/components/features/video_call/methos_channel/methos_channel.dart';
import 'package:app/components/features/video_call/utils/video_call_utils.dart';
import 'package:app/components/features/video_call/widgets/controls.dart';
import 'package:app/components/features/video_call/widgets/participant.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:utilities/utilities.dart';

import '../widgets/participant_info.dart';

class RoomView extends StatefulWidget {
  final Room room;
  final EventsListener<RoomEvent> listener;

  const RoomView(
    this.room,
    this.listener, {
    Key? key,
    required this.roomId,
    this.onShowMembers,
  }) : super(key: key);

  final String roomId;
  final void Function()? onShowMembers;

  @override
  State<StatefulWidget> createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView> {
  List<ParticipantTrack> participantTracks = [];

  EventsListener<RoomEvent> get _listener => widget.listener;

  bool get fastConnection => widget.room.engine.fastConnectOptions != null;
  bool _flagStartedReplayKit = false;
  bool _isHaveScreenSharing = false;

  @override
  void initState() {
    super.initState();
    // add callback for a `RoomEvent` as opposed to a `ParticipantEvent`
    widget.room.addListener(_onRoomDidUpdate);
    // add callbacks for finer grained events
    _setUpListeners();
    _sortParticipants();
    WidgetsBindingCompatible.instance?.addPostFrameCallback((_) {
      if (!fastConnection) {
        _askPublish();
      }
    });

    if (lkPlatformIsMobile()) {
      Hardware.instance.setSpeakerphoneOn(true);
    }

    ReplayKitChannel.listenMethodChannel(widget.room);

    if (lkPlatformIsDesktop()) {
      onWindowShouldClose = () async {
        unawaited(widget.room.disconnect());
        await _listener.waitFor<RoomDisconnectedEvent>(
            duration: const Duration(seconds: 5));
      };
    }
  }

  @override
  void dispose() {
    // always dispose listener
    (() async {
      ReplayKitChannel.closeReplayKit();
      widget.room.removeListener(_onRoomDidUpdate);
      await _listener.dispose();
      await widget.room.dispose();
    })();
    onWindowShouldClose = null;
    super.dispose();
  }

  /// for more information, see [event types](https://docs.livekit.io/client/events/#events)
  void _setUpListeners() => _listener
    ..on<RoomDisconnectedEvent>((event) async {
      if (event.reason != null) {
        Logs.d('Room disconnected: reason => ${event.reason}');
      }
      WidgetsBindingCompatible.instance?.addPostFrameCallback(
          (timeStamp) => Navigator.popUntil(context, (route) => route.isFirst));
    })
    ..on<ParticipantEvent>((event) {
      Logs.d('Participant event');
      // sort participants on many track events as noted in documentation linked above
      _sortParticipants();
    })
    ..on<RoomRecordingStatusChanged>((event) {
      context.showRecordingStatusChangedDialog(event.activeRecording);
    })
    ..on<LocalTrackPublishedEvent>((_) => _sortParticipants())
    ..on<LocalTrackUnpublishedEvent>((_) => _sortParticipants())
    ..on<TrackE2EEStateEvent>(_onE2EEStateEvent)
    ..on<ParticipantNameUpdatedEvent>((event) {
      Logs.d(
          'Participant name updated: ${event.participant.identity}, name => ${event.name}');
      _sortParticipants();
    })
    ..on<ParticipantMetadataUpdatedEvent>((event) {
      Logs.d(
          'Participant metadata updated: ${event.participant.identity}, metadata => ${event.metadata}');
    })
    ..on<RoomMetadataChangedEvent>((event) {
      Logs.d('Room metadata changed: ${event.metadata}');
    })
    ..on<DataReceivedEvent>((event) {
      String decoded = 'Failed to decode';
      try {
        decoded = utf8.decode(event.data);
      } catch (_) {
        Logs.d('Failed to decode: $_');
      }
      context.showDataReceivedDialog(decoded);
    })
    ..on<AudioPlaybackStatusChanged>((event) async {
      if (!widget.room.canPlaybackAudio) {
        Logs.d('Audio playback failed for iOS Safari ..........');
        bool? yesno = await context.showPlayAudioManuallyDialog();
        if (yesno == true) {
          await widget.room.startAudio();
        }
      }
    });

  void _askPublish() {
    VideoCallDialogExts.showPublishDialog(() async {
      await widget.room.localParticipant?.setCameraEnabled(true);
      await widget.room.localParticipant?.setMicrophoneEnabled(true);
    });
  }

  void _onRoomDidUpdate() {
    _sortParticipants();
  }

  void _onE2EEStateEvent(TrackE2EEStateEvent e2eeState) {
    Logs.d('e2ee state: $e2eeState');
  }

  void _sortParticipants() {
    List<ParticipantTrack> userMediaTracks = [];
    List<ParticipantTrack> screenTracks = [];
    for (var participant in widget.room.participants.values) {
      for (var t in participant.videoTracks) {
        if (t.isScreenShare) {
          screenTracks.add(ParticipantTrack(
            participant: participant,
            videoTrack: t.track,
            isScreenShare: true,
          ));
        } else {
          userMediaTracks.add(ParticipantTrack(
            participant: participant,
            videoTrack: t.track,
            isScreenShare: false,
          ));
        }
      }
    }
    // sort speakers for the grid
    userMediaTracks.sort((a, b) {
      // loudest speaker first
      if (a.participant.isSpeaking && b.participant.isSpeaking) {
        if (a.participant.audioLevel > b.participant.audioLevel) {
          return -1;
        } else {
          return 1;
        }
      }

      // last spoken at
      final aSpokeAt = a.participant.lastSpokeAt?.millisecondsSinceEpoch ?? 0;
      final bSpokeAt = b.participant.lastSpokeAt?.millisecondsSinceEpoch ?? 0;

      if (aSpokeAt != bSpokeAt) {
        return aSpokeAt > bSpokeAt ? -1 : 1;
      }

      // video on
      if (a.participant.hasVideo != b.participant.hasVideo) {
        return a.participant.hasVideo ? -1 : 1;
      }

      // joinedAt
      return a.participant.joinedAt.millisecondsSinceEpoch -
          b.participant.joinedAt.millisecondsSinceEpoch;
    });

    final localParticipantTracks = widget.room.localParticipant?.videoTracks;
    if (localParticipantTracks != null) {
      for (var t in localParticipantTracks) {
        if (t.isScreenShare) {
          if (!_flagStartedReplayKit) {
            _flagStartedReplayKit = true;

            ReplayKitChannel.startReplayKit();
          }

          screenTracks.add(ParticipantTrack(
            participant: widget.room.localParticipant!,
            videoTrack: t.track,
            isScreenShare: true,
          ));
        } else {
          if (_flagStartedReplayKit) {
            _flagStartedReplayKit = false;

            ReplayKitChannel.closeReplayKit();
          }

          userMediaTracks.add(ParticipantTrack(
            participant: widget.room.localParticipant!,
            videoTrack: t.track,
            isScreenShare: false,
          ));
        }
      }
    }
    setState(() {
      participantTracks = [...screenTracks, ...userMediaTracks];
      _isHaveScreenSharing = screenTracks.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppMainPageWidget()
        .setResizeToAvoidBottomInset(true)
        .setBody(_body(context))
        .build(context);
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizeExt.of.majorPaddingScale(4),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: AppSizeExt.of.majorScale(12),
            ),
            Expanded(
              child: participantTracks.isNotEmpty
                  ? _isHaveScreenSharing
                      ? _stackLayout(context)
                      : _gridLayout(context)
                  : const SizedBox(),
            ),
            if (widget.room.localParticipant != null)
              ControlsWidget(
                widget.room,
                widget.room.localParticipant!,
                roomId: widget.roomId,
                onShowMembers: widget.onShowMembers,
              ),
          ],
        ),
      ),
    );
  }

  Widget _gridLayout(BuildContext context) {
    return participantTracks.length < 2
        ? ParticipantWidget.widgetFor(participantTracks.first,
            showStatsLayer: true)
        : GridView.builder(
            scrollDirection: Axis.horizontal,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSizeExt.of.majorScale(2 / 4),
              mainAxisSpacing: AppSizeExt.of.majorScale(2 / 4),
            ),
            itemBuilder: (BuildContext s, int index) =>
                ParticipantWidget.widgetFor(participantTracks[index]),
            itemCount: participantTracks.length,
          );
  }

  Widget _stackLayout(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: AppSizeExt.of.majorScale(30),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: math.max(0, participantTracks.length - 1),
            itemBuilder: (BuildContext context, int index) => SizedBox(
              width: AppSizeExt.of.majorScale(25),
              height: AppSizeExt.of.majorScale(30),
              child: Padding(
                padding: EdgeInsets.all(AppSizeExt.of.majorScale(1)),
                child:
                    ParticipantWidget.widgetFor(participantTracks[index + 1]),
              ),
            ),
          ),
        ),
        Expanded(
          child: ParticipantWidget.widgetFor(
            participantTracks.first,
            showStatsLayer: true,
          ),
        ),
      ],
    );
  }
}
