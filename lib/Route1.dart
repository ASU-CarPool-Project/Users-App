import 'package:flutter/material.dart';

import 'RoutesDesc.dart';

class Route1 extends StatefulWidget {
  const Route1({Key? key}) : super(key: key);

  @override
  State<Route1> createState() => _Route1State();
}

List<Map<String, String>> Routes1 = [
  {
    "Route": "From Abbasseya to Gate 4",
    "Name": "Mohamed",
    "Car": "Honda",
    "Capacity": "3",
    "Time": "4:30",
    "Waiting Time": "5 Min",
    "Fee": "10\$"
  },
  {
    "Route": "From Obour to Gate 4",
    "Name": "Ayoub",
    "Car": "Seat",
    "Capacity": "4",
    "Time": "4:30",
    "Waiting Time": "5 Min",
    "Fee": "20\$"
  },
  {
    "Route": "From Maadi to Gate 4",
    "Name": "Ziad",
    "Car": "Hyundai Elantra",
    "Capacity": "4",
    "Time": "4:30",
    "Waiting Time": "5 Min",
    "Fee": "20\$"
  },
];

class _Route1State extends State<Route1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: ListView.builder(
            itemCount: Routes1.length,
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
                                color: Colors.white70,
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Text("Route: ${Routes1[index]["Route"]}"),
                                      Text("Name: ${Routes1[index]["Name"]}"),
                                      Text("Car: ${Routes1[index]["Car"]}"),
                                      Text("Capacity: ${Routes1[index]["Capacity"]}"),
                                      Text("Time: ${Routes1[index]["Time"]}"),
                                      Text("Waiting Time: ${Routes1[index]["Waiting Time"]}"),
                                      Text("Fee: ${Routes1[index]["Fee"]}"),
                                    ],
                                  ),
                                )
                            )
                          ),
                        ),
                      );
                    },
                  child: Card(
                    color: Colors.white70,
                    child: ListTile(
                      tileColor: Colors.transparent,
                      leading: const Icon(Icons.pin_drop_sharp),
                      title: Text("${Routes1[index]["Route"]}"),
                      subtitle: Text("Driver: ${Routes1[index]["Name"]}"),
                    ),
                  )
                    // child: Card(
                    //     color: Colors.white70,
                    //     child: Padding(
                    //       padding: EdgeInsets.all(20),
                    //       child: Column(
                    //         children: [
                    //           Text("Route: ${Routes1[index]["Route"]}"),
                    //           Text("Name: ${Routes1[index]["Name"]}"),
                    //         ],
                    //       ),
                    //     )
                    // )
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
