import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:second_brain/domain/entities/user_entities.dart';
import 'package:second_brain/presentation/cubit/user_cubit.dart';
import 'package:second_brain/presentation/widgets/buttons.dart';
import 'package:second_brain/presentation/widgets/text_form_field.dart';
import 'package:second_brain/utils/locator.dart';

enum UserActionOtion {
  create,
  update,
}

void _onChanged(dynamic val) {
// print(val.toString());
}

Widget buildDialog({
  required BuildContext context,
  required UserActionOtion userAction,
  UserEntity? userEntity,
}) {
  assert(userAction == UserActionOtion.create || userEntity != null);
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
                name: 'name',
                hintText: 'Name',
                labelText: 'Name',
                multiline: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Name';
                  }
                  return null;
                },
                onChanged: _onChanged,
                initialValue: userEntity?.name ?? '',
              ),
              MyTextFormField(
                name: 'city',
                hintText: 'City Name',
                labelText: 'City',
                multiline: false,
                onChanged: _onChanged,
                initialValue: userEntity?.cityName ?? '',
              ),
              MyTextFormField(
                name: 'weatherkeyID',
                hintText: 'OpenWeather Key',
                labelText: 'OpenWeather Key',
                multiline: false,
                onChanged: _onChanged,
                initialValue: userEntity?.openWeatherkey ?? '',
              ),
            ],
          ),
        ),
        title: Center(
          child: Text(
            (userAction == UserActionOtion.create)
                ? 'Create an User'
                : 'Update an User',
          ),
        ),
        actions: <Widget>[
          InkWell(
            child: const Text(
              'Cancel',
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          MyGoodTextButton(
            text: (userAction == UserActionOtion.create) ? 'Create' : 'Update',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState?.saveAndValidate();
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String? name = formKey.currentState?.getRawValue('name');
                    String? city = formKey.currentState?.getRawValue('city');
                    String? weatherKey =
                        formKey.currentState?.getRawValue('weatherkeyID');
                    print("Key: $weatherKey");
                    if (userAction == UserActionOtion.create) {
                      locator<UserCubit>().createUser(
                        UserEntity(
                          name: name,
                          cityName: city,
                          openWeatherkey: weatherKey,
                        ),
                      );
                    } else {
                      locator<UserCubit>().updateUser(
                        UserEntity(
                          uuid: userEntity!.uuid,
                          name: name,
                          cityName: city,
                          openWeatherkey: weatherKey,
                        ),
                      );
                    }
                    return AlertDialog(
                      content: Row(
                        children: [
                          Text(
                            name ?? 'An user',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          Text((userAction == UserActionOtion.create)
                              ? ' has been created'
                              : ' has been updated'),
                        ],
                      ),
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

Widget buildUpdateUserDialog(BuildContext context, UserEntity oldUser) {
  return buildDialog(
    context: context,
    userAction: UserActionOtion.update,
    userEntity: oldUser,
  );
}

Widget buildCreateUserDialog(BuildContext context) {
  return buildDialog(
    context: context,
    userAction: UserActionOtion.create,
  );
}

Widget buildDeleteUserDialog(BuildContext context, UserEntity user) {
  return AlertDialog(
    content: Row(
      children: [
        const Text('Are you sure to remove the user '),
        Text(
          user.name ?? '??',
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
          locator<UserCubit>().deleteUser(user);
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
