import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// My Colors
Color? colorsPrimary = const Color.fromRGBO(70, 54, 252, 1);
Color? colorsTrips1 = const Color.fromRGBO(81, 112, 253, 1);
Color? colorsTrips2 = const Color.fromRGBO(96, 171, 251, 1);
Color? colorsCards = const Color.fromRGBO(174, 225, 252, 1);
Color? colorsAccepted = Colors.green;
Color? colorsInservice = Colors.orange;
Color? colorsDeclined = Colors.red;
Color? colorsComplain = Colors.deepOrange;

/// Text Widgets
Widget textButtons(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 16.0,
      color: Colors.white,
    ),
  );
}

Widget textPageTitle(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

Widget textLargeTitle(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: TextStyle(fontSize: 24, color: colorsPrimary),
    ),
  );
}

Widget textPlace(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

Widget textStatusPending(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 18, color: Colors.orange),
    ),
  );
}

Widget textStatusAccepted(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 18, color: Colors.green),
    ),
  );
}

Widget textStatusDeclined(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 18, color: Colors.red),
    ),
  );
}

/// Icons
Widget iconBack(BuildContext context) {
  return IconButton(
    icon: const Icon(
      IconData(
        0xe093,
        fontFamily: 'MaterialIcons',
        matchTextDirection: true,
      ),
      color: Colors.white,
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
}

/// Toast Messages
Future<bool?> toastMsg(String message) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 4,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

/// Trip Cards
Widget tripCardWithMethod(
  String? direction,
  String? route,
  String? district,
  String? time,
  String? date,
  String? car,
  String? capacity,
  String? driver,
  String? phone,
  String? fees,
  VoidCallback onDeletePressed,
) {
  return Card(
    color: colorsTrips1,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Container(
          color: Colors.white70,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.directions),
                title: Text(route!),
                subtitle: Text("District: $district"),
              ),
              ListTile(
                leading: const Icon(Icons.access_time),
                title: Text("Time: $time"),
                subtitle: Text("Date: $date"),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(children: [
            ListTile(
              leading: const Icon(Icons.car_rental),
              title: Text("Car: $car"),
              subtitle: Text("Capacity: $capacity"),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text("Driver: $driver"),
              subtitle: Text("Phone: $phone"),
            ),
          ]),
        ),
        Container(
          color: Colors.white70,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.attach_money),
                title: Text("Fees: $fees"),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.redAccent),
            ),
            onPressed: onDeletePressed,
            child: textButtons("Delete"),
          ),
        )
      ]),
    ),
  );
}

Widget tripCardWithoutMethod(
  String? route,
  String? district,
  String? time,
  String? date,
  String? car,
  String? capacity,
  String? driver,
  String? phone,
  String? fees,
) {
  return Card(
    color: colorsTrips1,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Container(
          color: Colors.white70,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.directions),
                title: Text(route!),
                subtitle: Text("District: $district"),
              ),
              ListTile(
                leading: const Icon(Icons.access_time),
                title: Text("Time: $time"),
                subtitle: Text("Date: $date"),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(children: [
            ListTile(
              leading: const Icon(Icons.car_rental),
              title: Text("Car: $car"),
              subtitle: Text("Capacity: $capacity"),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text("Driver: $driver"),
              subtitle: Text("Phone: $phone"),
            ),
          ]),
        ),
        Container(
          color: Colors.white70,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.attach_money),
                title: Text("Fees: $fees"),
              ),
            ],
          ),
        ),
      ]),
    ),
  );
}
