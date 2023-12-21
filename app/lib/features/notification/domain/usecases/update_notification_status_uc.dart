// import 'package:app/features/notification/domain/repositories/setting_notification_repository.dart';
// import 'package:domain/domain.dart';
// import 'package:injectable/injectable.dart';
//
// abstract class UpdateNotificationStatusUseCase
//     extends BaseUseCase<CreateNewGroupParam, EmptyModel> {}
//
// @Injectable(as: UpdateNotificationStatusUseCase)
// class UpdateNotificationStatusUseCaseImpl
//     extends UpdateNotificationStatusUseCase {
//   final SettingNotificationRepository _repo;
//
//   UpdateNotificationStatusUseCaseImpl(this._repo);
//
//   @override
//   Future<AppObjResultModel<EmptyModel>> executeObj(
//           {CreateNewGroupParam? request}) async =>
//       await _repo.updateNotificationReceiveStatus(
//           request: request?.toJson() ?? {});
// }
