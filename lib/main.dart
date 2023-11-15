import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:second_brain/domain/entities/user_entities.dart';
import 'package:second_brain/presentation/cubit/task_cubit.dart';
import 'package:second_brain/presentation/cubit/user_cubit.dart';
import 'package:second_brain/presentation/models/weather_view_model.dart';
import 'package:second_brain/presentation/pages/agenda_page.dart';
import 'package:second_brain/presentation/pages/home_page.dart';
import 'package:second_brain/presentation/pages/tasks_page.dart';
import 'package:second_brain/presentation/pages/settings_page.dart';
import 'package:second_brain/presentation/widgets/buttons.dart';
import 'package:second_brain/presentation/widgets/task_dialog.dart';
import 'package:second_brain/presentation/widgets/user_dialog.dart';
import 'package:second_brain/themes/app_theme.dart';
import 'package:second_brain/themes/icons.dart';
import 'package:second_brain/utils/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initAppComponentLocator();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<UserCubit>()),
        BlocProvider(create: (_) => locator<TaskCubit>()),
      ],
      child: MaterialApp(
        title: 'Secondary Brain',
        theme: AppTheme.dark,
        home: const MyAppPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  int count = 0;

  /// Increase the count state
  void incCount() {
    count++;
    notifyListeners();
  }

  /// Decrease the count state
  void decCount() {
    notifyListeners();
    count--;
  }
}

class MyAppPage extends StatefulWidget {
  final UserEntity? userData;
  const MyAppPage({super.key, this.userData});

  @override
  State<MyAppPage> createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {
  int currIdx = 0;
  final double minExtendedRail = 150;
  final double minRail = 56;
  final double minPageWidth = 600.0;
  final double minPageHeight = 600.0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (currIdx) {
      case 0:
        page = const HomePage();
        break;
      case 1:
        page = const TasksPage();
        break;
      case 2:
        page = const AgendaPage();
        break;
      case 3:
        page = const SettingsPage();
        break;
      default:
        throw UnimplementedError('No widget for $currIdx');
    }

    context.read<UserCubit>().getLastUser();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => locator<WeatherViewModel>(),
        )
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          Size screenSize = MediaQuery.of(context).size;
          final double maxPageHeight = max(screenSize.height, minPageHeight);
          return Scaffold(
            body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.onSecondary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    SafeArea(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        controller: ScrollController(),
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraints.maxHeight),
                          child: IntrinsicHeight(
                            child: NavigationRail(
                              leading: SizedBox(
                                height: minRail,
                                width: minRail,
                                child: SvgPicture.asset(
                                  'assets/logos/snd_brain_logo.svg',
                                  colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.tertiary,
                                      BlendMode.srcIn),
                                ),
                              ),
                              trailing: Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 20,
                                      left: 8,
                                      right: 8,
                                    ),
                                    child: BlocBuilder<UserCubit, UserEntity?>(
                                      builder: (context, state) {
                                        return MyIconButton(
                                          icon: (state != null)
                                              ? addIcon
                                              : userAddIcon,
                                          onPressed: () {
                                            if (state != null) {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        buildCreateTaskDialog(
                                                            context),
                                              );
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        buildCreateUserDialog(
                                                  context,
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              minExtendedWidth: minExtendedRail,
                              minWidth: minRail,
                              extended:
                                  constraints.maxWidth >= 10 * minExtendedRail,
                              destinations: const [
                                NavigationRailDestination(
                                  icon: homeIcon,
                                  selectedIcon: homeIconPlain,
                                  label: Text('Home'),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                ),
                                NavigationRailDestination(
                                  icon: noteIcon,
                                  selectedIcon: noteIconPlain,
                                  label: Text('Tasks'),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                ),
                                NavigationRailDestination(
                                  icon: calendarIcon,
                                  selectedIcon: calendartIconPlain,
                                  label: Text('Agenda'),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                ),
                                NavigationRailDestination(
                                  icon: settingsIcon,
                                  selectedIcon: settingsIconPlain,
                                  label: Text('Settings'),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                ),
                              ],
                              selectedIndex: currIdx,
                              onDestinationSelected: (value) {
                                setState(() {
                                  currIdx = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Theme.of(context).colorScheme.onPrimary,
                              Theme.of(context).colorScheme.primary,
                            ],
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: LayoutBuilder(builder: (context, constraints) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    max(constraints.maxWidth, minPageWidth),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: maxPageHeight,
                                  ),
                                  child: page,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}
