import 'stock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStockData {
  final stocks = FirebaseFirestore.instance.collection('stocks');

  Stream<Iterable<Stock>> getAllStocks() {
    return stocks
        .snapshots()
        .map((event) => event.docs.map((doc) => Stock.fromSnapshot(doc)));
  }

  Future<Iterable<Stock>> getStocks({required String ownerUserId}) async {
    try {
      return await stocks.get().then(
            (value) => value.docs.map(
              (doc) => Stock.fromSnapshot(doc),
            ),
          );
    } catch (e) {
      throw Exception('Error fetching stocks: $e');
    }
  }

  static final FirebaseStockData _shared = FirebaseStockData._sharedInstance();

  FirebaseStockData._sharedInstance();

  factory FirebaseStockData() => _shared;
}
