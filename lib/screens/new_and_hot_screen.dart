import 'package:flutter/material.dart';

import '../widgets/banner_widget.dart';

class NewAndHotScreen extends StatelessWidget {
  const NewAndHotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF252525),
                Color(0xFF252525),
                Colors.transparent,
              ],
              stops: [0.0, 0.7, 1.0],
            ),
          ),
        ),
        BannerWidget(),
      ],
    );
  }
}
