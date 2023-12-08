import 'package:flutter/material.dart';
import 'MyWidgets.dart';
import 'MyWidgets.dart';
import 'RoutesDesc.dart';
import 'package:firebase_database/firebase_database.dart';

class Route2 extends StatefulWidget {
  const Route2({Key? key}) : super(key: key);

  @override
  State<Route2> createState() => _Route2State();
}

class _Route2State extends State<Route2> {
  DatabaseReference tripsReference =
  FirebaseDatabase.instance.ref().child("FromCollege");

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: StreamBuilder(
            stream: tripsReference.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data!.snapshot.value != null) {
                Map<dynamic, dynamic>? trips =
                snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
                List<MapEntry> tripList = trips?.entries.toList() ?? [];

                return ListView.builder(
                  itemCount: trips?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RoutesDesc(
                                card: Card(
                                  color: colorsRoute2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(children: [
                                      Container(
                                        color: Colors.white70,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: Icon(Icons.directions),
                                              title: Text(
                                                  "${tripList[index].value["direction"]} - ${tripList[index].value["gate"]}"),
                                              subtitle: Text(
                                                  "Route: ${tripList[index].value["route"]}"),
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.access_time),
                                              title:
                                              Text("Time: ${tripList[index].value["time"]}"),
                                              subtitle:
                                              Text("Date: ${tripList[index].value["date"]}"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        child: Column(children: [
                                          ListTile(
                                            leading: Icon(Icons.car_rental),
                                            title: Text("Car: ${tripList[index].value["car"]}"),
                                            subtitle: Text(
                                                "Capacity: ${tripList[index].value["capacity"]}"),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.person),
                                            title: Text("Name: ${tripList[index].value["name"]}"),
                                            subtitle:
                                            Text("Phone: ${tripList[index].value["phone"]}"),
                                          ),
                                        ]),
                                      ),
                                      Container(
                                        color: Colors.white70,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: Icon(Icons.attach_money),
                                              title:
                                              Text("Fees: ${tripList[index].value["fee"]}"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(
                                                Colors.redAccent),
                                          ),
                                          onPressed: () {
                                            DatabaseReference tripToDeleteReference =
                                            FirebaseDatabase.instance
                                                .ref()
                                                .child('FromCollege')
                                                .child(tripList[index].key!);
                                            tripToDeleteReference.remove().then((_) {
                                              print("Trip deleted successfully");
                                            }).catchError((error) {
                                              print("Failed to delete trip: $error");
                                            });
                                          },
                                          child: textButtons("Delete"),
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: colorsRoute2,
                          child: ListTile(
                            tileColor: Colors.transparent,
                            leading: const Icon(Icons.pin_drop_sharp, color: Colors.white,),
                            title: textPageTitle(
                                "Route: ${tripList[index].value["route"]}"),
                            subtitle: textPageTitle(
                                "Driver: ${tripList[index].value["name"]}"),
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
