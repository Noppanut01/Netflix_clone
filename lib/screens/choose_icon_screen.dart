import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_arrow_back.dart';
import '../models/icons.dart';

class ChooseIconScreen extends StatefulWidget {
  final Function(String) onIconSelected; // Callback function

  const ChooseIconScreen({super.key, required this.onIconSelected});

  @override
  // ignore: library_private_types_in_public_api
  _ChooseIconScreenState createState() => _ChooseIconScreenState();
}

class _ChooseIconScreenState extends State<ChooseIconScreen> {
  _saveSelectedIcon(String iconPath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedIcon', iconPath);
    log("Icon saved: $iconPath");
    // Call the callback to update the icon in the parent screen
    widget.onIconSelected(iconPath);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF161616),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomArrowBack(),
              Text(
                "Choose Icon",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "The Classics",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: icons.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    await _saveSelectedIcon(icons[index]);
                    log("Icon selected: ${icons[index]}");
                  },
                  child: Container(
                    width: 103,
                    height: 103,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(
                          icons[index],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
