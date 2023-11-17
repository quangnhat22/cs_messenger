import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:utilities/utilities.dart';

part 'app_object_result_raw.dart';
part 'app_response.dart';
part 'base_raw.freezed.dart';
part 'base_raw.g.dart';
part 'device_id_raw.dart';
part 'group_raw.dart';
part 'history_call_raw.dart';
part 'request_raw.dart';
part 'status_verify_email_raw.dart';
part 'token_raw.dart';
part 'user_raw.dart';
part 'welcome_raw.dart';

abstract class BaseRaw<BM extends BaseModel> {
  BM raw2Model();
}

class EmptyRaw extends BaseRaw<EmptyModel> {
  @override
  EmptyModel raw2Model() {
    return EmptyModel();
  }
}
