import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 200,
        height: 200,
        child: Center(
          child: Text("Search screen"),
        ),
      ),
    );
  }
}
