import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/users.dart';
import 'choose_icon_screen.dart';

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddProfilePopupState createState() => _AddProfilePopupState();
}

class _AddProfilePopupState extends State<AddProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool isKidsProfile = false;
  bool isNameEmpty = true;
  String? selectedIconPath;

  _loadSelectedIcon() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedIconPath = prefs.getString('selectedIcon');
    });
  }

  @override
  void initState() {
    super.initState();

    _loadSelectedIcon();

    _nameController.addListener(() {
      setState(() {
        isNameEmpty = _nameController.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
        children: [
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
              TextButton(
                onPressed: isNameEmpty
                    ? null
                    : () {
                        users[users.length - 1] = (
                          imageUrl: selectedIconPath,
                          name: _nameController.text,
                          exist: true,
                        );
                        Navigator.pop(context);
                      },
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: isNameEmpty ? Colors.grey : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment(1.2, 1.2),
            children: [
              Container(
                width: 103,
                height: 103,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: selectedIconPath == null
                      ? DecorationImage(
                          image: AssetImage("assets/pictures/profile-10.jpg"),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: AssetImage(selectedIconPath!),
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
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.black,
                      builder: (context) => ChooseIconScreen(
                        onIconSelected: (iconPath) {
                          setState(() {
                            selectedIconPath = iconPath;
                          });
                        },
                      ),
                    );
                  },
                  child: Icon(
                    Icons.edit,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
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
                  color: Color(0xFF8B8B8B),
                  fontSize: 17,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
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
              cursorColor: Colors.blue,
            ),
          ),
          const SizedBox(height: 20),
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
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  activeTrackColor: Color(0xFF4061E7),
                  inactiveTrackColor: Color(0xFF353438),
                  trackOutlineColor:
                      WidgetStateProperty.all(Colors.transparent),
                  thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                    (states) {
                      return Icon(Icons.circle, size: 34, color: Colors.white);
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
