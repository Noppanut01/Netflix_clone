import 'package:flutter/material.dart';

class CastScreen extends StatelessWidget {
  const CastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Center(
        child: Text("Cast screen"),
      ),
    );
  }
}
