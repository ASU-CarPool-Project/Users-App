import 'package:flutter/material.dart';

Widget textButtons(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 18.0,
      color: Colors.white,
    ),
  );
}

Widget textPageTitle(String text) {
  return Text(
    text,
    style: const TextStyle(color: Colors.white),
  );
}

Widget textLargeTitle(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 24, color: Colors.indigo),
    ),
  );
}

Widget iconBack(BuildContext context){
  return IconButton(
    icon: const Icon(
      IconData(
        0xe093,
        fontFamily: 'MaterialIcons',
        matchTextDirection: true,
      ),
      color: Colors.white,
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
}
