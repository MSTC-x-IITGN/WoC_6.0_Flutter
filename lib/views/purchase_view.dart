// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:stocks_app/app.dart';

class BuySellStockPage extends StatefulWidget {
  final String stockSymbol;
  final double price;

  const BuySellStockPage(
      {Key? key, required this.stockSymbol, required this.price})
      : super(key: key);

  @override
  _BuySellStockPageState createState() => _BuySellStockPageState();
}

class _BuySellStockPageState extends State<BuySellStockPage> {
  @override
  void initState() {
    _getBalanceFromFirestore();
    _getInvestedAmtFirestore();
    _calculateTotalPrice();
    super.initState();
  }

  int quantity = 1;
  double totalPrice = 0.0;
  double investedAmt = 0.0;
  double balance = 0.0;
  final TextEditingController _quantityController = TextEditingController();

  void _calculateTotalPrice() {
    setState(() {
      totalPrice =
          widget.price * quantity; // Assuming stock.price is the price per unit
    });
  }

  Future<void> buyStock() async {
    String stockName = widget.stockSymbol;
    quantity = int.tryParse(_quantityController.text.trim()) ?? 0;
    double investment = widget.price * quantity;
    User? user = FirebaseAuth.instance.currentUser;
    if (stockName.isNotEmpty && quantity > 0 && investment > 0) {
      if (user != null) {
        // Calculate total invested amount
        double totalInvestedAmount = investment;
        // Create a reference to the user's collection of purchased stocks
        CollectionReference userStocks = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('purchased_stocks');

        DocumentSnapshot stockSnapshot = await userStocks.doc(stockName).get();
        if (balance < totalInvestedAmount) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Insufficient balance'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        if (stockSnapshot.exists) {
          // Update existing stock quantity and invested amount
          int currentQuantity =
              (stockSnapshot.data() as Map<String, dynamic>)['quantity'] ?? 0;
          double currentInvestedAmount = (stockSnapshot.data()
                  as Map<String, dynamic>)['invested_amount'] ??
              0.0;

          totalInvestedAmount += currentInvestedAmount;
          balance -= investment;
          investedAmt += investment;

          await userStocks.doc(stockName).update({
            'quantity': currentQuantity + quantity,
            'invested_amount': totalInvestedAmount,
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Please wait! We are still processing your request'),
              backgroundColor: Colors.blueGrey,
            ),
          );
        } else {
          // Create a new entry for the purchased stock
          await userStocks.doc(stockName).set({
            'quantity': quantity,
            'invested_amount': totalInvestedAmount,
          });
          totalInvestedAmount += 0;
          balance -= investment;
          investedAmt += investment;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Please wait! We are still processing your request'),
              backgroundColor: Colors.blueGrey,
            ),
          );
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Purchase Successful! Will be reflected shortly'),
            backgroundColor: Colors.green,
          ),
        );
        await _updateBalanceInFirestore(balance);
        await _getBalanceFromFirestore();
        await _updateInvestAmtInFirestore(investedAmt);

        // Reset the input fields after successful purchase
        _quantityController.clear();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something Went Wrong'),
          backgroundColor: Colors.red,
        ),
      );
      print('Invalid input data for buying stock');
    }
  }

  Future<void> _updateBalanceInFirestore(double newBalance) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'balance': newBalance,
        });
        setState(() {
          balance = newBalance;
        });
      }
    } catch (e) {
      print('Error updating balance: $e');
    }
  }

  Future<void> _updateInvestAmtInFirestore(double totalInvestment) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'investedAmt': totalInvestment,
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something Wrong with Gateway!'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error updating balance: $e');
    }
  }

  Future<void> _getBalanceFromFirestore() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userSnapshot.exists) {
          setState(() {
            balance =
                (userSnapshot.data() as Map<String, dynamic>)['balance'] ?? 0.0;
          });
        }
      }
    } catch (e) {
      print('Error retrieving balance: $e');
    }
  }

  Future<void> _getInvestedAmtFirestore() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userSnapshot.exists) {
          setState(() {
            investedAmt =
                (userSnapshot.data() as Map<String, dynamic>)['investedAmt'] ??
                    0.0;
          });
        }
        if (investedAmt < 0) {
          investedAmt = 0.0;
        }
      }
    } catch (e) {
      print('Error retrieving balance: $e');
    }
  }

  Future<void> sellStock() async {
    String stockName = widget.stockSymbol;
    quantity = int.tryParse(_quantityController.text.trim()) ?? 0;
    double investment = widget.price * quantity;
    User? user = FirebaseAuth.instance.currentUser;
    if (stockName.isNotEmpty && quantity > 0 && investment > 0) {
      if (user != null) {
        // Calculate total invested amount
        double totalInvestedAmount = investment;
        // Create a reference to the user's collection of purchased stocks
        CollectionReference userStocks = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('purchased_stocks');

        DocumentSnapshot stockSnapshot = await userStocks.doc(stockName).get();
        if (stockSnapshot.exists) {
          // Update existing stock quantity and invested amount
          int currentQuantity =
              (stockSnapshot.data() as Map<String, dynamic>)['quantity'] ?? 0;
          double currentInvestedAmount = (stockSnapshot.data()
                  as Map<String, dynamic>)['invested_amount'] ??
              0.0;

          if (currentQuantity < quantity) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Insufficient quantity'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          totalInvestedAmount = currentInvestedAmount - investment;
          balance += investment;
          investedAmt -= investment;

          await userStocks.doc(stockName).update({
            'quantity': currentQuantity - quantity,
            'invested_amount': totalInvestedAmount,
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You do not own this stock'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sale Successful'),
            backgroundColor: Colors.green,
          ),
        );
        await _updateBalanceInFirestore(balance);
        await _getBalanceFromFirestore();
        await _updateInvestAmtInFirestore(investedAmt);

        // Reset the input fields after successful purchase
        _quantityController.clear();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something Went Wrong'),
          backgroundColor: Colors.red,
        ),
      );
      print('Invalid input data for buying stock');
    }
  }

  @override
  Widget build(BuildContext context) {
    final symbol = widget.stockSymbol;
    final balance = this.balance.toStringAsFixed(2);
    final investedAmt = this.investedAmt.toStringAsFixed(2);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy/Sell Stocks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Stock Name; $symbol',
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  quantity = int.tryParse(_quantityController.text.trim()) ?? 0;
                  _calculateTotalPrice(); // Recalculate total price when quantity changes
                });
              },
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            const SizedBox(height: 10),
            Text(
              'Total Price: ${totalPrice.toStringAsFixed(2)}',
            ),
            Text(
              'Available Balance: $balance',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: buyStock,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Buy'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: sellStock,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Sell')),
          ],
        ),
      ),
    );
  }
}
