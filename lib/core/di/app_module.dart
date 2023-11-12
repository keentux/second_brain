import 'package:injectable/injectable.dart';
import 'package:second_brain/data/datasources/local_datasource/local_database.dart';

@module
abstract class AppModule {
  @preResolve
  Future<AppLocalDatabase> get prefs => AppLocalDatabase.create();
}
