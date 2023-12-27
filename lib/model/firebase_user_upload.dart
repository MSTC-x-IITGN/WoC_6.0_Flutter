import '../app.dart';

Future<void> addUserDetailsToFirestore(
  String userId,
  String email,
  String name,
  String phone,
) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'id': userId,
      'email': email,
      'name': name,
      'balance': '0',
      'investedAmt': '0',
      'currentAmt': '0',
      'phone': phone,
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      // Add more user details if needed
    });
    print('User details added to Firestore!');
  } catch (e) {
    print('Error adding user details: $e');
  }
}

Future<void> changePassword(String newPassword) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.updatePassword(newPassword);
      print('Password changed successfully');
    } else {
      print('No user signed in');
    }
  } catch (e) {
    print('Error changing password: $e');
  }
}

Future<void> updateUserDetailsToFirestore(
  String userId,
  String email,
  String name,
  String phone,
  String imageUrl,
) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'email': email,
      'name': name,
      'phone': phone,
    });
    print('User details updated to Firestore!');
  } catch (e) {
    print('Error updating user details: $e');
  }
}

Future<void> addBalanceToFirestore(
  String userId,
  String balance,
) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'balance': balance,
    });
    print('User balance updated to Firestore!');
  } catch (e) {
    print('Error updating user balance: $e');
  }
}

Future<void> addInvestedAmtToFirestore(
  String userId,
  String investedAmt,
) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'investedAmt': investedAmt,
    });
    print('User investedAmt updated to Firestore!');
  } catch (e) {
    print('Error updating user investedAmt: $e');
  }
}

Future<void> addCurrentAmtToFirestore(
  String userId,
  String currentAmt,
) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'currentAmt': currentAmt,
    });
    print('User currentAmt updated to Firestore!');
  } catch (e) {
    print('Error updating user currentAmt: $e');
  }
}
