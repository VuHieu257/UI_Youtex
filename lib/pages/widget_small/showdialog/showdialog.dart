import 'package:flutter/material.dart';

void showFeatureUnavailableDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Thông Báo'),
        content: Text('Tính năng này đang được phát triển hãy đợi các phiên bản sau nhé.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Đóng'),
          ),
        ],
      );
    },
  );
}
