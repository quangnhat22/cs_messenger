import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_object_result_raw.dart';
part 'app_response.dart';
part 'history_call_raw.dart';
part 'base_raw.freezed.dart';
part 'base_raw.g.dart';

abstract class BaseRaw<BM extends BaseModel> {
  BM raw2Model();
}

class EmptyRaw extends BaseRaw<EmptyModel> {
  @override
  EmptyModel raw2Model() {
    return EmptyModel();
  }
}
