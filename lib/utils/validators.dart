emptyValidate(String? value) {
  if (value == null || value.isEmpty) return false;
  return true;
}

String? emailValidator(String? value) {
  List<String> requirementEmail = [
    '@tmsc-vn.com',
    '@skin-net.com',
  ];

  if (value == null || value.isEmpty) {
    return "Vui lòng điền đầy đủ thông tin";
  } else if (requirementEmail
      .where((e) => value.contains(e))
      .toList()
      .isEmpty) {
    return "Email không hợp lệ";
  }
  return null;
}
