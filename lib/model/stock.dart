import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@immutable
class Stock {
  final String name;
  final String symbol;
  final String documentId;
  final String price;
  final String change;

  const Stock({
    required this.name,
    required this.symbol,
    required this.price,
    required this.documentId,
    required this.change,
  });

  Stock.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        name = snapshot.data()['Name'] as String,
        symbol = snapshot.data()['Symbol'] as String,
        price = snapshot.data()['Price'] as String,
        change = snapshot.data()['Change'] as String;
}

  // static List<Stock> getAll() {
  //   List<Stock> stocks = List<Stock>.empty();

  //   stocks.add(Stock(name: 'Apple', symbol: 'AAPL', price: 148.97));
  //   stocks.add(Stock(name: 'Microsoft', symbol: 'MSFT', price: 301.88));
  //   stocks.add(Stock(name: 'Google', symbol: 'GOOGL', price: 2721.99));
  //   stocks.add(Stock(name: 'Facebook', symbol: 'FB', price: 355.64));
  //   stocks.add(Stock(name: 'Tesla', symbol: 'TSLA', price: 759.49));
  //   stocks.add(Stock(name: 'Amazon', symbol: 'AMZN', price: 3349.63));
  //   stocks.add(Stock(name: 'Netflix', symbol: 'NFLX', price: 571.89));
  //   stocks.add(Stock(name: 'Nvidia', symbol: 'NVDA', price: 223.90));
  //   stocks.add(Stock(name: 'PayPal', symbol: 'PYPL', price: 279.00));
  //   stocks.add(Stock(name: 'Adobe', symbol: 'ADBE', price: 642.00));
  //   stocks.add(Stock(name: 'Intel', symbol: 'INTC', price: 53.00));
  //   stocks.add(Stock(name: 'AMD', symbol: 'AMD', price: 106.00));
  //   stocks.add(Stock(name: 'Nokia', symbol: 'NOK', price: 5.00));
  //   stocks.add(Stock(name: 'IBM', symbol: 'IBM', price: 140.00));
  //   stocks.add(Stock(name: 'Cisco', symbol: 'CSCO', price: 55.00));
  //   stocks.add(Stock(name: 'Oracle', symbol: 'ORCL', price: 90.00));
  //   stocks.add(Stock(name: 'Qualcomm', symbol: 'QCOM', price: 150.00));
  //   stocks.add(Stock(name: 'HP', symbol: 'HPQ', price: 30.00));
  //   stocks.add(Stock(name: 'Sony', symbol: 'SONY', price: 102.00));
  //   stocks.add(Stock(name: 'Samsung', symbol: 'SSNLF', price: 205.00));
  //   stocks.add(Stock(name: 'LG', symbol: 'LPL', price: 55.00));
  //   stocks.add(Stock(name: 'Blackberry', symbol: 'BB', price: 32.00));
  //   stocks.add(Stock(name: 'Alibaba', symbol: 'BABA', price: 56.00));
  //   stocks.add(Stock(name: 'Tencent', symbol: 'TCEHY', price: 70.00));
  //   stocks.add(Stock(name: 'Baidu', symbol: 'BIDU', price: 45.00));
  //   stocks.add(Stock(name: 'JD.com', symbol: 'JD', price: 70.00));
  //   stocks.add(Stock(name: 'Pinduoduo', symbol: 'PDD', price: 43.00));
  //   stocks.add(Stock(name: 'Meituan', symbol: 'MPNGY', price: 80.00));
  //   stocks.add(Stock(name: 'Xiaomi', symbol: 'XIACF', price: 234.00));
  //   stocks.add(Stock(name: 'Nio', symbol: 'NIO', price: 22.00));
  //   stocks.add(Stock(name: 'XPeng', symbol: 'XPEV', price: 32.00));
  //   stocks.add(Stock(name: 'Li Auto', symbol: 'LI', price: 11.00));
  //   stocks.add(Stock(name: 'BYD', symbol: 'BYDDF', price: 21.00));
  //   stocks.add(Stock(name: 'Geely', symbol: 'GELYF', price: 100.00));
  //   stocks.add(Stock(name: 'Alphabet', symbol: 'GOOG', price: 334.00));
  //   stocks.add(Stock(name: 'Twitter', symbol: 'TWTR', price: 69.00));
  //   stocks.add(Stock(name: 'Snap', symbol: 'SNAP', price: 130.00));
  //   stocks.add(Stock(name: 'Pinterest', symbol: 'PINS', price: 110.00));
  //   stocks.add(Stock(name: 'Uber', symbol: 'UBER', price: 100.0

  //   return stocks;
  // }
