part of 'base_param.dart';

@JsonSerializable()
@CopyWith()
class AppParam extends BaseParam {
  final int page;
  final int pageSize;

  AppParam({this.page = 1, this.pageSize = 10});

  Map<String, dynamic> get toJson => _$AppParamToJson(this);
}
