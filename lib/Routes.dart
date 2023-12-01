import 'package:asu_carpool/Requests.dart';
import 'package:asu_carpool/Route1.dart';
import 'package:asu_carpool/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:asu_carpool/Route2.dart';
import 'MyWidgets.dart';
import 'auth.dart';
import 'Profile.dart';
import 'about.dart';

String username = "";
String phone = "";

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
      DocumentSnapshot<Map<String, dynamic>> userData =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      setState(() {
        _user = user;
        _userData = userData.data();
        username = _userData!['firstName'] +" "+ _userData!['lastName'];
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
            backgroundColor: Colors.indigo,
            title: textPageTitle("Available Routes"),
            centerTitle: true,
            bottom: const TabBar(
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
                        'To Home',
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
          drawer: Drawer(
            child: Container(
              color: Colors.white70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: _userData != null
                        ? Text("${_userData!['firstName'] +" "+ _userData!['lastName']}")
                        : Text("Finn The Manager"),
                    accountEmail: _userData != null
                        ? Text("${_userData!['email']}")
                        : Text("finn@gstore.com"),
                    // You can provide an email address here if needed
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: const CircleAvatar(
                        radius: 37,
                        backgroundColor: Colors.white70,
                        backgroundImage: AssetImage('assets/logos/fin.png'),
                      ),
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.indigo // Change the background color of the header
                        ),
                  ),
                  ListTile(
                    // tileColor: Theme.of(context).colorScheme.secondary,
                    leading: const Icon(Icons.face,
                        color: Colors.indigo),
                    title: const Text(
                      "Profile",
                      style: TextStyle(
                          color: Colors.indigo),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    // tileColor: Theme.of(context).colorScheme.secondary,
                    leading: Icon(Icons.list_alt_rounded,
                        color: Colors.indigo),
                    title: Text(
                      "Your Requests",
                      style: TextStyle(
                          color: Colors.indigo),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Requests()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    // tileColor: Theme.of(context).colorScheme.secondary,
                    leading: const Icon(Icons.settings, color: Colors.indigo),
                    title: Text(
                      "Settings",
                      style: TextStyle(
                          color: Colors.indigo),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => settings()),
                      );
                    },
                  ),

                  Divider(),
                  ListTile(
                    // tileColor: Theme.of(context).colorScheme.secondary,
                    leading: Icon(Icons.question_mark,
                        color: Colors.indigo),
                    title: Text(
                      "About",
                      style: TextStyle(
                          color: Colors.indigo),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => about()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Route1(),
              Route2(),
            ],
          ),
        ));
  }
}