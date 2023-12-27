// ignore_for_file: use_build_context_synchronously

import 'package:stocks_app/app.dart';

class MyWallet extends StatefulWidget {
  String title = 'Wallet';
  MyWallet(String name) {
    title = name;
  }

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  @override
  void initState() {
    super.initState();
    _getBalanceFromFirestore();
  }

  var nameController;

  double balance = 0.00;

  var wmoneyController = TextEditingController();

  int get1000 = 1000;

  int get5000 = 5000;

  int get10000 = 10000;

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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something Wrong with your input"),
        backgroundColor: Colors.red,
      ));
      print('Error updating balance: $e');
    }
  }

  Future<void> _deposit() async {
    double depositAmount = double.tryParse(wmoneyController.text) ?? 0.0;
    double newBalance = balance + depositAmount;

    await _updateBalanceInFirestore(newBalance);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Deposit Successfully"),
      backgroundColor: Colors.green,
    ));
    wmoneyController.clear();
  }

  Future<void> _withdraw() async {
    double withdrawAmount = double.tryParse(wmoneyController.text) ?? 0.0;
    double newBalance = balance - withdrawAmount;

    if (newBalance >= 0) {
      await _updateBalanceInFirestore(newBalance);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Withdraw successfully"),
        backgroundColor: Colors.green,
      ));
      wmoneyController.clear();
    } else {
      // print('Insufficient balance');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Insufficient balance"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 1000,
                  height: 440,
                  //color: Colors.redAccent,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: const Color.fromRGBO(207, 207, 207, 0.5),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 25),
                        child: const Padding(
                          padding: EdgeInsets.all(11.0),
                          child: Center(
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.wallet,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 15,
                      ),
                      const Center(
                        child: Text(
                          'AVAILABLE BALANCE',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                          child: Text(
                        '₹${balance.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 50),
                      )),
                      Container(
                        height: 30,
                      ),
                      Card(
                        color: Colors.white,
                        margin: const EdgeInsets.only(right: 15.0, left: 15.0),
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: TextField(
                            controller: wmoneyController,
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            style: const TextStyle(height: 2),
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Enter Amount(INR)'),
                          ),
                        ),
                      ),
                      Container(
                        height: 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                wmoneyController.text = get1000.toString();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black),
                              child: Text('₹$get1000'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 12, right: 12),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  wmoneyController.text = get5000.toString();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black),
                                child: Text('₹$get5000'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 12, left: 10),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: _withdraw,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            fixedSize: const Size(150, 50),
                            elevation: 11,
                            shadowColor: Colors.grey,
                          ),
                          child: const Text(
                            'WITHDRAW',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.only(left: 12, right: 10),
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: _deposit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            fixedSize: const Size(150, 50),
                            elevation: 11,
                            shadowColor: Colors.grey,
                          ),
                          child: const Text(
                            'DEPOSIT',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
