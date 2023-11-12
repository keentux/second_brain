import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:second_brain/themes/icons.dart';

class AgendaEntityWidget extends StatelessWidget {
  final String title;
  final List<Widget> iconWidget;
  const AgendaEntityWidget({
    super.key,
    required this.title,
    required this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: iconWidget,
            ),
          ),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: AutoSizeText(
                title,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AgendaMeetingWidget extends StatelessWidget {
  final String start;
  final String end;
  final String title;
  const AgendaMeetingWidget({
    super.key,
    required this.start,
    required this.end,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AgendaEntityWidget(
      title: title,
      iconWidget: [
        Text(
          start,
          style: TextStyle(
            fontSize: 8,
            fontStyle: FontStyle.italic,
            color: Theme.of(context).colorScheme.onTertiary,
          ),
          maxLines: 1,
        ),
        const SizedBox(
          width: 20,
          height: 20,
          child: calendarIcon,
        ),
        Text(
          end,
          style: TextStyle(
            fontSize: 8,
            fontStyle: FontStyle.italic,
            color: Theme.of(context).colorScheme.onTertiary,
          ),
          maxLines: 1,
        )
      ],
    );
  }
}

class AgendaTaskWidget extends StatelessWidget {
  final String title;
  const AgendaTaskWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AgendaEntityWidget(
      title: title,
      iconWidget: const [
        SizedBox(
          width: 20,
          height: 20,
          child: noteIcon,
        ),
      ],
    );
  }
}
