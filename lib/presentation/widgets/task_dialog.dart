import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:second_brain/core/task_feature/task_status_enum.dart';
import 'package:second_brain/domain/entities/task_entity.dart';
import 'package:second_brain/domain/entities/user_entities.dart';
import 'package:second_brain/presentation/cubit/task_cubit.dart';
import 'package:second_brain/presentation/cubit/user_cubit.dart';
import 'package:second_brain/presentation/widgets/buttons.dart';
import 'package:second_brain/presentation/widgets/text_form_field.dart';
import 'package:second_brain/utils/locator.dart';

Widget buildCreateTaskDialog(BuildContext context) {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  return Center(
    child: SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: FormBuilder(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextFormField(
                name: 'title',
                hintText: 'Title of the task',
                labelText: 'Title',
                multiline: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Title';
                  }
                  return null;
                },
                isFocused: true,
              ),
              const MyTextFormField(
                name: 'description',
                hintText: "Description of the task",
                labelText: "Description",
                multiline: true,
              ),
            ],
          ),
        ),
        title: const Center(child: Text('Create a Task')),
        actions: <Widget>[
          InkWell(
            child: const Text('Cancel'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          MyGoodTextButton(
            text: 'Create',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState?.saveAndValidate();
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    final UserEntity? stateUser =
                        context.watch<UserCubit>().state;
                    if (stateUser == null) {
                      return AlertDialog(
                        content: const Text('Missing an user to create a Task'),
                        actions: [
                          InkWell(
                            child: const Text('OK'),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    }
                    FormBuilderState? formState = formKey.currentState;
                    locator<TaskCubit>().createTask(TaskEntity(
                      owner: stateUser.uuid,
                      title: formState?.getRawValue('title'),
                      description: formState?.getRawValue('description'),
                      status: TaskStatusEnum.todo,
                    ));
                    return AlertDialog(
                      content: Text(
                          '"${formState?.getRawValue('title')}" has been created'),
                      actions: [
                        InkWell(
                          child: const Text('OK'),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    ),
  );
}

Widget buildDeleteTaskDialog(BuildContext context, TaskEntity task) {
  return AlertDialog(
    content: Row(
      children: [
        const Text('Are you sure to remove the task '),
        Text(
          task.title ?? '??',
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ],
    ),
    actions: [
      InkWell(
        child: const Text(
          'Cancel',
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      MyBadTextButton(
        text: 'Remove',
        onPressed: () {
          locator<TaskCubit>().deleteTask(task.uuid);
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

Widget builRenderTask(BuildContext context, TaskEntity task) {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  TaskEntity taskData = task;
  bool hasChanged = false;
  String? titleModified;
  String? descriptionModified;

  return StatefulBuilder(builder: (context, setState) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: max(450, 0.5 * MediaQuery.of(context).size.width),
            ),
            child: AlertDialog(
              content: FormBuilder(
                key: formKey,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormBuilderTextField(
                          name: 'title',
                          initialValue: titleModified ?? taskData.title ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (String? input) {
                            if (!hasChanged) {
                              setState(() {
                                hasChanged = true;
                                titleModified = input;
                              });
                            }
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description: ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 8, right: 8, top: 8),
                              child: FormBuilderTextField(
                                name: 'description',
                                initialValue: descriptionModified ??
                                    taskData.description ??
                                    '',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                                maxLines: null,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (String? input) {
                                  if (!hasChanged) {
                                    setState(() {
                                      hasChanged = true;
                                      descriptionModified = input;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Status: ',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color:
                                      Theme.of(context).colorScheme.onTertiary,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: FormBuilderDropdown(
                                name: 'status',
                                initialValue: taskData.status,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                isExpanded: true,
                                onChanged: (newStatus) {
                                  TaskEntity updatedTask = TaskEntity(
                                    owner: taskData.owner,
                                    uuid: taskData.uuid,
                                    title: taskData.title,
                                    description: taskData.description,
                                    status: newStatus,
                                  );
                                  locator<TaskCubit>().updateTask(updatedTask);
                                  setState(() => taskData = updatedTask);
                                },
                                items: [
                                  TaskStatusEnum.todo,
                                  TaskStatusEnum.inprogress,
                                  TaskStatusEnum.inreview,
                                  TaskStatusEnum.done,
                                ].map((option) {
                                  return DropdownMenuItem(
                                    value: option,
                                    child: Text(option.toStatusString()),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    MyFlattedIconButton(
                      assetPath: "assets/icons/trash.svg",
                      onPressed: () {
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              buildDeleteTaskDialog(context, taskData),
                        );
                      },
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: const Text('Back'),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    if (hasChanged)
                      FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: MyGoodTextButton(
                            text: 'Save',
                            onPressed: () {
                              formKey.currentState?.saveAndValidate();
                              TaskEntity updatedTask = TaskEntity(
                                owner: taskData.owner,
                                uuid: taskData.uuid,
                                title: formKey.currentState
                                        ?.getRawValue('title') ??
                                    taskData.title,
                                description: formKey.currentState
                                        ?.getRawValue('description') ??
                                    taskData.description,
                                status: formKey.currentState
                                        ?.getRawValue('status') ??
                                    taskData.status,
                              );
                              locator<TaskCubit>().updateTask(updatedTask);
                              Navigator.of(context).pop();

                              // setState(() => taskData = updatedTask);
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  });
}
