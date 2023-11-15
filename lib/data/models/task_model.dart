import 'package:objectbox/objectbox.dart';
import 'package:second_brain/core/data_mapper.dart';
import 'package:second_brain/core/task_feature/task_status_enum.dart';
import 'package:second_brain/domain/entities/task_entity.dart';

@Entity()
class TaskModel extends DataMapper<TaskEntity> {
  int? id;
  @Index()
  @Unique(onConflict: ConflictStrategy.replace)
  final String uuid;
  final String owner;
  final String? title;
  final String? description;
  final int? status;

  TaskModel({
    this.id,
    required this.uuid,
    required this.owner,
    this.title,
    this.description,
    this.status,
  });

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      uuid: entity.uuid,
      owner: entity.owner,
      title: entity.title,
      description: entity.description,
      status: entity.status?.index,
    );
  }

  @override
  TaskEntity mapToEntity() {
    return TaskEntity(
      uuid: uuid,
      owner: owner,
      title: title,
      description: description,
      status: (status != null)
          ? TaskStatusEnum.values[status!]
          : TaskStatusEnum.none,
    );
  }
}
