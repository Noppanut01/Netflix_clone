// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/cast_screen.dart';

class DynamicAppbarWidget extends StatelessWidget {
  final double opacity;
  final double appBarHeight;
  final String title;
  final IconData icon1;
  final IconData icon2;
  final IconData icon3;
  final Function()? onTap1;
  final Function()? onTap2;

  const DynamicAppbarWidget({
    super.key,
    required this.opacity,
    required this.appBarHeight,
    required this.title,
    required this.icon1,
    required this.icon2,
    required this.icon3,
    this.onTap1,
    this.onTap2,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter:
            ImageFilter.blur(sigmaX: 100, sigmaY: 100), // Glassmorphism effect
        child: Container(
          height: appBarHeight,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                width: 1,
              ),
            ),
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Icons for cast, download, and search
                SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Cast icon
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Color(0xFF2B2B2B),
                            barrierColor: Colors.transparent,
                            builder: (context) => CastScreen(),
                          );
                        },
                        child: Icon(icon1, color: Colors.white, size: 27),
                      ),
                      // Download icon
                      InkWell(
                        onTap: onTap1,
                        child: Icon(icon2, color: Colors.white, size: 27),
                      ),
                      // Search icon
                      InkWell(
                        onTap: onTap2,
                        child: Icon(icon3, color: Colors.white, size: 27),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
