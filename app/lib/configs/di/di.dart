import 'package:data/data.dart' as data_di;
import 'package:domain/domain.dart' as domain_di;
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

void configureAllPackagesDependencies() {
  data_di.configureModuleDependencies(getIt);
  domain_di.configureModuleDependencies(getIt);
  configureDependencies();
}
