import 'package:flutter/material.dart';

const white = Color(0xFFFFFFFF);
const background = Color(0xffFDFDFF);
const black = Color.fromARGB(255, 0, 0, 0);
const greyText = Color(0xFF404040); //Grey700
const roseText = Color(0xFFFFF5F6); //rose25
const roseTitleText = Color(0xFFFD6F8E);
const greenColor = Color(0xFF00D08C);
const green = Color(0xFF12AC3D);
const red = Color(0xFFFF384C);
const redBold = Color(0xFFD10F0F);
const blue = Color(0xFF0C8DD8);
const boxShadowColor = Color(0xff18274B);

const primary900 = Color(0xFFF79735);
const primary800 = Color(0xFFF8A149);
const primary700 = Color(0xFFF9AC5D);
const primary600 = Color(0xFFF9B672);
const primary500 = Color(0xFFF9B672);
const primary400 = Color(0xFFFAC186);
const primary300 = Color(0xFFFDE0C2);
const primary200 = Color(0xFFFDEAD7);
const primary100 = Color(0xFFFEF5EB);

const neutral900 = Color(0xFF212529);
const neutral800 = Color(0xFF343A40);
const neutral700 = Color(0xFF495057);
const neutral600 = Color(0xFF6C757D);
const neutral500 = Color(0xFFADB5BD);
const neutral400 = Color(0xFFCED4DA);
const neutral300 = Color(0xFFDEE2E6);
const neutral200 = Color(0xFFE9ECEF);
const neutral100 = Color(0xFFDEE2E6);

const rose700 = Color(0xFFC01048);
const rose600 = Color(0xFFE31B54);
const rose500 = Color(0xFFF63D68);
const rose400 = Color(0xFFFD6F8E);
const rose300 = Color(0xFFFEA3B4);
const rose200 = Color(0xFFFECDD6);
const rose100 = Color(0xFFFFE4E8);
const rose50 = Color(0xFFFFF1F3);
const rose25 = Color(0xFFFFF5F6);

const grey25 = Color(0xFFFCFCFD);
const grey200 = Color(0xFFE4E7EC);
const grey100 = Color(0xFFF2F4F7);
const grey300 = Color(0xFFD0D5DD);
const grey400 = Color(0xFF98A2B3);
const grey600 = Color(0xFF475467);
const grey500 = Color(0xFF667085);
const grey700 = Color(0xFF344054);
const grey900 = Color(0xFF101828);
const greyBold = Color(0xFF888888);

const violet800 = Color(0xFF53389E);
const violet600 = Color(0xFF7F56D9);
const violet500 = Color(0xFF9E77ED);
const violet400 = Color(0xFFB692F6);
const violet300 = Color(0xFFD6BBFB);
const violet200 = Color(0xFFE9D7FE);
const violet100 = Color(0xFFF4EBFF);
const violet50 = Color(0xFFF9F5FF);
const violet25 = Color(0xFFFCFAFF);

const blue800 = Color(0xFF1849A9);
const blue700 = Color(0xFF2E90FA);
const blue600 = Color(0xFF1570EF);
const blue500 = Color(0xFF175CD3);
const blue400 = Color(0xFF53B1FD);
const blue300 = Color(0xFF84CAFF);
const blue200 = Color(0xFFB2DDFF);
const blue100 = Color(0xFFD1E9FF);
const blue25 = Color(0xFFF5FAFF);

const green300 = Color(0xFF4FD0C8);
const green500 = Color(0xFF0091B0);

const pink800 = Color(0xFF9E165F);
const pink700 = Color(0xFFC11574);
const pink600 = Color(0xFFDD2590);
const pink500 = Color(0xFFEE46BC);
const pink400 = Color(0xFFF670C7);
const pink300 = Color(0xFFFAA7E0);
const pink200 = Color(0xFFFCCEEE);
const pink100 = Color(0xFFFCE7F6);
const pink50 = Color(0xFFFDF2FA);

List<Color> groupImageColor(String value) {
  int res = 0;
  for (var e in value[0].codeUnits) {
    res += e;
  }

  int tmp = res % 10;

  switch (tmp) {
    case 0:
    case 1:
      return [primary500, primary900];
    case 2:
    case 3:
      return [rose400, rose500];
    case 4:
    case 5:
      return [violet400, violet500];
    case 6:
      return [grey400, grey500];
    case 7:
      return [pink400, pink500];
    case 8:
      return [blue400, blue500];
    case 9:
      return [green300, green500];
    default:
  }
  return [grey400, grey500];
}
