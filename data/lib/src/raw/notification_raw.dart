// part of 'base_raw.dart';
//
// @freezed
// class NotificationRaw extends BaseRaw<RequestModel> with _$RequestRaw {
//   NotificationRaw._();
//
//   factory NotificationRaw({
//     required String id,
//     UserRaw? sender,
//     UserRaw? receiver,
//     // ignore: invalid_annotation_target
//     @JsonKey(name: 'created_at') int? createdAt,
//   }) = _NotificationRaw;
//
//   factory NotificationRaw.fromJson(Map<String, Object?> json) =>
//       _$NotificationRawFromJson(json);
//
//   @override
//   RequestModel raw2Model() {
//     return RequestModel(
//       id: id,
//       sender: sender?.raw2Model(),
//       createdAt: createdAt != null
//           ? DateTimeExt.convertTimeStampToDateTime(createdAt!)
//           : null,
//       receiver: receiver?.raw2Model(),
//     );
//   }
// }
