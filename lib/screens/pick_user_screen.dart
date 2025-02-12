import 'package:flutter/material.dart';
import '/widgets/user_profile.dart';
import '../models/users.dart';

class PickUserScreen extends StatefulWidget {
  const PickUserScreen({super.key});

  @override
  State<PickUserScreen> createState() => _PickUserScreenState();
}

class _PickUserScreenState extends State<PickUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Who's Watching?",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(70.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            shrinkWrap: true,
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              Widget profile = UserProfile(
                imageUrl: users[index].imageUrl,
                name: users[index].name,
                exist: users[index].exist,
              );
              // Check if it's the last item
              return profile;
            },
          ),
        ),
      ),
    );
  }
}
