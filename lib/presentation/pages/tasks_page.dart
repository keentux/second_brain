import 'package:flutter/material.dart';
import 'package:second_brain/presentation/widgets/table.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return const TaskTableWidget();
  }
}
