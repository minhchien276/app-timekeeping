enum QuestionType {
  essay,
  choice;

  parseId() {
    switch (this) {
      case QuestionType.choice:
        return 1;
      case QuestionType.essay:
        return 2;
      default:
        return 1;
    }
  }

  static toEnum(int id) {
    switch (id) {
      case 1:
        return QuestionType.choice;
      case 2:
        return QuestionType.essay;
      default:
        return QuestionType.choice;
    }
  }
}
