import 'package:asu_carpool/Requests.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:asu_carpool/MyWidgets.dart';

import 'Routes.dart';

class RoutesDesc extends StatefulWidget {
  final Map<String, dynamic> tripData;
  const RoutesDesc({Key? key, required this.tripData}) : super(key: key);

  @override
  State<RoutesDesc> createState() => _RoutesDescState();
}

enum PaymentMethod { Cash, CreditCard }

class _RoutesDescState extends State<RoutesDesc> {
  PaymentMethod? _selectedPaymentMethod = PaymentMethod.Cash;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorsPrimary,
          title: textPageTitle("Pickup Request"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Card(
                        color: colorsRoute1,
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
                                        "${widget.tripData["direction"]} - ${widget.tripData["gate"]}"),
                                    subtitle: Text(
                                        "Route: ${widget.tripData["route"]}"),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.access_time),
                                    title:
                                        Text("Time: ${widget.tripData["time"]}"),
                                    subtitle:
                                        Text("Date: ${widget.tripData["date"]}"),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Column(children: [
                                ListTile(
                                  leading: Icon(Icons.car_rental),
                                  title: Text("Car: ${widget.tripData["car"]}"),
                                  subtitle: Text(
                                      "Capacity: ${widget.tripData["capacity"]}"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text("Name: ${widget.tripData["name"]}"),
                                  subtitle:
                                      Text("Phone: ${widget.tripData["phone"]}"),
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
                                        Text("Fees: ${widget.tripData["fee"]}"),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("Choose your payment method"),
                      ),
                      ListTile(
                        title: const Text('Cash'),
                        leading: Radio(
                          value: PaymentMethod.Cash,
                          groupValue: _selectedPaymentMethod,
                          onChanged: (PaymentMethod? value) {
                            setState(() {
                              _selectedPaymentMethod = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Credit Card'),
                        leading: Radio(
                          value: PaymentMethod.CreditCard,
                          groupValue: _selectedPaymentMethod,
                          onChanged: (PaymentMethod? value) {
                            setState(() {
                              _selectedPaymentMethod = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  child: textButtons("Request"),
                  onPressed: () async {
                    DatabaseReference databaseReference =
                        FirebaseDatabase.instance.ref();
                    await databaseReference
                        .child('Requests')
                        .child('Pending')
                        .push()
                        .set({
                      "userID": userID,
                      "driverID": widget.tripData["userID"],
                      "direction": widget.tripData["direction"],
                      "route": widget.tripData["route"],
                      "name": widget.tripData["name"],
                      "phone": widget.tripData["phone"],
                      "car": widget.tripData["car"],
                      "capacity": widget.tripData["capacity"],
                      "time": widget.tripData["time"],
                      "date": widget.tripData["date"],
                      "gate": widget.tripData["gate"],
                      "fee": widget.tripData["fee"],
                      "payment": _selectedPaymentMethod.toString().trim(),
                      "reqStatus": "Pending",
                    });

                    print("added successfully");
                  }),
            ),
          ],
        ));
  }
}
