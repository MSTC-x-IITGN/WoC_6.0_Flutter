// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stocks_app/menu_action.dart';
import 'package:stocks_app/model/stock.dart';
import 'package:stocks_app/model/stock_api.dart';
import 'package:stocks_app/utilities/stock_list_view.dart';

import '../utilities/dialogs/log_out_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FirebaseStockData _stockData;

  String get userId => FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    _stockData = FirebaseStockData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stocks App'),
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout && context.mounted) {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login', (route) => false);
                }
            }
          }, itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                  value: MenuAction.logout, child: Text('Log Out')),
            ];
          })
        ],
      ),
      body: StreamBuilder(
          stream: _stockData.getAllStocks(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allStocks = snapshot.data as Iterable<Stock>;
                  return StockListView(
                    stocks: allStocks,
                    onTap: (Stock stock) {},
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              default:
                return const CircularProgressIndicator();
            }
          }), //Stack(children: <Widget>[
      //   Container(
      //     padding: const EdgeInsets.all(10),
      //     width: MediaQuery.of(context).size.width,
      //     color: Colors.white,
      //     child: SafeArea(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           const Text(
      //             "Welcome to the Stocks App!",
      //             style: TextStyle(
      //               color: Colors.black,
      //               fontSize: 20,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //           const Padding(
      //             padding: EdgeInsets.only(top: 10.0),
      //             child: SizedBox(
      //               height: 50,
      //               child: TextField(
      //                 decoration: InputDecoration(
      //                     hintStyle: TextStyle(color: Colors.black),
      //                     hintText: "Search",
      //                     prefix: Icon(Icons.search),
      //                     fillColor: Colors.grey,
      //                     filled: true,
      //                     border: OutlineInputBorder(
      //                         borderSide: BorderSide(
      //                           width: 0,
      //                           style: BorderStyle.none,
      //                         ),
      //                         borderRadius:
      //                             BorderRadius.all(Radius.circular(10)))),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   )
      // ]),
    );
  }
}
