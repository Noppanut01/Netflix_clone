import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/user_profile.dart';
import '../providers/user_provider.dart';
import 'edit_profile_screen.dart'; // Import UserProvider

class PickUserScreen extends StatelessWidget {
  const PickUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Who's Watching?",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
            },
            child: const Text(
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
          child: Consumer<UserProvider>(
            // Use Consumer<UserProvider>
            builder: (context, userProvider, child) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                shrinkWrap: true,
                itemCount:
                    userProvider.users.length, // Access users from UserProvider
                itemBuilder: (BuildContext context, int index) {
                  final user = userProvider.users[index];
                  return UserProfile(
                    imageUrl: user.imageUrl,
                    name: user.name,
                    exist: user.exist,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
