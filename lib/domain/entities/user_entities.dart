import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class UserEntity extends Equatable {
  final String uuid;
  final String? name;
  final String? cityName;
  final String? openWeatherkey;

  UserEntity({
    String? uuid,
    this.name,
    this.cityName,
    this.openWeatherkey,
  }) : uuid = uuid ?? const Uuid().v4();

  @override
  List<Object?> get props => <Object?>[name, cityName, openWeatherkey];
}
