import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_brain/core/api_error_result_model.dart';
import 'package:second_brain/core/api_result_state.dart';
import 'package:second_brain/core/base_components/base_view.dart';
import 'package:second_brain/core/extension_function.dart';
import 'package:second_brain/core/weather_feature/weather_req_model.dart';
import 'package:second_brain/domain/entities/user_entities.dart';
import 'package:second_brain/domain/entities/weather_remote_entities.dart';
import 'package:second_brain/presentation/cubit/user_cubit.dart';
import 'package:second_brain/presentation/models/weather_view_model.dart';
import 'package:second_brain/presentation/widgets/dividers.dart';
import 'package:second_brain/presentation/widgets/icon.dart';
import 'package:second_brain/presentation/widgets/texts.dart';
import 'package:second_brain/themes/icons.dart';

class WeatherWidget extends StatefulWidget {
  final WeatherInfoEntity? weatherInfoEntity;
  const WeatherWidget({
    super.key,
    this.weatherInfoEntity,
  });

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  WeatherInfoEntity? _result;

  /// Private method to get Weather Data from coordinates
  Future<void> _getWeatherData(WeatherViewModel provider,
      WeatherByCityReqModel? weatherByCityReqModel) async {
    if (weatherByCityReqModel == null) return;
    await provider.getWeatherByCity(
      weatherByCityReqModel: weatherByCityReqModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserEntity?>(
      builder: (context, state) {
        return BaseView<WeatherViewModel>(
          onInitState: (WeatherViewModel provider) async {
            provider.weatherResult.stream
                .listen((ApiResultState<WeatherInfoEntity?>? result) {
              result?.when(
                data: (WeatherInfoEntity? data) {
                  if (!mounted) {
                    return;
                  }
                  if (state?.cityName == null) {
                    return;
                  }
                  setState(() {
                    _result = data;
                  });
                },
                error: (ApiErrorResultModel err) {
                  // Todo: Remove the print
                  print(err);
                },
              );
            });
            if (widget.weatherInfoEntity == null) {
              await _getWeatherData(
                  provider,
                  WeatherByCityReqModel(
                    city: state?.cityName,
                    keyID: state?.openWeatherkey,
                  ));
            }
          },
          buildWidget: (WeatherViewModel provider) {
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              onRefresh: () async {
                _getWeatherData(
                    provider,
                    WeatherByCityReqModel(
                      city: state?.cityName,
                      keyID: state?.openWeatherkey,
                    ));
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  if (_result != null)
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Row(
                          children: [
                            // weather Status
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  // Weather Status
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: (_result?.weathers?[0]?.icon !=
                                                  null)
                                              ? Image.network(
                                                  'https://openweathermap.org/img/w/${_result?.weathers?[0]?.icon}.png',
                                                  fit: BoxFit.contain,
                                                )
                                              : Image.asset(
                                                  'assets/icons/weather_unknown.svg',
                                                  fit: BoxFit.contain,
                                                ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: AutoSizeText(
                                            _result?.weathers?[0]
                                                    ?.description ??
                                                'No description',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                              fontSize: 42,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: AutoSizeText(
                                            _result?.main?.tempMin ?? '??°C',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                              fontSize: 24,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                        MyDivider(
                                          vertical: true,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          marge: 10,
                                          identFactor: 33,
                                        ),
                                        Flexible(
                                          child: AutoSizeText(
                                            _result?.main?.temp ?? '??°C',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                              fontSize: 42,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                        MyDivider(
                                          vertical: true,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          marge: 10,
                                          identFactor: 33,
                                        ),
                                        Flexible(
                                          child: AutoSizeText(
                                            _result?.main?.tempMax ?? '??°C',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                              fontSize: 24,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Humidity / Pressur / visibility
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Flexible(
                                          child: SingleWeatherDataWidget(
                                            text: (_result?.main?.humidity !=
                                                    null)
                                                ? "${_result?.main?.humidity}%"
                                                : "??%",
                                            icon: humidityIcon,
                                          ),
                                        ),
                                        Flexible(
                                          child: SingleWeatherDataWidget(
                                            text: (_result?.main?.pressure !=
                                                    null)
                                                ? "${_result?.main?.pressure}hPa"
                                                : "??hPa",
                                            icon: barometerIcon,
                                          ),
                                        ),
                                        Flexible(
                                          child: SingleWeatherDataWidget(
                                            text: (_result?.visibility != null)
                                                ? "${_result?.visibility}"
                                                : "??Km",
                                            icon: eyeIcon,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Suns, Wind, CLouds
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: SunriseWidget(
                                        sunData: _result?.sys,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: WindsWidget(
                                        windsData: _result?.wind,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: CloudsWidget(
                                        cloudsData: _result?.clouds,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        GradientText(
                          _result?.name ?? 'No city',
                        ),
                      ],
                    )
                  else
                    Center(
                      child: Text(
                        'No Weather ...',
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class SunriseWidget extends StatelessWidget {
  final WeatherSunsetSunriseEntity? sunData;
  const SunriseWidget({
    super.key,
    this.sunData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          flex: 1,
          child: sunriseIcon,
        ),
        Expanded(
          flex: 1,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AutoSizeText(
                    (sunData?.sunrise != null) ? '${sunData?.sunrise}' : '??',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 24,
                    ),
                    maxFontSize: 24,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AutoSizeText(
                    (sunData?.sunset != null) ? '${sunData?.sunset}' : '??',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 24,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class WindsWidget extends StatelessWidget {
  final WeatherWindInfoEntity? windsData;
  const WindsWidget({
    super.key,
    this.windsData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          flex: 1,
          child: windIcon,
        ),
        Expanded(
          flex: 1,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AutoSizeText(
                    (windsData?.speed != null) ? '${windsData?.speed}' : '??',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 24,
                    ),
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AutoSizeText(
                    windsData?.deg?.fromDegreeToWindDirection() ?? '??',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 24,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CloudsWidget extends StatelessWidget {
  final WeatherCloudsInfoEntity? cloudsData;
  const CloudsWidget({
    super.key,
    this.cloudsData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          flex: 1,
          child: cloudsIcon,
        ),
        Expanded(
          flex: 1,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AutoSizeText(
                    (cloudsData?.all != null) ? '${cloudsData?.all}%' : '??',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 24,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SingleWeatherDataWidget extends StatelessWidget {
  final String text;
  final MyIcon icon;
  const SingleWeatherDataWidget({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: AutoSizeText(
              text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                fontSize: 36,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
