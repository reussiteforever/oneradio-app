import 'package:flutter/material.dart';

AppBar homeAppbar() {
  return AppBar(
    //const Color(0xFFfdce0a)
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    title: Container(
      width: 300,
      height: 50,
      child: Image.asset("assets/images/oneradio-logo.jpg"),
    ),
    centerTitle: true,
    actions: const [
      Icon(Icons.featured_play_list_outlined),
    ],
  );
}
