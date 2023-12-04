import 'package:flutter/material.dart';

import 'MyWidgets.dart';

class about extends StatefulWidget {
  about({Key? key}) : super(key: key);

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorsPrimary,
        leading: iconBack(context),
        title: textPageTitle("About"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SingleChildScrollView(
              child: Container(
                // color: Theme.of(context).colorScheme.background,
                // Change the background color of the entire drawer
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset("assets/logos/flutter.png",
                          height: 150, width: 150),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Welcome to my Car pool app!",
                          style: TextStyle(fontSize: 20, color: colorsPrimary),
                        )),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "This app was built as a final project\nfor my flutter course",
                          style: TextStyle(fontSize: 15, color: colorsPrimary),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
