import 'package:asu_carpool/complains.dart';
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
      FirebaseDatabase.instance.ref().child("Requests");

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
                      : const Text("Finn The Manager"),
                  accountEmail: _userData != null
                      ? Text("${_userData!['email']}")
                      : const Text("finn@gstore.com"),
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
                      MaterialPageRoute(builder: (context) => const Profile()),
                    );
                  },
                ),
                ListTile(
                  // tileColor: Theme.of(context).colorScheme.secondary,
                  leading: Icon(Icons.comment_rounded, color: colorsPrimary),
                  title: Text(
                    "Complains",
                    style: TextStyle(color: colorsPrimary),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const complains()),
                    );
                  },
                ),
                ListTile(
                  // tileColor: Theme.of(context).colorScheme.secondary,
                  leading: Icon(Icons.info, color: colorsPrimary),
                  title: Text(
                    "About",
                    style: TextStyle(color: colorsPrimary),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const about()),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  // tileColor: Theme.of(context).colorScheme.secondary,
                  leading: const Icon(Icons.backspace, color: Colors.indigo),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.indigo),
                  ),
                  onTap: () {
                    signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SignIn()),
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
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    // color: Colors.yellow,
                    child: Expanded(
                        child: StreamBuilder(
                      stream: tripsReference
                          .orderByChild("userID")
                          .equalTo(userID)
                          .onValue,
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.hasData &&
                            !snapshot.hasError &&
                            snapshot.data!.snapshot.value != null) {
                          Map<dynamic, dynamic>? trips = snapshot
                              .data!.snapshot.value as Map<dynamic, dynamic>?;

                          List<MapEntry> allList =
                              trips?.entries.toList() ?? [];
                          String status = "Accepted";
                          List<MapEntry> tripList = allList
                              .where((entry) => entry.value["reqStatus"]
                                  .toString()
                                  .toLowerCase()
                                  .contains(status.toLowerCase()))
                              .toList();

                          return ListView.builder(
                            itemCount: tripList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => TripStart(
                                    //         tripData: tripList[index].value,
                                    //         tripKey:
                                    //             tripList[index].key.toString()),
                                    //   ),
                                    // );
                                  },
                                  child: Card(
                                    color: colorsAccepted,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.directions,
                                                  color: Colors.white),
                                              const SizedBox(width: 10),
                                              textPageTitle(
                                                  "${tripList[index].value["direction"]} - ${tripList[index].value["gate"]}")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.pin_drop_sharp,
                                                  color: Colors.white),
                                              const SizedBox(width: 10),
                                              textPageTitle(
                                                  "District: ${tripList[index].value["route"]}"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.access_time,
                                                  color: Colors.white),
                                              const SizedBox(width: 10),
                                              textPageTitle(
                                                  "${tripList[index].value["date"]} / ${tripList[index].value["time"]}"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.face,
                                                  color: Colors.white),
                                              const SizedBox(width: 10),
                                              textPageTitle(
                                                  "Driver: ${tripList[index].value["driver"]}"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                  Icons.star_outline_sharp,
                                                  color: Colors.white),
                                              const SizedBox(width: 10),
                                              textPageTitle(
                                                  "Status: ${tripList[index].value["reqStatus"]}"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          print("---------> Error: ${snapshot.error}");
                          return Card(
                            color: colorsAccepted,
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
                    )),
                  ),
                  Container(
                    // color: Colors.yellow,
                    child: Expanded(
                        child: StreamBuilder(
                      stream: tripsReference
                          .orderByChild("userID")
                          .equalTo(userID)
                          .onValue,
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.hasData &&
                            !snapshot.hasError &&
                            snapshot.data!.snapshot.value != null) {
                          Map<dynamic, dynamic>? trips = snapshot
                              .data!.snapshot.value as Map<dynamic, dynamic>?;
                          List<MapEntry> allList =
                              trips?.entries.toList() ?? [];
                          String status = "in-service";
                          List<MapEntry> tripList = allList
                              .where((entry) => entry.value["reqStatus"]
                                  .toString()
                                  .toLowerCase()
                                  .contains(status.toLowerCase()))
                              .toList();

                          return ListView.builder(
                            itemCount: tripList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => TripEnd(
                                    //         tripData: tripList[index].value,
                                    //         tripKey:
                                    //             tripList[index].key.toString()),
                                    //   ),
                                    // );
                                  },
                                  child: Card(
                                    color: colorsInservice,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.directions,
                                                  color: Colors.white),
                                              const SizedBox(width: 10),
                                              textPageTitle(
                                                  "${tripList[index].value["direction"]} - ${tripList[index].value["gate"]}")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.pin_drop_sharp,
                                                  color: Colors.white),
                                              const SizedBox(width: 10),
                                              textPageTitle(
                                                  "District: ${tripList[index].value["route"]}"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.access_time,
                                                  color: Colors.white),
                                              const SizedBox(width: 10),
                                              textPageTitle(
                                                  "${tripList[index].value["date"]} / ${tripList[index].value["time"]}"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.face,
                                                  color: Colors.white),
                                              const SizedBox(width: 10),
                                              textPageTitle(
                                                  "Driver: ${tripList[index].value["driver"]}"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                  Icons.star_outline_sharp,
                                                  color: Colors.white),
                                              const SizedBox(width: 10),
                                              textPageTitle(
                                                  "Status: ${tripList[index].value["reqStatus"]}"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          print("---------> Error: ${snapshot.error}");
                          return Card(
                            color: colorsInservice,
                            child: ListTile(
                              tileColor: Colors.transparent,
                              leading: const Icon(
                                Icons.bus_alert,
                                color: Colors.white,
                              ),
                              title: textPageTitle("No Trips In-service yet!"),
                            ),
                          );
                        }
                      },
                    )),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: ListTile(
                                  tileColor: colorsPrimary,
                                  title: const Text(
                                    "Explore Trips",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: const Icon(
                                    Icons.add_circle,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Routes()),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: ListTile(
                                  tileColor: colorsPrimary,
                                  title: const Text(
                                    "Requests",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: const Icon(
                                    Icons.checklist_rtl_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Requests()),
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
