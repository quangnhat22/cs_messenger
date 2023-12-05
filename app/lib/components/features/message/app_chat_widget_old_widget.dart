// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
//
// import '../../../../domain/entities/message_entity.dart';
// import 'list_message_item.dart';
//
// class ListMessage extends StatefulWidget {
//   const ListMessage({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<ListMessage> createState() => _ListMessageState();
// }
//
// class _ListMessageState extends State<ListMessage> {
//   late final PagingController<String, MessageEntity> _pagingController =
//   PagingController(firstPageKey: "");
//
//   @override
//   void initState() {
//     _pagingController.addPageRequestListener((pageKey) {
//       if (mounted) {
//         context.read<ChatRoomBloc>().add(const ChatRoomNewMessageTopLoaded());
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ChatRoomBloc, ChatRoomState>(
//       listener: (context, state) {
//         state.whenOrNull(getChatRoomInfoSuccess:
//             (messages, _, __, ___, ____, _____, ______, isLatest, _______) {
//           _pagingController.itemList = messages;
//           if (isLatest) {
//             _pagingController.appendLastPage([]);
//           }
//         });
//       },
//       builder: (context, state) {
//         return state.maybeWhen(
//           getChatRoomInfoSuccess:
//               (messages, _, __, ___, ____, _____, ______, _______, ________) {
//             return PagedSliverList<String, MessageEntity>(
//               pagingController: _pagingController,
//               builderDelegate: PagedChildBuilderDelegate<MessageEntity>(
//                 noItemsFoundIndicatorBuilder: (context) {
//                   return Container();
//                 },
//                 newPageProgressIndicatorBuilder: (context) => Container(),
//                 firstPageProgressIndicatorBuilder: (context) => Container(),
//                 itemBuilder: (context, item, index) {
//                   final isMe = item.isMe ?? false;
//                   return Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       if (item.createdAt != null &&
//                           item.isSameDate != null &&
//                           item.isSameDate == false)
//                         Text(AppDateTimeFormat.convertToHourMinuteFollowDay(
//                             item.createdAt!)),
//                       Container(
//                         padding: const EdgeInsets.all(8.0),
//                         color: item.isResultSearch != null &&
//                             item.isResultSearch == true
//                             ? Theme.of(context).colorScheme.surfaceVariant
//                             : Colors.transparent,
//                         child: Row(
//                           mainAxisAlignment: item.type == 'system'
//                               ? MainAxisAlignment.center
//                               : isMe
//                               ? MainAxisAlignment.end
//                               : MainAxisAlignment.start,
//                           children: [
//                             MessageItem(
//                               isMe: isMe,
//                               message: item,
//                               isSendStatus: item.sendStatus,
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             );
//           },
//           orElse: () => const SliverToBoxAdapter(child: ListSkeleton()),
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _pagingController.dispose();
//     super.dispose();
//   }
// }
