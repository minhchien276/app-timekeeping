import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ProfileRule extends StatefulWidget {
  const ProfileRule({super.key});

  @override
  State<ProfileRule> createState() => _ProfileRuleState();
}

class _ProfileRuleState extends State<ProfileRule>
    with TickerProviderStateMixin {
  String url =
      'https://tmsc-vn.com/wp-content/uploads/noi-quy-lao-dong-TMSC-03052024.pdf';

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: const KBackButton(),
        backgroundColor: primary900,
        centerTitle: true,
        title: TextWidget(
          text: 'Quy trình quy định',
          color: white,
          textStyle: textStyle17Bold,
        ),
      ),
      body: SfPdfViewer.network(url),
    );
  }
}
