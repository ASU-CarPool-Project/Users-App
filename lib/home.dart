import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'MyWidgets.dart';
import 'Profile.dart';
import 'Requests.dart';
import 'SignIn.dart';
import 'about.dart';
import 'auth.dart';
import 'Routes.dart';

String username = "";
String phone = "";
String userID = "";

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  User? _user;
  Map<String, dynamic>? _userData;

  DatabaseReference tripsReference =
      FirebaseDatabase.instance.ref().child("Requests").child("Accepted");

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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorsPrimary,
          // leading: iconBack(context),
          title: textPageTitle("Home"),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.white70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UserAccountsDrawerHeader(
                  accountName: _userData != null
                      ? Text(
                          "${_userData!['firstName'] + " " + _userData!['lastName']}")
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
                  decoration: BoxDecoration(
                      color:
                          colorsPrimary // Change the background color of the header
                      ),
                ),
                ListTile(
                  // tileColor: Theme.of(context).colorScheme.secondary,
                  leading: Icon(Icons.face, color: colorsPrimary),
                  title: Text(
                    "Profile",
                    style: TextStyle(color: colorsPrimary),
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
                  leading: Icon(Icons.list_alt_rounded, color: colorsPrimary),
                  title: Text(
                    "My Requests",
                    style: TextStyle(color: colorsPrimary),
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
                  leading: Icon(Icons.info, color: colorsPrimary),
                  title: Text(
                    "About",
                    style: TextStyle(color: colorsPrimary),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => about()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  // tileColor: Theme.of(context).colorScheme.secondary,
                  leading: Icon(Icons.question_mark, color: Colors.indigo),
                  title: Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.indigo),
                  ),
                  onTap: () {
                    signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        body: Container(
          // color: Colors.blue,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    // color: Colors.yellow,
                    child: Wrap(children: [
                      StreamBuilder(
                        stream: tripsReference.onValue,
                        builder:
                            (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                          if (snapshot.hasData &&
                              !snapshot.hasError &&
                              snapshot.data!.snapshot.value != null) {
                            Map<dynamic, dynamic>? trips = snapshot
                                .data!.snapshot.value as Map<dynamic, dynamic>?;
                            List<MapEntry> tripList =
                                trips?.entries.toList() ?? [];

                            return ListView.builder(
                              itemCount: tripList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.all(10),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Card(
                                      color: colorsRoute1,
                                      child: ListTile(
                                        tileColor: Colors.transparent,
                                        leading: const Icon(
                                          Icons.pin_drop_sharp,
                                          color: Colors.white,
                                        ),
                                        title: textPageTitle(
                                            "${tripList[index].value["route"]} - ${tripList[index].value["gate"]} "),
                                        subtitle: textPageTitle(
                                            "${tripList[index].value["date"]} / ${tripList[index].value["time"]}"),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            print("Errooooooooooor: ${snapshot.error}");
                            return Card(
                              color: colorsRoute1,
                              child: ListTile(
                                tileColor: Colors.transparent,
                                leading: const Icon(
                                  Icons.bus_alert,
                                  color: Colors.white,
                                ),
                                title: textPageTitle("No Accepted Trips yet!"),
                              ),
                            );
                          }
                        },
                      )
                    ]),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                child: ListTile(
                                  tileColor: colorsPrimary,
                                  title: Text(
                                    "Explore Trips",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: Icon(
                                    Icons.add_circle,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Routes()),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                child: ListTile(
                                  tileColor: colorsPrimary,
                                  title: Text(
                                    "Requests",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: Icon(
                                    Icons.add_task,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Requests()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}
