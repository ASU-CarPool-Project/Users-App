import 'package:asu_carpool/View/ReqAccepted.dart';
import 'package:asu_carpool/View/ReqDeclined.dart';
import 'package:flutter/material.dart';
import '../Model/MyWidgets.dart';
import 'ReqPending.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: colorsPrimary,
            leading: iconBack(context),
            title: textPageTitle("Requests History"),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.pending, color: Colors.white),
                      Text(
                        'Pending',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Tab(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, color: Colors.white),
                      Text(
                        'Accepted',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Tab(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.dangerous_rounded, color: Colors.white),
                      Text(
                        'Declined',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [ReqPending(), ReqAccepted(), ReqDeclined()],
          ),
        ));
  }
}
