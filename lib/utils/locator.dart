import 'package:get_it/get_it.dart';
import 'package:second_brain/core/api_call_helper.dart';
import 'package:second_brain/core/connectivity_helper.dart';
import 'package:second_brain/data/datasources/local_datasource/local_database.dart';
import 'package:second_brain/data/datasources/local_datasource/task_datasource.dart';
import 'package:second_brain/data/datasources/local_datasource/user_datasource.dart';
import 'package:second_brain/data/datasources/local_datasource/weather_local_datasource.dart';
import 'package:second_brain/data/datasources/local_datasource/weather_local_datasource_impl.dart';
import 'package:second_brain/data/datasources/remote_datasource/weather_remote_datasource.dart';
import 'package:second_brain/data/datasources/remote_datasource/weather_remote_datasource_impl.dart';
import 'package:second_brain/data/repositories/task_repository_impl.dart';
import 'package:second_brain/data/repositories/user_repository_impl.dart';
import 'package:second_brain/data/repositories/weather_repository_impl.dart';
import 'package:second_brain/domain/repositories/task_repository.dart';
import 'package:second_brain/domain/repositories/user_repository.dart';
import 'package:second_brain/domain/repositories/weather_repository.dart';
import 'package:second_brain/domain/usecases/get_weather_data.dart';
import 'package:second_brain/domain/usecases/task_usecase.dart';
import 'package:second_brain/domain/usecases/user_usecases.dart';
import 'package:second_brain/presentation/cubit/task_cubit.dart';
import 'package:second_brain/presentation/cubit/user_cubit.dart';
import 'package:second_brain/presentation/models/weather_view_model.dart';

final locator = GetIt.instance;

Future<void> initDependencies() async {
  // db locator
  AppLocalDatabase db = await AppLocalDatabase.create();
  locator.registerSingleton<AppLocalDatabase>(db);

  // util locators
  locator.registerSingleton<ConnectivityCheckerHelper>(
    ConnectivityCheckerHelper(),
  );
  locator.registerSingleton<ApiCallHelper>(
    ApiCallHelper(
      locator<ConnectivityCheckerHelper>(),
    ),
  );

  // weather locators
  locator.registerSingleton<WeatherRemoteDataSource>(
    WeatherRemoteDataSourceImpl(
      locator<ApiCallHelper>(),
    ),
  );
  locator.registerSingleton<WeatherLocalDataSource>(
    WeatherLocalDataSourceImpl(
      locator<AppLocalDatabase>(),
    ),
  );
  locator.registerSingleton<WeatherRepository>(
    WeatherRepositoryImpl(
      remoteDataSource: locator<WeatherRemoteDataSource>(),
      localDataSource: locator<WeatherLocalDataSource>(),
    ),
  );
  locator.registerSingleton<GetWeatherDataByCity>(
    GetWeatherDataByCity(
      locator<WeatherRepository>(),
    ),
  );
  locator.registerSingleton<GetWeatherDataByCoord>(
    GetWeatherDataByCoord(
      locator<WeatherRepository>(),
    ),
  );
  locator.registerSingleton<WeatherViewModel>(
    WeatherViewModel(
      getWeatherDataByCoord: locator<GetWeatherDataByCoord>(),
      getWeatherDataByCity: locator<GetWeatherDataByCity>(),
    ),
  );

  // user Locators
  locator.registerSingleton<UserDataSource>(
    UserDataSource(
      locator<AppLocalDatabase>(),
    ),
  );
  locator.registerSingleton<UserRepository>(
    UserRepositoryImpl(
      dataSource: locator<UserDataSource>(),
    ),
  );
  locator.registerSingleton(
    CreateUser(
      locator<UserRepository>(),
    ),
  );
  locator.registerSingleton(
    GetUser(
      locator<UserRepository>(),
    ),
  );
  locator.registerSingleton(
    GetLastUser(
      locator<UserRepository>(),
    ),
  );
  locator.registerSingleton(
    UpdateUser(
      locator<UserRepository>(),
    ),
  );
  locator.registerSingleton(
    DeleteUser(
      locator<UserRepository>(),
    ),
  );
  locator.registerSingleton(
    ListUser(
      locator<UserRepository>(),
    ),
  );

  // task Locators
  locator.registerSingleton<TaskDataSource>(
    TaskDataSource(
      locator<AppLocalDatabase>(),
    ),
  );
  locator.registerSingleton<TaskRepository>(
    TaskRepositoryImpl(
      dataSource: locator<TaskDataSource>(),
    ),
  );
  locator.registerSingleton(
    CreateTask(
      locator<TaskRepository>(),
    ),
  );
  locator.registerSingleton(
    GatTask(
      locator<TaskRepository>(),
    ),
  );
  locator.registerSingleton(
    ListTaskUser(
      locator<TaskRepository>(),
    ),
  );
  locator.registerSingleton(
    UpdateTask(
      locator<TaskRepository>(),
    ),
  );
  locator.registerSingleton(
    DeleteTask(
      locator<TaskRepository>(),
    ),
  );
  locator.registerSingleton(
    DeleteTasksUser(
      locator<TaskRepository>(),
    ),
  );

  //Cubits locator
  locator.registerSingleton<UserCubit>(
    UserCubit(),
  );
  locator.registerSingleton<TaskCubit>(
    TaskCubit(),
  );
}
