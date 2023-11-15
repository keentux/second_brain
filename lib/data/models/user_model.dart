import 'package:objectbox/objectbox.dart';
import 'package:second_brain/core/data_mapper.dart';
import 'package:second_brain/domain/entities/user_entities.dart';

@Entity()
class UserModel extends DataMapper<UserEntity> {
  int? id;
  @Index()
  @Unique(onConflict: ConflictStrategy.replace)
  final String uuid;
  final String? name;
  final String? cityName;
  final String? openWeatherKey;

  UserModel({
    this.id,
    required this.uuid,
    this.name,
    this.cityName,
    this.openWeatherKey,
  });

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uuid: entity.uuid,
      name: entity.name,
      cityName: entity.cityName,
      openWeatherKey: entity.openWeatherkey,
    );
  }

  @override
  UserEntity mapToEntity() {
    return UserEntity(
      uuid: uuid,
      name: name,
      cityName: cityName,
      openWeatherkey: openWeatherKey,
    );
  }
}
