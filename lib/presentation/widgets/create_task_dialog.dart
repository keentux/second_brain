import 'package:flutter/material.dart';
import 'package:second_brain/presentation/widgets/buttons.dart';
import 'package:second_brain/presentation/widgets/text_form_field.dart';

Widget buildCreateTaskDialog(BuildContext context) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameEditingController = TextEditingController();

  return Center(
    child: SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextFormField(
                hintText: 'Name of the task',
                labelText: 'Name',
                multiline: false,
                controller: nameEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Name';
                  }
                  return null;
                },
              ),
              const MyTextFormField(
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
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                          '"${nameEditingController.text}" has been created'),
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
