import 'package:e_tmsc_app/presentation/screens/profile/profile_admin.dart';
import 'package:e_tmsc_app/presentation/screens/profile/profile_client.dart';
import 'package:e_tmsc_app/shared/enums/role_enum.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SharedPrefs().role == RoleEnum.client
        ? const ProfileClient()
        : const ProfileAdmin();
  }
}
