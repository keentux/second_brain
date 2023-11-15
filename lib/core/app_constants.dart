/// timeout request constants
const String appCommonErrorUnexpectedMessage =
    'Something went wrong please try again';
const int appTimeoutRequestStatusCode = 1000;

///  IOException request constants
const String appCommonConnectionFailedMessage =
    'No Internet. Please check your Connection';
const int appIoExceptionStatusCode = 900;

/// http client header constants

const String appAcceptLanguageKey = 'Accept-Language';
const String appAuthorisationKey = 'Authorization';
const String appBearerKey = 'Bearer ';
const String appContentTypeKey = 'Content-Type';
const String appContentTypeValue = 'application/json';
const String appContentMultipartTypeValue = 'multipart/form-data';

///This is the time limit for every api call
const Duration appTimeOutDuration = Duration(seconds: 20);

///The app base Url should be provided in this value
const String appOpenWeatherBaseUrl = 'https://api.openweathermap.org/data/2.5';

/// getWeather details uri's and header keys
const String appGetOpenWeatherDetails = '/weather';
const String appOpenWeatherKey = 'appid';
const String appOpenWeatherCityNameKey = 'q';
const String appOpenWeatherLatKey = 'lat';
const String appOpenWeatherLonKey = 'lon';

/// User Info
const String appUserName = "User";

/// Default to Paris city. Change for your city location
const double appUserCityLat = 48.8534;
const double appUserCityLon = 2.3488;

/// local database keys
const String appWeatherInfoTable = 'WeatherInfo';
