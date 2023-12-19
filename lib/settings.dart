import 'package:flutter/material.dart';

import 'MyWidgets.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorsPrimary,
        leading: iconBack(context),
        title: textPageTitle("Settings"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/logos/cogwheel.png",
                        height: 150, width: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: const ListTile(
                        tileColor: Colors.indigo,
                        title: Text(
                          "Sound",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(
                          Icons.surround_sound_rounded,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
