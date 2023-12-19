import 'package:flutter/material.dart';
import 'MyWidgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Routes.dart';

class ReqPending extends StatefulWidget {
  const ReqPending({Key? key}) : super(key: key);

  @override
  State<ReqPending> createState() => _ReqPendingState();
}

class _ReqPendingState extends State<ReqPending> {
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
            stream:
                tripsReference.orderByChild("userID").equalTo(userID).onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data!.snapshot.value != null) {
                Map<dynamic, dynamic>? trips =
                    snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
                List<MapEntry> allList = trips?.entries.toList() ?? [];
                String status = "Pending";
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
                        color: colorsRoute2,
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
                                      "Driver: ${tripList[index].value["driver"]}"),
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
                                    leading: const Icon(Icons.pending,
                                        color: Colors.orange),
                                    title: textStatusPending(
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
                                          .child("Pending")
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
                        textStatusPending("No Pending Trips Found"),
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
