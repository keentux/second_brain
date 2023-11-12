import 'package:flutter/material.dart';
import 'package:second_brain/core/app_constants.dart';
import 'package:second_brain/presentation/widgets/clock_digit.dart';
import 'package:second_brain/presentation/widgets/date_text.dart';
import 'package:second_brain/presentation/widgets/texts.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const GradientText(
                  appUserName,
                  fontSize: 42,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: ClockDigWidget(),
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: DateTextWidget(),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
