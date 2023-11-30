import 'package:flutter/material.dart';

import 'MyWidgets.dart';

List<Widget> myRequests = [];
List<String> myPayments = [];

class Requests extends StatefulWidget {
  final Widget? card;
  final String? paymentMethod;

  const Requests({Key? key, this.card, this.paymentMethod}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  void initState() {
    super.initState();
    if (widget.card != null) {
      if (!myRequests.contains(widget.card)) {
        myRequests.add(widget.card!);
        myPayments.add(widget.paymentMethod!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: const Icon(
            IconData(0xe093,
                fontFamily: 'MaterialIcons', matchTextDirection: true),
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: textPageTitle("Your Requests"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: ListView.builder(
              itemCount: myRequests.length,
              itemBuilder: (context, index) {
                String paymentMethod =
                    widget.paymentMethod ?? 'Payment Method Not Provided';
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          myRequests[index],
                          Padding(
                              padding: const EdgeInsets.all(5),
                              child:
                                  Text("Payment Method: ${myPayments[index]}")),
                          const Padding(
                              padding: EdgeInsets.all(5),
                              child: Text("Status: Pending/Accepted/Rejected")),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                              ),
                              child: textButtons("Cancel"),
                              onPressed: () {
                                myRequests.remove(myRequests[index]);
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
