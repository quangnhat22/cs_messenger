import 'package:domain/src/params/base_param.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:resources/resources.dart';

part 'app_exception.dart';
part 'app_result_model.dart';
part 'auth/email_verify_model.dart';
part 'auth/status_verify_email_model.dart';
part 'auth/token_model.dart';
part 'auth/welcome_model.dart';
part 'device/device_id_model.dart';
part 'group/group_model.dart';
part 'history_call_model.dart';
part 'message/audio_message_model.dart';
part 'message/date_header_model.dart';
part 'message/emoji_sticker_model.dart';
part 'message/file_message_model.dart';
part 'message/image_message_model.dart';
part 'message/imessage_model.dart';
part 'message/map_message_model.dart';
part 'message/preview_data_model.dart';
part 'message/system_message_model.dart';
part 'message/text_message_model.dart';
part 'message/video_message_model.dart';
part 'request_model.dart';
part 'search/search_model.dart';
part 'setting/language_model.dart';
part 'setting/theme_model.dart';
part 'user/relation_model.dart';
part 'user/user_model.dart';

abstract class BaseModel {}

class EmptyModel extends BaseModel {}
