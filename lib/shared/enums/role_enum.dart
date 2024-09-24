enum RoleEnum {
  admin,
  client;

  static RoleEnum parseEnum(int? roleId) {
    switch (roleId) {
      case 1:
        return RoleEnum.admin;
      default:
        return RoleEnum.client;
    }
  }
}
