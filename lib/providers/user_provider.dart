import 'package:flutter/material.dart';
import '../models/users.dart';

class UserProvider extends ChangeNotifier {
  final List<User> _users = [
    // User(imageUrl: "assets/pictures/profile-1.jpg", name: "Dad", exist: true),
    // User(imageUrl: "assets/pictures/profile-2.jpg", name: "Mom", exist: true),
    User(imageUrl: "assets/pictures/profile-3.jpg", name: "Ojang", exist: true),
    // User(imageUrl: "assets/pictures/profile-4.jpg", name: "Ang", exist: true),
    User(imageUrl: "assets/icons/plus.png", name: "Add Profile", exist: false),
  ];

  List<User> get users => _users;

  void addUser(User user) {
    if (_users.length < 5) {
      _users.insert(
        _users.length - 1,
        user,
      ); // Insert before the last 'Add Profile' item
    } else {
      // Replace the last user
      _users[_users.length - 1] =
          user; // Replace the second-to-last user (the 'Add Profile' one is excluded)
    }
    notifyListeners();
  }

  void removeUser(int index) {
    if (_users[index].exist) {
      _users.removeAt(index);
      notifyListeners();
    }
  }

  void updateUser(int index, String imageUrl, String name) {
    // Ensure we update only if the user exists
    if (_users[index].exist) {
      _users[index] = User(imageUrl: imageUrl, name: name, exist: true);
    } else {
      addUser(User(imageUrl: imageUrl, name: name, exist: true));
    }
    notifyListeners();
  }
}
