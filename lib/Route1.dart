import 'package:flutter/material.dart';
import 'MyWidgets.dart';
import 'RoutesDesc.dart';
import 'package:firebase_database/firebase_database.dart';

class Route1 extends StatefulWidget {
  const Route1({Key? key}) : super(key: key);

  @override
  State<Route1> createState() => _Route1State();
}

class _Route1State extends State<Route1> {
  DatabaseReference tripsReference =
      FirebaseDatabase.instance.ref().child("ToCollege");

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: StreamBuilder(
            stream: tripsReference
                .orderByChild("direction")
                .equalTo("ToCollege")
                .onValue,
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RoutesDesc(tripData: tripList[index].value),
                            ),
                          );
                        },
                        child: Card(
                          color: colorsTrips1,
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
                print("---------------------- Error :( ---> ${snapshot.error}");
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textLargeTitle("Searching for trips..."),
                        const CircularProgressIndicator()
                      ]),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
