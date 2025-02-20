import 'package:flutter/material.dart';
import 'package:netflix_clone/screens/cast_screen.dart';
import 'package:netflix_clone/widgets/custom_round_icon_button.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.94,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.24,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomRoundIconButton(
                      icon: Icons.cast,
                      ontab: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Color(0xFF2B2B2B),
                          // barrierColor: Colors.black,
                          builder: (context) => CastScreen(),
                        );
                      },
                    ),
                    SizedBox(width: 10),
                    CustomRoundIconButton(icon: Icons.close),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
