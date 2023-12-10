// import 'package:app/service/socket/socket_service.dart';
// import 'package:domain/domain.dart';
// import 'package:injectable/injectable.dart';

// abstract class AppSocketDataSource {
//   Future<AppObjResultModel<EmptyModel>> connetSocket(
//       {required Map<String, dynamic> query});
// }

// @Injectable(as: AppSocketDataSource)
// class AppSocketDataSourceImpl extends AppSocketDataSource {
//   final SocketService _socketService;

//   AppSocketDataSourceImpl(this._socketService);

//   @override
//   Future<AppObjResultModel<EmptyModel>> connetSocket() async {
//     final result = await _socketService.connetSocket(query: query);
//     return result;
//   }
// }