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
                      child: tripCardTrack(
                        "${widget.tripData["direction"]} - ${widget.tripData["gate"]}",
                        "${widget.tripData["route"]}",
                        "${widget.tripData["time"]}",
                        "${widget.tripData["date"]}",
                        "${widget.tripData["car"]}",
                        "${widget.tripData["capacity"]}",
                        "${widget.tripData["driver"]}",
                        "${widget.tripData["phone"]}",
                        "${widget.tripData["fee"]}",
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
                  // Get the current date and time
                  DateTime currentDate = DateTime.now();

                  // Calculate the reservation deadline based on the trip time
                  DateTime reservationDeadline;
                  if (widget.tripData["time"] == "7:30 AM") {
                    reservationDeadline = DateTime(
                      currentDate.year,
                      currentDate.month,
                      currentDate.day - 1,
                      22, // 10:00 PM
                      0,
                    );
                  } else if (widget.tripData["time"] == "5:30 PM") {
                    reservationDeadline = DateTime(
                      currentDate.year,
                      currentDate.month,
                      currentDate.day,
                      13, // 1:00 PM
                      0,
                    );
                  } else {
                    // Handle other trip times if needed
                    reservationDeadline = DateTime.now();
                  }

                  // Check if the current date and time are within the reservation deadline
                  if (currentDate.isBefore(reservationDeadline)) {
                    // Reservation deadline not reached, proceed with the reservation
                    DatabaseReference databaseReference =
                        FirebaseDatabase.instance.ref();
                    await databaseReference.child('Requests').push().set({
                      "userID": userID,
                      "client": username,
                      "driverID": widget.tripData["driverID"],
                      "driver": widget.tripData["driver"],
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
                      "payment":
                          _selectedPaymentMethod.toString().split('.').last,
                      "reqStatus": "Pending",
                    });

                    print("Request Added Successfully");
                  } else {
                    // Reservation deadline reached, notify the user
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Reservation Deadline Exceeded"),
                          content: const Text(
                              "The reservation deadline has passed."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
                child: textButtons("Request as a tester"),
                onPressed: () async {
                  // Reservation deadline not reached, proceed with the reservation
                  DatabaseReference databaseReference =
                      FirebaseDatabase.instance.ref();
                  await databaseReference.child('Requests').push().set({
                    "userID": userID,
                    "client": username,
                    "driverID": widget.tripData["driverID"],
                    "driver": widget.tripData["driver"],
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
                    "payment":
                        _selectedPaymentMethod.toString().split('.').last,
                    "reqStatus": "Pending",
                  });

                  print("Test Request Added Successfully");
                },
              ),
            ),
          ],
        ));
  }
}
