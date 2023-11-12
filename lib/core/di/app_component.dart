import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:second_brain/core/di/app_component.config.dart';

final GetIt locator = GetIt.I;

@InjectableInit(
  preferRelativeImports: false,
)
Future<void> initAppComponentLocator() async => locator.init();
