import 'package:app/configs/di/di.dart';
import 'package:app/features/app/presentation/app.dart';
import 'package:configs/configs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:resources/resources.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Fsplash.preserve(widgetsBinding: WidgetsBinding.instance);
  configureAllPackagesDependencies();
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Fsplash.remove();
  runApp(const App());
}
