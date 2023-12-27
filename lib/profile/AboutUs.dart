import 'package:flutter/material.dart';

class MyAboutUs extends StatelessWidget {
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
  MyAboutUs(String name) {
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
      body: Container(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: Color.fromRGBO(207, 207, 207, 0.5),
          ),
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      arrAbtTitle[index],
                      style: TextStyle(
                          fontFamily: 'FontMain',
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    subtitle: Text(arrAbtSubtitle[
                        index]), //style: TextStyle(fontFamily: 'FontMain', fontSize: 15, color: Colors.deepOrange),),
                    onTap: () {
                      print('a');
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 30, thickness: 3);
                },
                itemCount: arrAbtTitle.length),
          ),
        ),
      ),
    );
  }
}
