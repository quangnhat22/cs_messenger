import 'package:app/features/group/data/resources/group_remote_data_source.dart';
import 'package:app/features/group/domain/repositories/group_repository.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GroupRepository)
class GroupRepositoryImpl extends GroupRepository {
  final GroupRemoteDataSource _remote;

  GroupRepositoryImpl(this._remote);

  @override
  Future<AppListResultModel<GroupModel>> getListGroup(
      {required Map<String, dynamic> query}) async {
    try {
      final AppListResultRaw<GroupRaw> remoteData =
          await _remote.fetchListGroup(query: query);
      return remoteData.raw2Model();
    } on NetworkException catch (_) {
      rethrow;
    }
  }
}
