import 'package:e_tmsc_app/presentation/screens/application/application_admin.dart';
import 'package:e_tmsc_app/presentation/screens/application/application_client.dart';
import 'package:e_tmsc_app/shared/enums/role_enum.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  @override
  Widget build(BuildContext context) {
    return SharedPrefs().role == RoleEnum.admin
        ? const ApplicationAdmin()
        : const ApplicationClient();
  }
}
