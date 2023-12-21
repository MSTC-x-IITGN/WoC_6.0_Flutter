// import 'package:flutter/material.dart';
// import 'package:stocks_app/model/stock_price_api.dart';

// typedef StockCallBack = void Function(Stock stock);

// class StockListView extends StatelessWidget {
//   final Iterable<Stock> stocks;
//   final StockCallBack? onTap;

//   const StockListView({
//     Key? key,
//     required this.stocks,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: stocks.length,
//       itemBuilder: (context, index) {
//         final stock = stocks.elementAt(index);
//         return ListTile(
//           onTap: () {}, //Add code to navigate to specific stock page
//           contentPadding: const EdgeInsets.all(10),
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 stock.name,
//                 softWrap: true,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               Text(
//                 stock.symbol,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//           trailing: Column(
//             children: [
//               Text(
//                 stock.price.toString(),
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 width: 100,
//                 height: 25,
//                 decoration: BoxDecoration(
//                   color:
//                       int.parse(stock.change) > 0 ? Colors.green : Colors.red,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Text(
//                   '${stock.change}%',
//                   style: const TextStyle(
//                     fontSize: 15,
//                     color: Colors.white,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
