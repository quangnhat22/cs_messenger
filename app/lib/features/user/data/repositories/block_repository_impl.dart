import 'package:app/features/user/data/resources/remote/block_remote_data_src.dart';
import 'package:app/features/user/domain/repositories/block_repository.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BlockRepository)
class BlockRepositoryImpl extends BlockRepository {
  late final BlockRemoteDataSource _blockRemoteDataSource;

  BlockRepositoryImpl(this._blockRemoteDataSource);

  @override
  Future<AppObjResultModel<EmptyModel>> blockUser(
      {required Map<String, dynamic> query}) async {
    try {
      await _blockRemoteDataSource.blockUser(query: query);
      return AppObjResultModel(netData: EmptyModel());
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppListResultModel<UserModel>> getListUserBlock() async {
    try {
      final AppListResultRaw<UserRaw> remoteData =
          await _blockRemoteDataSource.getListBlock();
      return remoteData.raw2Model();
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> unBlockUser(
      {required Map<String, dynamic> query}) async {
    try {
      await _blockRemoteDataSource.unBlockUser(query: query);
      return AppObjResultModel(netData: EmptyModel());
    } on NetworkException catch (_) {
      rethrow;
    }
  }
}
