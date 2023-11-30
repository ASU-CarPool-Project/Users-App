import 'package:asu_carpool/Requests.dart';
import 'package:flutter/material.dart';
import 'package:asu_carpool/MyWidgets.dart';


class RoutesDesc extends StatefulWidget {
  final Widget card;
  const RoutesDesc({Key? key, required this.card}) : super(key: key);

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
          backgroundColor: Colors.indigo,
          title: textPageTitle("Pickup Request"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: ListView(
                      children: [
                        widget.card,
                      ],
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
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Requests(
                                card: widget.card,
                                paymentMethod:
                                _selectedPaymentMethod.toString().split('.').last
                            )
                        )
                    );
                    // Requests(card: widget.card);
                  }),
            ),
          ],
        ));
  }
}
