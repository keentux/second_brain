import 'package:flutter/material.dart';
import 'package:second_brain/presentation/widgets/card.dart';
import 'package:second_brain/presentation/widgets/table.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  //Todo: Get tasks from database and parse from status
  // ----
  final List<MyDescriptedCard> toDoCards = const <MyDescriptedCard>[
    MyDescriptedCard(
      title: 'task to do',
      description: 'Need to do this',
    ),
    MyDescriptedCard(
      title: 'Second task to do',
      description: 'Another Task in the todo list',
    ),
  ];
  final List<MyDescriptedCard> inProgressCards = const <MyDescriptedCard>[
    MyDescriptedCard(
      title: 'Create the project',
      description: 'This task is in progress',
    ),
  ];
  final List<MyDescriptedCard> doneCards = const <MyDescriptedCard>[
    MyDescriptedCard(
      title: 'Start the app',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus blandit luctus dignissim. Phasellus a auctor purus. Duis blandit purus a dapibus lobortis. Curabitur efficitur ex nulla, pretium dignissim neque tincidunt ac. Nam at ex purus. Curabitur dolor odio, placerat vitae volutpat quis, vulputate at orci. Etiam dictum, metus nec hendrerit lacinia, risus lacus sollicitudin ipsum, ut imperdiet diam mi et risus. Vivamus leo metus, aliquet nec mattis vel, pulvinar a magna. Morbi hendrerit ac ipsum vitae feugiat. Proin laoreet placerat mi eu ornare. Donec accumsan felis vel neque tristique ultrices. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam volutpat lectus in arcu auctor gravida. Phasellus porttitor quam ut elit efficitur scelerisque. Cras vitae purus pellentesque, egestas est at, laoreet orci. Cras ultricies ante at lorem auctor feugiat.',
    ),
  ];
  // ----

  @override
  Widget build(BuildContext context) {
    return TaskTableWidget(
      todoWidgets: toDoCards,
      inProgressWidgets: inProgressCards,
      doneWidgets: doneCards,
    );
  }
}
