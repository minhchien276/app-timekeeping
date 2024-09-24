import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSubmitDialog(
  BuildContext context, {
  String? title,
  required String message,
  required VoidCallback onSubmit,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: title != null ? Text(title) : null,
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Hủy',
            style: TextStyle(color: Colors.red),
          ),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.of(context).pop();
            onSubmit();
          },
          child: const Text(
            "Đồng ý",
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    ),
  );
}
