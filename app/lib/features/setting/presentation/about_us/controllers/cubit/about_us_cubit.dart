import 'package:app/configs/exts/app_exts.dart';
import 'package:configs/configs.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:utilities/utilities.dart';

part 'about_us_state.dart';
part 'about_us_cubit.freezed.dart';

@Injectable()
class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit() : super(const AboutUsState.initial());

  void initPage() async {
    try {
      final appInfo = await DeviceInfo.getDeviceInfo();
      emit(state.copyWith(
        appName: appInfo['appName'],
        appVersion: appInfo['appVersion'],
        emailContact: AppConstants.emailContact,
      ));
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e);
          }).detected();
    }
  }
}
