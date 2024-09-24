enum SessionEnum {
  morning,
  afternoon,
  all;

  static int parseId(SessionEnum value) {
    switch (value) {
      case SessionEnum.all:
        return 0;
      case SessionEnum.morning:
        return 1;
      case SessionEnum.afternoon:
        return 2;
      default:
        return 0;
    }
  }

  static SessionEnum parseEnum(int? id) {
    switch (id) {
      case 0:
        return SessionEnum.all;
      case 1:
        return SessionEnum.morning;
      case 2:
        return SessionEnum.afternoon;
      default:
        return SessionEnum.all;
    }
  }

  buildTitle() {
    switch (this) {
      case SessionEnum.all:
        return 'Cả ngày';
      case SessionEnum.morning:
        return 'Buổi sáng';
      case SessionEnum.afternoon:
        return 'Buổi chiều';
      default:
        return 'Cả ngày';
    }
  }
}
