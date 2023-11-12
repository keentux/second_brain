import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

extension ExtensionsOnDouble on double? {
  /// Extend double to convert wind speed from double to wind speed in
  /// in String in Km/h: "50Km/h"
  String? toWindSpeed() {
    if (this != null) {
      return '${toString()}km/h';
    }
    return null;
  }

  /// Extend double to convert temperatur in Kelvin from double to temperatue
  /// in Celsius in String: "24°"
  String? toCelsius() {
    if (this != null) {
      final NumberFormat numberFormat = NumberFormat('###.##', 'en_US');
      final double value = this! - 273.15;
      return '${numberFormat.format(value)}°';
    }
    return null;
  }
}

extension ExtensionsOnInt on int? {
  /// Extend int to cenvert speed value in kilometer in String: '55KM'
  String? toKM() {
    if (this != null) {
      return '${(this! / 1000).round()}Km';
    }
    return null;
  }
}

extension ExtensionsOnNullableInt on int? {
  /// Convert from timestamp in nullable int to date in string "dd-MM-yyyy"
  String? fromTimestampToDate() {
    if (this != null) {
      final DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(this! * 1000);
      return DateFormat('dd-MM-yyyy').format(dateTime);
    }
    return null;
  }

  /// Convert from timestamp in nullable int to time in millisecond in string
  String? fromTimestampToTime() {
    if (this != null) {
      final DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(this! * 1000);
      return DateFormat.Hms().format(dateTime);
    }
    return null;
  }

  /// Convert wind degree direction (270) to meteorological direction (NO)
  String? fromDegreeToWindDirection() {
    if (this == null || this! > 360 || this! < 0) {
      return null;
    }
    String direction = '';
    switch (this!) {
      case >= 349 || < 11:
        direction = 'N';
        break;
      case >= 12 && <= 33:
        direction = 'NNE';
        break;
      case >= 34 && <= 56:
        direction = 'NE';
        break;
      case >= 57 && <= 78:
        direction = 'ENE';
        break;
      case >= 79 && <= 101:
        direction = 'E';
        break;
      case >= 102 && < 123:
        direction = 'ESE';
        break;
      case >= 124 && < 146:
        direction = 'SE';
        break;
      case >= 147 && < 168:
        direction = 'SSE';
        break;
      case >= 169 && < 191:
        direction = 'S';
        break;
      case >= 192 && < 213:
        direction = 'SSW';
        break;
      case >= 214 && < 236:
        direction = 'SW';
        break;
      case >= 237 && < 258:
        direction = 'WSW';
        break;
      case >= 259 && < 281:
        direction = 'W';
        break;
      case >= 282 && < 303:
        direction = 'WNW';
        break;
      case >= 304 && < 326:
        direction = 'NW';
        break;
      case >= 327 && < 348:
        direction = 'NNW';
        break;
    }
    return direction;
  }
}

extension ExtensionsOnString on String {
  /// Parse an Uri
  Uri parseUri({Map<String, dynamic>? params}) {
    return Uri.parse(
      this,
    ).replace(
      queryParameters: params?.map(
        (String key, dynamic value) => MapEntry<String, dynamic>(
          key,
          value.toString(),
        ),
      ),
    );
  }

  /// Compare txo string convert them in lowerCase
  bool isEqual(String? value) {
    return toLowerCase() == value?.toLowerCase();
  }
}

extension ExtensionsOnHttpResponse on Response {
  dynamic decodeJson() {
    return jsonDecode(body);
  }
}

extension ExtensionsOnDate on DateTime {
  bool isDateEqual(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  bool isMonthEqual(DateTime date) {
    return year == date.year && month == date.month;
  }
}
