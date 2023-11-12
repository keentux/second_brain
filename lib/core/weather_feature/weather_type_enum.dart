import 'package:second_brain/domain/entities/weather_remote_entities.dart';
import 'package:second_brain/themes/color.dart';

enum WeatherTypeEnum {
  thunderstorm,
  drizzle,
  rain,
  snow,
  clear,
  clouds,
  other,
}

extension WeatherTypeEnumExtension on String? {
  WeatherTypeEnum? toWeatherType() {
    WeatherTypeEnum? value;
    switch (this) {
      case 'thunderstorm':
        value = WeatherTypeEnum.thunderstorm;
        break;
      case 'drizzle':
        value = WeatherTypeEnum.drizzle;
        break;
      case 'snow':
        value = WeatherTypeEnum.snow;
        break;
      case 'rain':
        value = WeatherTypeEnum.rain;
        break;
      case 'clear':
        value = WeatherTypeEnum.clear;
        break;
      case 'clouds':
        value = WeatherTypeEnum.clouds;
        break;
      default:
        value = WeatherTypeEnum.other;
        break;
    }
    return value;
  }
}

extension WeatherTypeEnumThemeExtension on WeatherTypeEnum? {
  WeatherThemeEntity? toWeatherTheme() {
    WeatherThemeEntity? value;
    switch (this) {
      case WeatherTypeEnum.thunderstorm:
      case WeatherTypeEnum.clouds:
      case WeatherTypeEnum.rain:
        value = WeatherThemeEntity(
          firstColor: blue,
          secondColor: lightBlue,
        );
        break;
      case WeatherTypeEnum.drizzle:
      case WeatherTypeEnum.snow:
        value = WeatherThemeEntity(
          firstColor: cyan,
          secondColor: cyanLight,
        );
        break;
      case WeatherTypeEnum.clear:
        value = WeatherThemeEntity(
          firstColor: orange,
          secondColor: yellow,
        );
        break;
      case WeatherTypeEnum.other:
        value = WeatherThemeEntity(
          firstColor: grey,
          secondColor: lightGrey,
        );
        break;
      default:
        value = WeatherThemeEntity(
          firstColor: blue,
          secondColor: lightBlue,
        );
        break;
    }
    return value;
  }
}
