import 'package:flutter/material.dart';
import 'package:netflix_clone/widgets/custom_round_icon_button.dart';

class MoreSettingScreen extends StatefulWidget {
  const MoreSettingScreen({super.key});

  @override
  State<MoreSettingScreen> createState() => _MoreSettingScreenState();
}

class _MoreSettingScreenState extends State<MoreSettingScreen> {
  final List<Map<String, dynamic>> settingsOptions = [
    {'icon': Icons.person, 'title': "Manage Profiles"},
    {'icon': Icons.settings, 'title': "App Settings"},
    {'icon': Icons.person, 'title': "Account"},
    {'icon': Icons.help, 'title': "Help"},
    {'icon': Icons.logout, 'title': "Sign Out"},
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.4, // Set height to 50% of the screen
      child: Container(
        color: Color(0xFF2D2D2D),
        child: Stack(
          alignment: Alignment(0.96, -0.9),
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: settingsOptions.length,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16),
                        child: Row(
                          children: [
                            Icon(
                              settingsOptions[index]['icon'],
                              color: Colors.white,
                              size: 25,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              settingsOptions[index]['title'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            CustomRoundIconButton(
              icon: Icons.close,
              ontab: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
