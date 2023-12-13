import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:asu_carpool/Requests.dart';
import 'package:asu_carpool/Route1.dart';
import 'package:asu_carpool/Route2.dart';
import 'MyWidgets.dart';
import 'SignIn.dart';
import 'auth.dart';
import 'Profile.dart';
import 'about.dart';

String username = "";
String phone = "";
String userID = "";

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  User? _user;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  /////////////////////////////////////////////////////////////////////////////

  Future<void> _getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        _user = user;
        _userData = userData.data();
        userID = user.uid;
        print(userID);
        username = _userData!['firstName'] + " " + _userData!['lastName'];
        phone = _userData!['phone'];
      });
    }
  }

  /////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: colorsPrimary,
            leading: iconBack(context),
            title: textPageTitle("Available Routes"),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                          IconData(0xe559,
                              fontFamily: 'MaterialIcons',
                              matchTextDirection: true),
                          color: Colors.white),
                      Text(
                        'To Faculty',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Tab(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        IconData(0xe318,
                            fontFamily: 'MaterialIcons',
                            matchTextDirection: true),
                        color: Colors.white,
                      ),
                      Text(
                        'From Faculty',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Route1(),
              Route2(),
            ],
          ),
        ));
  }
}
