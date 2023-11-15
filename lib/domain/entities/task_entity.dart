import 'package:equatable/equatable.dart';
import 'package:second_brain/core/task_feature/task_status_enum.dart';
import 'package:uuid/uuid.dart';

class TaskEntity extends Equatable {
  final String uuid;
  final String? title;
  final String? description;
  final TaskStatusEnum? status;
  final String owner;

  TaskEntity({
    String? uuid,
    required this.owner,
    this.title,
    this.description,
    this.status,
  }) : uuid = uuid ?? const Uuid().v4();

  @override
  List<Object?> get props => <Object?>[title, status];
}
