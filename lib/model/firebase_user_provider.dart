import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stocks_app/model/user.dart';

Future<Users?> getUserDetailsFromFirestore(String userId) async {
  Users? user;
  try {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      // Access user data from the 'userData' map
      user!.email = userData['email'];
      user.name = userData['name'];
      user.phone = userData['phone'];
      user.imageUrl = userData['imageUrl'];
      user.balance = userData['balance'];
      user.investedAmt = userData['investedAmt'];
      user.currentAmt = userData['currentAmt'];
      // Access more user data if available in the document
    } else {
      print('User document does not exist');
    }
  } catch (e) {
    print('Error retrieving user details: $e');
  }
  return user;
}
