import 'package:flutter/material.dart';

import 'RoutesDesc.dart';

class Route2 extends StatefulWidget {
  const Route2({Key? key}) : super(key: key);

  @override
  State<Route2> createState() => _Route2State();
}

List<Map<String, String>> Routes2 = [
  {
    "Route": "From Gate 2 to Abbasseya",
    "Name": "Philo",
    "Car": "Toyota Corolla",
    "Capacity": "4",
    "Time": "6:30",
    "Waiting Time": "5 Minutes",
    "Fee": "10\$"
  },
  {
    "Route": "From Gate 4 to Abbasseya",
    "Name": "Omar",
    "Car": "Optra",
    "Capacity": "4",
    "Time": "6:30",
    "Waiting Time": "5 Minutes",
    "Fee": "10\$"
  },
  {
    "Route": "From Gate 2 to Settlement",
    "Name": "Osama",
    "Car": "Honda Civic",
    "Capacity": "3",
    "Time": "6:30",
    "Waiting Time": "5 Minutes",
    "Fee": "30\$"
  },
];



class _Route2State extends State<Route2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: ListView.builder(
            itemCount: Routes2.length,
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
                                        Text("Route: ${Routes2[index]["Route"]}"),
                                        Text("Name: ${Routes2[index]["Name"]}"),
                                        Text("Car: ${Routes2[index]["Car"]}"),
                                        Text("Capacity: ${Routes2[index]["Capacity"]}"),
                                        Text("Time: ${Routes2[index]["Time"]}"),
                                        Text("Waiting Time: ${Routes2[index]["Waiting Time"]}"),
                                        Text("Fee: ${Routes2[index]["Fee"]}"),
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
                      title: Text("${Routes2[index]["Route"]}"),
                      subtitle: Text("Driver: ${Routes2[index]["Name"]}"),
                    ),
                  ),
                    // child: Card(
                    //     color: Colors.white70,
                    //     child: Padding(
                    //       padding: EdgeInsets.all(20),
                    //       child: Column(
                    //         children: [
                    //           Text("Route: ${Routes2[index]["Route"]}"),
                    //           Text("Name: ${Routes2[index]["Name"]}"),
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
