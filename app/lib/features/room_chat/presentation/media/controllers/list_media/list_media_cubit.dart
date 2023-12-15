import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_media_cubit.freezed.dart';
part 'list_media_state.dart';

class ListMediaCubit extends Cubit<ListMediaState> {
  ListMediaCubit() : super(const ListMediaState.initial());
}
