import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_brain/domain/entities/user_entities.dart';
import 'package:second_brain/presentation/cubit/user_cubit.dart';
import 'package:second_brain/presentation/widgets/buttons.dart';
import 'package:second_brain/presentation/widgets/card.dart';
import 'package:second_brain/presentation/widgets/dividers.dart';
import 'package:second_brain/presentation/widgets/user_dialog.dart';

class SettingFieldWidget extends StatelessWidget {
  final String fieldTitle;
  final String? value;
  const SettingFieldWidget({super.key, required this.fieldTitle, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: AutoSizeText(
              '$fieldTitle:',
              maxLines: 1,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: AutoSizeText(
              value ?? '',
              maxLines: 1,
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingSectionWidget extends StatelessWidget {
  final String title;
  final List<Widget>? children;
  const SettingSectionWidget({
    super.key,
    required this.title,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 10),
          ),
          MyDivider(
            color: Theme.of(context).colorScheme.tertiary,
            identFactor: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: children ??
                  [
                    const SizedBox.shrink(),
                  ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double maxCardWidth = 500;
  double minCardWidth = 200;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minCardWidth,
          maxWidth: maxCardWidth,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
            MyCard(
              elevated: true,
              colorInversed: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<UserCubit, UserEntity?>(
                        builder: (context, state) {
                          return SettingSectionWidget(
                              title: 'user data',
                              children: (state != null)
                                  ? <Widget>[
                                      SettingFieldWidget(
                                        fieldTitle: 'username',
                                        value: state.name,
                                      ),
                                      SettingFieldWidget(
                                        fieldTitle: 'city',
                                        value: state.cityName,
                                      ),
                                      SettingFieldWidget(
                                        fieldTitle: 'openWeather Key ID',
                                        value: state.openWeatherkey,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          MyFlattedIconButton(
                                            assetPath: "assets/icons/trash.svg",
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        buildDeleteUserDialog(
                                                            context, state),
                                              );
                                            },
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                          // MyBadTextButton(
                                          //   text: 'Remove',
                                          //   onPressed: () {
                                          //     showDialog(
                                          //       context: context,
                                          //       builder:
                                          //           (BuildContext context) =>
                                          //               buildDeleteUserDialog(
                                          //                   context, state),
                                          //     );
                                          //   },
                                          // ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          MyGoodTextButton(
                                            text: 'Update',
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        buildUpdateUserDialog(
                                                  context,
                                                  state,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ]
                                  : <Widget>[
                                      AutoSizeText(
                                        'No user',
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiary,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Center(
                                        child: MyGoodTextButton(
                                          text: 'Create',
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  buildCreateUserDialog(
                                                context,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ]);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
