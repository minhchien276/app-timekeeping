import 'package:e_tmsc_app/presentation/screens/calendar/calendar_admin.dart';
import 'package:e_tmsc_app/presentation/screens/calendar/calendar_client.dart';
import 'package:e_tmsc_app/shared/enums/role_enum.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SharedPrefs().role == RoleEnum.admin
        ? const CalendarAdmin()
        : const CalendarClient();
  }
}
