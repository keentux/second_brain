// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:second_brain/core/api_call_helper.dart' as _i7;
import 'package:second_brain/core/connectivity_helper.dart' as _i4;
import 'package:second_brain/core/di/app_module.dart' as _i14;
import 'package:second_brain/data/datasources/local_datasource/local_database.dart'
    as _i3;
import 'package:second_brain/data/datasources/local_datasource/weather_local_datasource.dart'
    as _i5;
import 'package:second_brain/data/datasources/local_datasource/weather_local_datasource_impl.dart'
    as _i6;
import 'package:second_brain/data/datasources/remote_datasource/weather_remote_datasource.dart'
    as _i8;
import 'package:second_brain/data/datasources/remote_datasource/weather_remote_datasource_impl.dart'
    as _i9;
import 'package:second_brain/data/repositories/weather_repository_impl.dart'
    as _i11;
import 'package:second_brain/domain/repositories/weather_repository.dart'
    as _i10;
import 'package:second_brain/domain/usecases/get_weather_data.dart' as _i12;
import 'package:second_brain/presentation/models/weather_view_model.dart'
    as _i13;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i3.AppLocalDatabase>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<_i4.ConnectivityCheckerHelper>(
        () => _i4.ConnectivityCheckerHelper());
    gh.factory<_i5.WeatherLocalDataSource>(
        () => _i6.WeatherLocalDataSourceImpl(gh<_i3.AppLocalDatabase>()));
    gh.factory<_i7.ApiCallHelper>(
        () => _i7.ApiCallHelper(gh<_i4.ConnectivityCheckerHelper>()));
    gh.factory<_i8.WeatherRemoteDataSource>(
        () => _i9.WeatherRemoteDataSourceImpl(gh<_i7.ApiCallHelper>()));
    gh.factory<_i10.WeatherRepository>(() => _i11.WeatherRepositoryImpl(
          remoteDataSource: gh<_i8.WeatherRemoteDataSource>(),
          localDataSource: gh<_i5.WeatherLocalDataSource>(),
        ));
    gh.factory<_i12.GetAllLocalWeathers>(
        () => _i12.GetAllLocalWeathers(gh<_i10.WeatherRepository>()));
    gh.factory<_i12.GetWeatherDataByCity>(
        () => _i12.GetWeatherDataByCity(gh<_i10.WeatherRepository>()));
    gh.factory<_i12.GetWeatherDataByCoord>(
        () => _i12.GetWeatherDataByCoord(gh<_i10.WeatherRepository>()));
    gh.factory<_i13.WeatherViewModel>(
        () => _i13.WeatherViewModel(gh<_i12.GetWeatherDataByCoord>()));
    return this;
  }
}

class _$AppModule extends _i14.AppModule {}
