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
              stream:
                  tripsReference.orderByChild("userID").equalTo(userID).onValue,
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
                          color: Colors.yellow,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.pin_drop_sharp,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textPageTitle(
                                        "Route: ${tripList[index].value["route"]}"),
                                    textPageTitle(
                                        "${tripList[index].value["date"]} / ${tripList[index].value["time"]}"),
                                    textPageTitle(
                                        "Driver: ${tripList[index].value["driver"]}"),
                                    textPageTitle(
                                        "Complain: ${tripList[index].value["complain"]}"),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.check),
                                  onPressed: () {},
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
