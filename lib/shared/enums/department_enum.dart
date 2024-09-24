enum DepartmentEnum {
  sale,
  seo,
  ga,
  skinnet,
  marketing,
  design,
  warehouse,
  hr,
  accouting,
  it,
  director;

  static List<DepartmentEnum> get departments =>
      DepartmentEnum.values.where((e) => e != DepartmentEnum.director).toList();

  static toEnum(int id) {
    switch (id) {
      case 1:
        return DepartmentEnum.sale;
      case 2:
        return DepartmentEnum.seo;
      case 3:
        return DepartmentEnum.it;
      case 4:
        return DepartmentEnum.warehouse;
      case 5:
        return DepartmentEnum.marketing;
      case 6:
        return DepartmentEnum.hr;
      case 7:
        return DepartmentEnum.design;
      case 8:
        return DepartmentEnum.skinnet;
      case 9:
        return DepartmentEnum.ga;
      case 10:
        return DepartmentEnum.accouting;
      case 11:
        return DepartmentEnum.director;
      default:
        return DepartmentEnum.sale;
    }
  }

  static fromEnum(DepartmentEnum e) {
    switch (e) {
      case DepartmentEnum.sale:
        return 1;
      case DepartmentEnum.seo:
        return 2;
      case DepartmentEnum.it:
        return 3;
      case DepartmentEnum.warehouse:
        return 4;
      case DepartmentEnum.marketing:
        return 5;
      case DepartmentEnum.hr:
        return 6;
      case DepartmentEnum.design:
        return 7;
      case DepartmentEnum.skinnet:
        return 8;
      case DepartmentEnum.ga:
        return 9;
      case DepartmentEnum.accouting:
        return 10;
      case DepartmentEnum.director:
        return 11;
      default:
        return 1;
    }
  }

  String text() {
    switch (this) {
      case DepartmentEnum.sale:
        return 'Sale - Kinh doanh';
      case DepartmentEnum.seo:
        return 'SEO - Content';
      case DepartmentEnum.it:
        return 'IT - CNTT';
      case DepartmentEnum.warehouse:
        return 'Kho';
      case DepartmentEnum.marketing:
        return 'Marketing';
      case DepartmentEnum.hr:
        return 'Hành Chính Nhân Sự';
      case DepartmentEnum.design:
        return 'Design - Thiết kế';
      case DepartmentEnum.skinnet:
        return 'Skinnet';
      case DepartmentEnum.ga:
        return 'GA - Google Marketing';
      case DepartmentEnum.accouting:
        return 'Kế toán';
      case DepartmentEnum.director:
        return 'Ban Giám Đốc';
      default:
        return '';
    }
  }
}
