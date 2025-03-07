import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/widgets/dynamic_button_widget.dart';

class ComingSoonMovieWidget extends StatefulWidget {
  final String imageUrl;
  final String overview;
  final String logoUrl;
  final String month;
  final String day;

  const ComingSoonMovieWidget({
    super.key,
    required this.imageUrl,
    required this.overview,
    required this.logoUrl,
    required this.month,
    required this.day,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ComingSoonMovieWidgetState createState() => _ComingSoonMovieWidgetState();
}

class _ComingSoonMovieWidgetState extends State<ComingSoonMovieWidget>
    with TickerProviderStateMixin {
  bool isReminderSet = false; // Track if reminder is set
  late AnimationController _snackBarAnimationController;

  @override
  void initState() {
    super.initState();
    _snackBarAnimationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _snackBarAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: size.width * 0.95,
        height: size.height * 0.55,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: widget.logoUrl,
              fit: BoxFit.fitHeight,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  CachedNetworkImage(
                    width: size.width * 0.25,
                    imageUrl: widget.logoUrl,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Coming",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        widget.month,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        widget.day,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.overview,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  DynamicButtonWidget(
                    labelWhenSet: "Reminder Set",
                    labelWhenUnset: "Remind Me",
                    iconWhenSet: CupertinoIcons.check_mark,
                    iconWhenUnset: CupertinoIcons.bell,
                    isReminderSet: isReminderSet,
                    width: 0.43,
                    onTap: () {
                      if (!isReminderSet) {
                        debugPrint('Show Notification');
                        _showSnackBar(context);
                        setState(() {
                          isReminderSet = true; // Mark reminder as set
                        });
                      } else {
                        setState(() {
                          isReminderSet = false; // Change back to initial state
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show a SnackBar at the top with a white background
  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: FadeTransition(
        opacity: _snackBarAnimationController,
        child: Text(
          'Reminder Set',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white, // White background color
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating, // Makes it floating at the top
      margin: EdgeInsets.only(
          top: 50), // Adjust the top margin to show it at the top
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    _snackBarAnimationController.forward().then((value) {
      Future.delayed(Duration(seconds: 1), () {
        _snackBarAnimationController.reverse();
      });
    });
  }
}
