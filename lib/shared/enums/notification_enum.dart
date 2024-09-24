enum NotificationType {
  normal,
  blog,
  application,
  salary,
  testDetail,
  testScore,
  newEmployee;

  static toEnum(String value) {
    switch (value) {
      case 'blog':
        return NotificationType.blog;
      case 'application':
        return NotificationType.application;
      case 'salary':
        return NotificationType.salary;
      case 'test_details':
        return NotificationType.testDetail;
      case 'test_score':
        return NotificationType.testScore;
      case 'normal':
        return NotificationType.normal;
      case 'new_employee':
        return NotificationType.newEmployee;
      default:
    }
  }

  static parseType(int? type) {
    switch (type) {
      case 1:
        return NotificationType.testDetail;
      case 2:
        return NotificationType.salary;
      case 3:
        return NotificationType.newEmployee;
      case 4:
        return NotificationType.blog;
      case 5:
        return NotificationType.normal;
      case null:
        return NotificationType.application;
      default:
    }
  }
}
