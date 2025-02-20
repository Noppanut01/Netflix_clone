import 'package:flutter/material.dart';

class CustomRoundIconButton extends StatelessWidget {
  final IconData icon;
  final Function()? ontab;
  const CustomRoundIconButton({
    super.key,
    required this.icon,
    this.ontab,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(0.0, 0.0),
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF232223),
          ),
        ),
        InkWell(
          onTap: ontab,
          child: Icon(
            icon,
            color: Colors.white,
            size: 17,
            weight: 700,
          ),
        ),
      ],
    );
  }
}
