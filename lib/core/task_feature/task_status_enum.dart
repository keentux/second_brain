enum TaskStatusEnum { todo, inprogress, inreview, done, none }

extension TaskStatusEnumExtension on String? {
  TaskStatusEnum? toTaskStatusType() {
    TaskStatusEnum? value;
    switch (this) {
      case 'todo':
        value = TaskStatusEnum.todo;
        break;
      case 'in progress':
        value = TaskStatusEnum.inprogress;
        break;
      case 'in review':
        value = TaskStatusEnum.inreview;
        break;
      case 'done':
        value = TaskStatusEnum.done;
        break;
      default:
        value = TaskStatusEnum.none;
        break;
    }
    return value;
  }
}

extension TaskStatusStringExtension on TaskStatusEnum? {
  String toStatusString() {
    String value;
    switch (this) {
      case TaskStatusEnum.todo:
        value = 'to do';
        break;
      case TaskStatusEnum.inprogress:
        value = 'in progress';
        break;
      case TaskStatusEnum.inreview:
        value = 'in review';
        break;
      case TaskStatusEnum.done:
        value = 'done';
        break;
      case TaskStatusEnum.none || null:
        value = 'none';
        break;
    }
    return value;
  }
}
