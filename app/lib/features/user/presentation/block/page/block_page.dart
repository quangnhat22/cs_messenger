import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/features/user/presentation/block/controllers/block_list_cubit.dart';
import 'package:app/features/user/presentation/block/controllers/cubit_action_block/action_block_cubit.dart';
import 'package:app/features/user/presentation/block/widgets/list_block_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class BlockPage extends StatelessWidget {
  const BlockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<GetListBlockCubit>(),
          ),
          BlocProvider(
            create: (_) => getIt<ActionBlockCubit>(),
          ),
        ],
        child: AppMainPageWidget()
            .setAppBar(AppBarWidget()
                .setTextTitle(R.strings.listUserBlock)
                .build(context))
            .setBody(_body(context))
            .build(context));
  }

  Widget _body(BuildContext context) {
    return const ListBlockWidget();
  }
}
