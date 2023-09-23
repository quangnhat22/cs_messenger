import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

@InjectableInit(initializerName: r'$initDomainModuleGetIt')
void configureModuleDependencies(GetIt getIt) => getIt.$initDomainModuleGetIt();
