import 'package:flutter/material.dart';
import 'MyWidgets.dart';
import 'package:firebase_database/firebase_database.dart';
import "home.dart";

String myResponse = "";

class complains extends StatefulWidget {
  const complains({Key? key}) : super(key: key);

  @override
  State<complains> createState() => _complainsState();
}

class _complainsState extends State<complains> {
  DatabaseReference tripsReference =
      FirebaseDatabase.instance.ref().child("Requests");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorsPrimary,
        leading: iconBack(context),
        title: textPageTitle("Complains"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: StreamBuilder(
              stream: tripsReference
                  .orderByChild("driverID")
                  .equalTo(userID)
                  .onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data!.snapshot.value != null) {
                  Map<dynamic, dynamic>? trips =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
                  List<MapEntry> allList = trips?.entries.toList() ?? [];
                  String status = "issue:";
                  List<MapEntry> tripList = allList
                      .where((entry) => entry.value["complain"]
                          .toString()
                          .toLowerCase()
                          .contains(status.toLowerCase()))
                      .toList();

                  return ListView.builder(
                    itemCount: tripList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          color: colorsComplain,
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
                                    const Icon(Icons.face, color: Colors.white),
                                    const SizedBox(width: 10),
                                    textPageTitle(
                                        "Client: ${tripList[index].value["driver"]}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.info_outline_rounded,
                                        color: Colors.white),
                                    const SizedBox(width: 10),
                                    textPageTitle(
                                        "${tripList[index].value["complain"]}"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textLargeTitle("No Complains Found"),
                        // const CircularProgressIndicator(),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////
}
