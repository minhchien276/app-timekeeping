class Mocker {
  static String getRoleById(int roleId) {
    String roleName = "";
    if (roleId == 1) {
      roleName = "Giám đốc";
    } else if (roleId == 2) {
      roleName = "Leader";
    } else if (roleId == 3) {
      roleName = "Manager";
    } else if (roleId == 4) {
      roleName = "Nhân viên";
    } else if (roleId == 5) {
      roleName = "Intern";
    } else if (roleId == 6) {
      roleName = "Part-time";
    } else if (roleId == 7) {
      roleName = "Thử việc";
    }
    return roleName;
  }
}
