import 'package:app/components/features/message/chat.dart';
import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/features/room_chat/presentation/chat/controllers/list_message/list_message_cubit.dart';
import 'package:auto_route/annotations.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utilities/utilities.dart';

@RoutePage()
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<ListMessageCubit>()),
        ],
        child: AppMainPageWidget()
            .setAppBar(AppBarWidget().setTextTitle('Chat').build(context))
            .setResizeToAvoidBottomInset(true)
            .setBody(_body(context))
            .build(context));
  }

  Widget _body(BuildContext context) {
    List<IMessageModel> _messages = [
      TextMessageModel(
        id: '1',
        author: UserModel(id: '1'),
        text: '123',
        type: MessageType.text,
        createdAt: DateTime.now(),
      ),
      TextMessageModel(
        id: '2',
        author: UserModel(id: '1'),
        text: '123 https://source.unsplash.com/WBGjg0DsO_g/1920x1280',
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
        size: 18278,
        uri:
            'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
        type: MessageType.image,
        createdAt: DateTime.now(),
      ),
      SystemMessageModel(
        id: '4',
        text: 'Hello',
        author: UserModel(id: '2'),
        type: MessageType.system,
        createdAt: DateTime.now(),
      ),
      ImageMessageModel(
        id: '5',
        author: UserModel(id: '2'),
        size: 18278,
        uri:
            'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
        type: MessageType.image,
        createdAt: DateTime.now(),
      ),
      ImageMessageModel(
        id: '6',
        author: UserModel(id: '2'),
        size: 18278,
        uri:
            'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
        type: MessageType.image,
        createdAt: DateTime.now(),
      ),
      ImageMessageModel(
        id: '7',
        author: UserModel(id: '2'),
        size: 18278,
        uri:
            'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
        type: MessageType.image,
      ),
      ImageMessageModel(
        id: '8',
        author: UserModel(id: '2'),
        size: 18278,
        uri:
            'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
        type: MessageType.image,
      ),
      FileMessageModel(
        id: '9',
        author: UserModel(id: '2'),
        name: 'city-guide-image1872y1772717627627.png',
        size: 18278,
        uri:
            'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
        type: MessageType.file,
        isLoading: true,
      ),
    ];

    return Chat(
      currentUserId: '1',
      messages: _messages,
      onAttachmentPressed: () {},
      onMessageTap: (_, __) {},
      onPreviewDataFetched: (_, __) {},
      onSendPressed: (_) {},
      onEndReached: () async {
        await Future.delayed(const Duration(milliseconds: 1000)).then((value) {
          Logs.d('top scroll');
        });
      },
      onStartReached: () async {
        await Future.delayed(const Duration(milliseconds: 1000)).then((value) {
          Logs.d('bottom scroll');
        });
      },
      showUserAvatars: true,
      isLeftStatus: true,
    );
  }
}
