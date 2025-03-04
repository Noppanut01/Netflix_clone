import 'package:flutter/material.dart';

class DynamicButtonWidget extends StatelessWidget {
  final String labelWhenSet;
  final String labelWhenUnset;
  final IconData iconWhenSet;
  final IconData iconWhenUnset;
  final Duration animationDuration;
  final bool isReminderSet;
  final double width;
  final Function()? onTap;

  // Constructor to accept parameters for customization
  const DynamicButtonWidget({
    super.key,
    required this.labelWhenSet,
    required this.labelWhenUnset,
    required this.iconWhenSet,
    required this.iconWhenUnset,
    this.animationDuration = const Duration(milliseconds: 300),
    this.onTap,
    required this.isReminderSet,
    required this.width, // isReminderSet passed from parent
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: animationDuration, // Use custom animation duration
      child: InkWell(
        key: ValueKey<bool>(isReminderSet), // Unique key to trigger animation
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width * width,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isReminderSet ? iconWhenSet : iconWhenUnset,
                size: 30,
                color: Colors.black,
              ),
              SizedBox(width: 5),
              Text(
                isReminderSet ? labelWhenSet : labelWhenUnset,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
