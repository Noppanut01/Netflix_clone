import 'dart:developer';

import 'package:flutter/material.dart';

class AddProfilePopup extends StatefulWidget {
  const AddProfilePopup({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddProfilePopupState createState() => _AddProfilePopupState();
}

class _AddProfilePopupState extends State<AddProfilePopup> {
  final TextEditingController _nameController = TextEditingController();
  bool isKidsProfile = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF161616), // Dark theme background
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                "Add Profile",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              _nameController.text.isEmpty
                  ? TextButton(
                      onPressed: null,
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        // Handle save action
                        log(_nameController.text);
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 20),
          // Profile Image with Edit Button
          Stack(
            alignment: Alignment(1.2, 1.2),
            children: [
              Container(
                width: 103,
                height: 103,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/pictures/profile-10.jpg"), // Change to your default image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  Icons.edit,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Profile Name Input (Move this out of Stack)
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextField(
              controller: _nameController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelText: "Profile Name",
                labelStyle: TextStyle(
                  color: Color(0xFF8B8B8B), // Default hint color
                  fontSize: 17,
                ),
                floatingLabelBehavior: FloatingLabelBehavior
                    .auto, // This will float the label when focused or has text
                contentPadding: EdgeInsets.only(
                  left: 12,
                  top: 10,
                  bottom: 10,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF606060), width: 2),
                ),
              ),
              cursorColor: Colors.blue, // Cursor blinks in blue
            ),
          ),

          const SizedBox(height: 20),
          // Kids Profile Toggle
          SizedBox(
            width: 320,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Switch(
                  value: isKidsProfile,
                  onChanged: (value) {
                    setState(() {
                      isKidsProfile = value;
                    });
                  },
                  activeColor: Colors.white, // Thumb color when active
                  inactiveThumbColor: Colors.white, // Thumb color when inactive
                  activeTrackColor:
                      Color(0xFF4061E7), // Track color when active
                  inactiveTrackColor:
                      Color(0xFF353438), // Track color when inactive
                  trackOutlineColor: WidgetStateProperty.all(
                      Colors.transparent), // Removes border
                  thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                    (states) {
                      return Icon(Icons.circle,
                          size: 34, color: Colors.white); // Enlarged thumb
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Kids Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.center,
                  "Made for kids 12 and under, but parents have all the control.",
                  style: TextStyle(
                    color: Color(0xFFB8B8B8),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
