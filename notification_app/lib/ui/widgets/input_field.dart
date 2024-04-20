import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
//import '../theme.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato',
              ),
            ),
            Container(
              height: 52,
              margin: const EdgeInsets.only(top: 6.0),
              padding: const EdgeInsets.only(left: 8),
              child: Stack(
                children: [
                  // Container con los bordes grises
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  // Container con color de fondo transparente
                  Container(
                    color: Colors.transparent, // Fondo transparente
                    padding: const EdgeInsets.only(left: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: widget == null ? false : true,
                            autofocus: false,
                            cursorColor: Get.isDarkMode
                                ? Colors.grey[100]
                                : Colors.grey[700],
                            controller: controller,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Lato',
                            ),
                            decoration: InputDecoration(
                              hintText: hint,
                              hintStyle: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Lato',
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide.none, // Sin bordes al enfocar
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide
                                    .none, // Sin bordes cuando está habilitado
                              ),
                            ),
                          ),
                        ),
                        widget==null?Container():Container(child: widget,)
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
