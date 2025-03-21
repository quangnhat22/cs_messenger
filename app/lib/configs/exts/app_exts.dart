import 'dart:io';

import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/auth/domain/usecases/auth/force_logout_uc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

part 'app_constants_ext.dart';
part 'app_exception_ext.dart';
