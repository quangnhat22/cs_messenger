part of 'base_raw.dart';

@freezed
class HistoryCallRaw extends BaseRaw<HistoryCallModel> with _$HistoryCallRaw {
  HistoryCallRaw._();

  factory HistoryCallRaw({
    required int id,
    required String name,
  }) = _HistoryCallRaw;

  factory HistoryCallRaw.fromJson(Map<String, Object?> json) =>
      _$HistoryCallRawFromJson(json);

  @override
  HistoryCallModel raw2Model() {
    return HistoryCallModel(
      id: id,
      name: name,
    );
  }
}
