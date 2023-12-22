import 'package:flutter/material.dart';
import 'MyWidgets.dart';
import 'package:firebase_database/firebase_database.dart';
import "home.dart";

String myResponse = "";

class TripsHistory extends StatefulWidget {
  const TripsHistory({Key? key}) : super(key: key);

  @override
  State<TripsHistory> createState() => _TripsHistoryState();
}

class _TripsHistoryState extends State<TripsHistory> {
  DatabaseReference tripsReference =
      FirebaseDatabase.instance.ref().child("Requests");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorsPrimary,
        leading: iconBack(context),
        title: textPageTitle("Trips History"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: StreamBuilder(
              stream:
                  tripsReference.orderByChild("userID").equalTo(userID).onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data!.snapshot.value != null) {
                  Map<dynamic, dynamic>? trips =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
                  List<MapEntry> tripList = trips?.entries.toList() ?? [];

                  return ListView.builder(
                    itemCount: tripList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          color: colorsPrimary,
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
                                        "Driver: ${tripList[index].value["driver"]}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.star_outline_sharp,
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
