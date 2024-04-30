import 'package:flutter/material.dart';
import 'package:notification_app/ui/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const CustomButton({Key? key, required this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryClr,
        ),
        child: Center(
          // Centra el texto horizontalmente y verticalmente dentro del contenedor
          child: Text(
            text,
            textAlign: TextAlign.center, // Centra el texto horizontalmente
            style: const TextStyle(
              fontFamily: 'Lato',
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
