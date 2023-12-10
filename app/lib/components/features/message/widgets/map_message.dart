import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resources/resources.dart';
import 'package:url_launcher/url_launcher.dart';

class MapMessage extends StatefulWidget {
  const MapMessage({
    super.key,
    required this.message,
    required this.currentUserId,
    this.createdAt,
    required this.screenWidth,
  });

  final MapMessageModel message;
  final String currentUserId;
  final DateTime? createdAt;
  final double screenWidth;

  @override
  State<MapMessage> createState() => _MapMessageState();
}

class _MapMessageState extends State<MapMessage> {
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('location'),
        position: LatLng(widget.message.lat, widget.message.long),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: AppSizeExt.of.majorScale(50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizeExt.of.majorScale(2)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppSizeExt.of.majorScale(4))),
              child: Align(
                alignment: Alignment.bottomRight,
                heightFactor: 0.3,
                widthFactor: 2.5,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(widget.message.lat, widget.message.long),
                      zoom: 15),
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  liteModeEnabled: true,
                  markers: markers,
                ),
              ),
            ),
          ),
          SizedBox(
            height: AppSizeExt.of.majorScale(2),
          ),
          AppTextBodyMediumWidget()
              .setText(widget.message.name)
              .setTextStyle(TextStyle(
                fontWeight: FontWeight.bold,
                color: widget.currentUserId == widget.message.author.id
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline,
              ))
              .build(context),
          SizedBox(
            height: AppSizeExt.of.majorScale(2),
          ),
          AppButtonFilledWidget()
              .setButtonText(R.strings.openLocation)
              .setTextStyle(
                  TextStyle(color: Theme.of(context).colorScheme.background))
              .setOnPressed(() async {
            await launchUrl(Uri.parse(
                'https://www.google.com/maps/search/?api=1&query=${widget.message.lat},${widget.message.long}'));
          }).build(context)
        ],
      ),
    );
  }
}
