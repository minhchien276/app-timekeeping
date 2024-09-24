extension StringExtension on String {
  String toEnglish() {
    String tmp = this;
    const withDiacritics =
        'áàảãạăắằẳẵặâấầẩẫậéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵđ';
    const withoutDiacritics =
        'aaaaaaaaaaaaaaaaaeeeeeeeedeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyd';

    for (int i = 0; i < withDiacritics.length; i++) {
      tmp = tmp.replaceAll(withDiacritics[i], withoutDiacritics[i]);
    }
    return tmp;
  }
}
