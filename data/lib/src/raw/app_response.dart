part of 'base_raw.dart';

class Metadata {
  final int? statusCode;
  final String? code;
  final String? message;

  Metadata({
    this.statusCode,
    this.code,
    this.message,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        statusCode: json["statusCode"] ?? 0,
        code: json["code"]?.toString() ?? json["message"],
        message: json["message"] ?? '',
      );
}

class AppResponse {
  late final Metadata? meta;
  final dynamic data;
  final dynamic extra;
  final int page;
  final int limit;
  final bool hasMore;
  final int total;

  AppResponse({
    this.meta,
    this.data,
    this.extra,
    this.page = 1,
    this.total = 0,
    this.hasMore = false,
    this.limit = 25,
  });

  factory AppResponse.fromJson(Map<String, dynamic> json) {
    return AppResponse(
      meta: Metadata.fromJson(json['metadata']),
      data: json['result']?['data'] ?? {},
    );
  }

  static AppResponse fromJsonToList(Map<String, dynamic> json) {
    return AppResponse(
      meta: Metadata.fromJson(json['metadata']),
      data: json['result']['data'] ?? List.empty(),
      extra: json['result']['extra'],
      page: json['result']['meta']['page'] ?? 0,
      limit: json['result']['meta']['pageSize'] ?? 25,
      hasMore: json['result']['meta']['hasNextPage'] ?? false,
      total: json['result']['meta']['total'] ?? 0,
    );
  }

  AppObjResultRaw<BR> toRaw<BR extends BaseRaw>(
          BR? Function(dynamic data) netDataFunc) =>
      AppObjResultRaw<BR>(netData: netDataFunc(data));

  AppListResultRaw<BR> toRawList<BR extends BaseRaw>(
          List<BR> Function(dynamic data) netDataFunc) =>
      AppListResultRaw<BR>(
          netData: netDataFunc(data), hasMore: hasMore, total: total);
}
