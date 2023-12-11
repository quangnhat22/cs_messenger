import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/room_chat/domain/usecases/send_message_usecase.dart';
import 'package:app/features/user/domain/usecases/profile/get_user_profile_local_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:utilities/utilities.dart';

part 'list_message_cubit.freezed.dart';
part 'list_message_state.dart';

@Injectable()
class ListMessageCubit extends Cubit<ListMessageState> {
  late final GetUserProfileLocalUseCase _getUserProfileLocalUseCase;
  late final SendMessageUseCase _sendMessageUseCase;

  ListMessageCubit(this._getUserProfileLocalUseCase, this._sendMessageUseCase)
      : super(const ListMessageState.initial());

  Future<void> initPage(String roomId) async {
    try {
      emit(state.copyWith(isLoading: true, roomId: roomId));
      final userResponse = await _getUserProfileLocalUseCase.executeObj();
      emit(state.copyWith(currentUser: userResponse.netData));

      await _getListMessages();
      emit(state.copyWith(isLoading: false));
    } on AppException catch (e) {
      Logs.e(e);
    }
  }

  Future<void> _getListMessages() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      List<IMessageModel> _messages = [
        TextMessageModel(
          id: '1',
          author: UserModel(id: '1'),
          content: '123',
          type: MessageType.text,
          createdAt: DateTime.now(),
          isMe: true,
          roomId: state.roomId,
        ),
        TextMessageModel(
          id: '2',
          author: UserModel(id: '1'),
          content: '123 https://source.unsplash.com/WBGjg0DsO_g/1920x1280',
          roomId: state.roomId,
          type: MessageType.text,
          createdAt: DateTime.now(),
          previewData: PreviewDataModel(
            title: 'hihi',
            description: '12122',
            link: 'https://source.unsplash.com/WBGjg0DsO_g/1920x1280',
            image:
                'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          ),
        ),
        ImageMessageModel(
          id: '3',
          author: UserModel(id: '2'),
          roomId: state.roomId,
          size: 18278,
          content:
              'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          uri:
              'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          type: MessageType.image,
          createdAt: DateTime.now(),
        ),
        SystemMessageModel(
          id: '4',
          content: 'Hello',
          author: UserModel(id: '2'),
          type: MessageType.system,
          createdAt: DateTime.now(),
          roomId: state.roomId,
        ),
        ImageMessageModel(
          id: '5',
          author: UserModel(id: '2'),
          size: 18278,
          content:
              'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          uri:
              'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          type: MessageType.image,
          roomId: state.roomId,
          createdAt: DateTime.now(),
        ),
        FileMessageModel(
          id: '6',
          author: UserModel(id: '2'),
          name: 'city-guide-image1872y1772717627627.png',
          roomId: state.roomId,
          size: 18278,
          content:
              'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          uri:
              'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          type: MessageType.file,
          isLoading: true,
        ),
        AudioMessageModel(
          id: '7',
          roomId: state.roomId,
          author: UserModel(id: '2'),
          name: 'city-guide-image1872y1772717627627.png',
          content:
              'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
          uri:
              'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
          type: MessageType.audio,
        ),
        MapMessageModel(
          id: '8',
          author: UserModel(id: '2'),
          roomId: state.roomId,
          lat: 37.4219983,
          long: -122.084,
          name:
              "P1600 Amphitheatre Pkwy, Amphitheatre Parkway ,Mountain View, California, United States",
          content:
              'P1600 Amphitheatre Pkwy, Amphitheatre Parkway ,Mountain View, California, United States',
          type: MessageType.map,
        ),
      ];
      emit(state.copyWith(listMessage: _messages));
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (_) {
            Logs.e(e);
          }).detected();
    }
  }

  Future<void> getMessagesTopPage() async {
    try {
      if (!state.isLastPage) {
        List<IMessageModel> _messages = [
          TextMessageModel(
            id: '11',
            author: UserModel(id: '1'),
            content: '123',
            type: MessageType.text,
            createdAt: DateTime.now(),
            isMe: true,
            roomId: state.roomId,
          ),
          TextMessageModel(
            id: '12',
            author: UserModel(id: '1'),
            content: '123 https://source.unsplash.com/WBGjg0DsO_g/1920x1280',
            roomId: state.roomId,
            type: MessageType.text,
            createdAt: DateTime.now(),
            previewData: PreviewDataModel(
              title: 'hihi',
              description: '12122',
              link: 'https://source.unsplash.com/WBGjg0DsO_g/1920x1280',
              image:
                  'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
            ),
          ),
          ImageMessageModel(
            id: '13',
            author: UserModel(id: '2'),
            roomId: state.roomId,
            size: 18278,
            content:
                'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
            uri:
                'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
            type: MessageType.image,
            createdAt: DateTime.now(),
          ),
          SystemMessageModel(
            id: '14',
            content: 'Hello',
            author: UserModel(id: '2'),
            type: MessageType.system,
            createdAt: DateTime.now(),
            roomId: state.roomId,
          ),
          ImageMessageModel(
            id: '15',
            author: UserModel(id: '2'),
            size: 18278,
            content:
                'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
            uri:
                'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
            type: MessageType.image,
            roomId: state.roomId,
            createdAt: DateTime.now(),
          ),
          FileMessageModel(
            id: '16',
            author: UserModel(id: '2'),
            name: 'city-guide-image1872y1772717627627.png',
            roomId: state.roomId,
            size: 18278,
            content:
                'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
            uri:
                'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
            type: MessageType.file,
            isLoading: true,
          ),
          AudioMessageModel(
            id: '17',
            roomId: state.roomId,
            author: UserModel(id: '2'),
            name: 'city-guide-image1872y1772717627627.png',
            content:
                'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
            uri:
                'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
            type: MessageType.audio,
          ),
          MapMessageModel(
            id: '18',
            author: UserModel(id: '2'),
            roomId: state.roomId,
            lat: 37.4219983,
            long: -122.084,
            name:
                "P1600 Amphitheatre Pkwy, Amphitheatre Parkway ,Mountain View, California, United States",
            content:
                'P1600 Amphitheatre Pkwy, Amphitheatre Parkway ,Mountain View, California, United States',
            type: MessageType.map,
          ),
        ];
        emit(state.copyWith(
          listMessage: [...state.listMessage, ..._messages],
          isLastPage: true,
        ));
      }
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (_) {
            Logs.e(e);
          }).detected();
    }
  }

  Future<void> getMessagesBottomPage() async {
    try {
      if (!state.isFirstPage) {
        List<IMessageModel> _messages = [
          // TextMessageModel(
          //   id: '21',
          //   author: UserModel(id: '1'),
          //   text: '123',
          //   type: MessageType.text,
          //   createdAt: DateTime.now(),
          // ),
          // TextMessageModel(
          //   id: '22',
          //   author: UserModel(id: '1'),
          //   text: '123 https://source.unsplash.com/WBGjg0DsO_g/1920x1280',
          //   type: MessageType.text,
          //   createdAt: DateTime.now(),
          //   previewData: PreviewDataModel(
          //     title: 'hihi',
          //     description: '12122',
          //     link: 'https://source.unsplash.com/WBGjg0DsO_g/1920x1280',
          //     image:
          //         'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          //   ),
          // ),
          // ImageMessageModel(
          //   id: '23',
          //   author: UserModel(id: '2'),
          //   size: 18278,
          //   uri:
          //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQF9C7kSBmqY1lRviFkXxR_SuCnKPDFOe_mpQ0n3ytO-rgD1Rm8xGRPtMQsubE-wsVwnb4&usqp=CAU',
          //   type: MessageType.image,
          //   createdAt: DateTime.now(),
          // ),
          // SystemMessageModel(
          //   id: '24',
          //   text: 'Hello',
          //   author: UserModel(id: '2'),
          //   type: MessageType.system,
          //   createdAt: DateTime.now(),
          // ),
          // ImageMessageModel(
          //   id: '25',
          //   author: UserModel(id: '2'),
          //   size: 18278,
          //   uri:
          //       'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          //   type: MessageType.image,
          //   createdAt: DateTime.now(),
          // ),
          // ImageMessageModel(
          //   id: '26',
          //   author: UserModel(id: '2'),
          //   size: 18278,
          //   uri:
          //       'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          //   type: MessageType.image,
          //   createdAt: DateTime.now(),
          // ),
          // ImageMessageModel(
          //   id: '27',
          //   author: UserModel(id: '2'),
          //   size: 18278,
          //   uri:
          //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQF9C7kSBmqY1lRviFkXxR_SuCnKPDFOe_mpQ0n3ytO-rgD1Rm8xGRPtMQsubE-wsVwnb4&usqp=CAU',
          //   type: MessageType.image,
          // ),
          // ImageMessageModel(
          //   id: '28',
          //   author: UserModel(id: '2'),
          //   size: 18278,
          //   uri:
          //       'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          //   type: MessageType.image,
          // ),
          // FileMessageModel(
          //   id: '29',
          //   author: UserModel(id: '2'),
          //   name: 'city-guide-image1872y1772717627627.png',
          //   size: 18278,
          //   uri:
          //       'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          //   type: MessageType.file,
          //   isLoading: true,
          // ),
          // AudioMessageModel(
          //   id: '30',
          //   author: UserModel(id: '2'),
          //   name: 'city-guide-image1872y1772717627627.png',
          //   uri:
          //       'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
          //   type: MessageType.audio,
          // ),
        ];
        emit(state.copyWith(
          listMessage: [..._messages, ...state.listMessage],
          isFirstPage: true,
        ));
      }
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (_) {
            Logs.e(e);
          }).detected();
    }
  }

  Future<void> sendTextMessage(TextMessageParam message) async {
    try {
      final messageParams =
          SocketMessageParam.convert2SocketMessageParam(message, state.roomId);
      _sendMessageUseCase.executeObj(request: messageParams);
      // if (state.currentUser == null) {
      //   return;
      // }
      //
      // final tempMessage = TextMessageModel.getTextMessageModelFromParam(
      //     message, state.currentUser!);
      //
      // emit(state.copyWith(listMessage: [tempMessage, ...state.listMessage]));
      //
      // // Future.delayed(const Duration(seconds: 2), () {
      // //   emit(state.copyWith(
      // //     listMessage: [...state.listMessage, _message],
      // //   ));
      // // });
    } on AppException catch (e) {}
  }
}
