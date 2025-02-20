import 'package:flutter/material.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SizedBox(
          width: double.infinity, // Make sure it doesn't overflow horizontally
          child: Text(
            "Download screen",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ), // Control font size
            textAlign: TextAlign.center, // Keep text centered
          ),
        ),
      ),
    );
  }
}
