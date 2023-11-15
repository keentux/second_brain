class WeatherByCoordReqModel {
  WeatherByCoordReqModel({
    this.lat,
    this.lon,
  });

  final double? lat;
  final double? lon;
}

class WeatherByCityReqModel {
  final String? keyID;
  final String? city;
  WeatherByCityReqModel({
    this.keyID,
    this.city,
  });
}
