import 'package:flutter/material.dart';

class MyCustomerSupport extends StatelessWidget {
  var arrAbtTitle = [
    'About Platform',
    'Privacy Policy',
    'Terms of Use',
    'Risk Disclosure',
    'Listing/Delisiting Policy',
    'Refund/Cancellation Policy',
    'Beta Testing Policy'
  ];
  var arrAbtSubtitle = [
    'Know more about application',
    'How we collect, use and protect your data',
    'The terms governing use of Platform',
    'Outlinig the risks associated with services/products available on Platform',
    'Explains the framework of listing/delisting a token on this Platform',
    'Explains the circumstances, conditions, and timelines where returns, exchange, and refunds are processed by Application',
    "Explains the rules, terms, and conditions you agree with to participate in our Platform/'s early access and beta testing programs"
  ];

  String title = 'AboutUs';
  MyCustomerSupport(String name, {super.key}) {
    title = name;
  }
  var nameController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 745,
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: const Color.fromRGBO(207, 207, 207, 0.5),
              ),
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                        ),
                      ),
                      margin: const EdgeInsets.all(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 50,
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                          ),
                          const Text(
                            'ADDRESS',
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 40),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "DA-IICT, DA-IICT Road,\nGandhinagar 382 007,\nGujarat (India)",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black)),
                      ),
                      margin: const EdgeInsets.all(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.call,
                            size: 50,
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                          ),
                          const Text(
                            'CONTACT NO',
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 40),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Central Office:\n92500-07070\n\nWhatsApp:\n+91 85001 85001\n\nMain Branch(Available 24x7):\n0261-898770",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black)),
                      ),
                      margin: const EdgeInsets.all(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.email,
                            size: 50,
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                          ),
                          const Text(
                            'EMAIL ID',
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 40),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "customercare@gmail.com\nmarket07@gmail.com",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
