import 'dart:convert';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_param.dart';
part 'auth/change_password_param.dart';
part 'auth/forgot_password_param.dart';
part 'auth/login_with_email_param.dart';
part 'auth/sign_up_param.dart';
part 'base_param.freezed.dart';
part 'base_param.g.dart';
part 'chat_room/get_list_chat_room_param.dart';
part 'chat_room/get_list_room_message_chat_room_param.dart';
part 'friends/get_list_call_history_param.dart';
part 'friends/get_list_friend_param.dart';
part 'group/create_new_group_param.dart';
part 'group/edit_group_param.dart';
part 'group/get_list_group_param.dart';
part 'group/get_list_member_param.dart';
part 'message/audio_message_param.dart';
part 'message/emoji_message_param.dart';
part 'message/file_message_param.dart';
part 'message/i_message_param.dart';
part 'message/image_message_param.dart';
part 'message/map_message_param.dart';
part 'message/preview_data_param.dart';
part 'message/socket_message_param.dart';
part 'message/text_message_param.dart';
part 'message/video_message_param.dart';
part 'request/action_request_param.dart';
part 'request/get_list_request_param.dart';
part 'request/sent_request_param.dart';
part 'search/search_param.dart';
part 'setting/theme_and_language_param.dart';
part 'user/update_user_self_param.dart';
part 'video_call/get_video_call_token_param.dart';

abstract class BaseParam {}
