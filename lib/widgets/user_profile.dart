import 'package:flutter/material.dart';
import 'package:netflix_clone/widgets/bottom_navbar.dart';
import '../screens/add_profile.dart';

class UserProfile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final bool exist;
  const UserProfile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.exist,
  });

  @override
  Widget build(BuildContext context) {
    return exist
        ? InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomNavbar()),
              );
            },
            child: SizedBox(
              width: 103,
              height: 135,
              child: Column(
                children: [
                  Container(
                    width: 103,
                    height: 103,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        : InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                barrierColor: Colors.black,
                builder: (context) => AddProfilePopup(),
              );
            },
            child: SizedBox(
              width: 103,
              height: 135,
              child: Column(
                children: [
                  Container(
                    width: 103,
                    height: 103,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF4D4D4D), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imageUrl),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
  }
}
