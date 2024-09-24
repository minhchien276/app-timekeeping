enum TaskStatus {
  todo,
  working,
  done,
  cancel;

  int parseId() {
    switch (this) {
      case TaskStatus.todo:
        return 1;
      case TaskStatus.working:
        return 2;
      case TaskStatus.done:
        return 3;
      case TaskStatus.cancel:
        return 4;
      default:
        return 1;
    }
  }

  TaskStatus toEnum(int id) {
    switch (id) {
      case 1:
        return TaskStatus.todo;
      case 2:
        return TaskStatus.working;
      case 3:
        return TaskStatus.done;
      case 4:
        return TaskStatus.cancel;
      default:
        return TaskStatus.todo;
    }
  }

  String toName() {
    switch (this) {
      case TaskStatus.todo:
        return 'Todo';
      case TaskStatus.working:
        return 'Working';
      case TaskStatus.done:
        return 'Done';
      case TaskStatus.cancel:
        return 'Cancel';
      default:
        return '';
    }
  }
}
