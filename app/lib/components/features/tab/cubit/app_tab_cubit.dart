import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_tab_state.dart';

class AppTabCubit extends Cubit<AppTabState> {
  AppTabCubit() : super(AppTabInitial());
}
