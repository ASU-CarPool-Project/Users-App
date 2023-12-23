import 'package:flutter/material.dart';
import '../Model/MyWidgets.dart';
import 'package:firebase_database/firebase_database.dart';

class ReqAccepted extends StatefulWidget {
  const ReqAccepted({Key? key}) : super(key: key);

  @override
  State<ReqAccepted> createState() => _ReqAcceptedState();
}

class _ReqAcceptedState extends State<ReqAccepted> {
  DatabaseReference tripsReference =
      FirebaseDatabase.instance.ref().child("Requests");

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: StreamBuilder(
            stream: tripsReference.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data!.snapshot.value != null) {
                Map<dynamic, dynamic>? trips =
                    snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
                List<MapEntry> allList = trips?.entries.toList() ?? [];
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
                      child: Card(
                        color: colorsTrips2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Container(
                              color: Colors.white70,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.directions),
                                    title: Text(
                                        "${tripList[index].value["direction"]} - ${tripList[index].value["gate"]}"),
                                    subtitle: Text(
                                        "Route: ${tripList[index].value["route"]}"),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.access_time),
                                    title: Text(
                                        "Time: ${tripList[index].value["time"]}"),
                                    subtitle: Text(
                                        "Date: ${tripList[index].value["date"]}"),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Column(children: [
                                ListTile(
                                  leading: const Icon(Icons.car_rental),
                                  title: Text(
                                      "Car: ${tripList[index].value["car"]}"),
                                  subtitle: Text(
                                      "Capacity: ${tripList[index].value["capacity"]}"),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.person),
                                  title: Text(
                                      "Name: ${tripList[index].value["name"]}"),
                                  subtitle: Text(
                                      "Phone: ${tripList[index].value["phone"]}"),
                                ),
                              ]),
                            ),
                            Container(
                              color: Colors.white70,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.attach_money),
                                    title: Text(
                                        "Fees: ${tripList[index].value["fee"]}"),
                                    subtitle: Text(
                                        "Payment Method: ${tripList[index].value["payment"]}"),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.check,
                                        color: Colors.green),
                                    title: textStatusAccepted(
                                        "Request Status: ${tripList[index].value["reqStatus"]}"),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.redAccent),
                                ),
                                onPressed: () {
                                  DatabaseReference tripToDeleteReference =
                                      FirebaseDatabase.instance
                                          .ref()
                                          .child('Requests')
                                          .child(tripList[index].key!);
                                  tripToDeleteReference.remove().then((_) {
                                    print("Request Canceled successfully");
                                  }).catchError((error) {
                                    print("Failed to cancel request: $error");
                                  });
                                },
                                child: textButtons("Cancel"),
                              ),
                            )
                          ]),
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
                        textStatusAccepted("No Accepted Trips Found"),
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
