// List users = [
//   (
//     imageUrl: "assets/pictures/profile-1.jpg",
//     name: "Dad",
//     exist: true,
//   ),
//   (
//     imageUrl: "assets/pictures/profile-2.jpg",
//     name: "Mom",
//     exist: true,
//   ),
//   (
//     imageUrl: "assets/pictures/profile-3.jpg",
//     name: "Ojang",
//     exist: true,
//   ),
//   (
//     imageUrl: "assets/pictures/profile-4.jpg",
//     name: "Ang",
//     exist: true,
//   ),
//   (
//     imageUrl: "assets/icons/plus.png",
//     name: "Add Profile",
//     exist: false,
//   ),
// ];

class User {
  String imageUrl;
  String name;
  bool exist;

  User({required this.imageUrl, required this.name, required this.exist});
}
