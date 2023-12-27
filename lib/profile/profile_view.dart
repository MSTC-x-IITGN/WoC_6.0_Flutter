import '../app.dart';
import '../constants/routes.dart';
import 'AboutUs.dart';
import 'CustomerSupport.dart';

import 'Wallet.dart';

class MyProfile extends StatefulWidget {
  String? name;
  MyProfile(this.name, {super.key});
  @override
  State<MyProfile> createState() => _MyProfileView(name!);
}

var arrTitle = ['Portfolio', 'Wallet', 'Customer Support 24x7', 'AboutUs'];
var arrSubtitle = [
  'View your Portolio',
  'Add Money',
  'FAQ, ContactUs',
  'About, Term of Use, Privacy Policy',
];

class ListItem {
  IconData icon;
  ListItem({required this.icon});
}

class _MyProfileView extends State<MyProfile> {
  String? name;
  _MyProfileView(this.name) {
    name = name;
  }

  List<ListItem> items = [
    ListItem(icon: Icons.file_copy_sharp),
    ListItem(icon: Icons.account_balance_wallet_rounded),
    ListItem(icon: Icons.support_agent),
    ListItem(icon: Icons.info_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              child: Container(
                margin: const EdgeInsets.all(5),
                width: 1000,
                height: 160,
                //color: Colors.redAccent,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: const Color.fromRGBO(207, 207, 207, 0.5),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        name!,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // const Text(
                    //   'Edit Account Details >',
                    //   style: TextStyle(fontSize: 15),
                    // ),
                  ],
                ),
              ),
              // onTap: () {
              //   Navigator.push(context, MaterialPageRoute(
              //     builder: (context) {
              //       return MyEditProfile('Edit Profile');
              //     },
              //   ));
              // },
            ),
            Container(
              height: 30,
              color: Colors.white,
            ),
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(5),
                width: 1000,
                height: 400,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(207, 207, 207, 0.5),
                    borderRadius: BorderRadius.circular(11)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 25,
                            child: Icon(items[index].icon,
                                color: Colors.white, size: 40),
                          ), //Text('${index+1}'),
                          title: Text(
                            arrTitle[index],
                            style: const TextStyle(
                                fontFamily: 'FontMain',
                                fontSize: 20,
                                color: Colors.black),
                          ),
                          subtitle: Text(arrSubtitle[
                              index]), //style: TextStyle(fontFamily: 'FontMain', fontSize: 15, color: Colors.deepOrange),),
                          onTap: () {
                            if (arrTitle[index] == 'Portfolio') {
                              Navigator.of(context).pushNamed(portfolioRoute);
                            } else if (arrTitle[index] == 'Wallet') {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return MyWallet('Wallet');
                              }));
                            } else if (arrTitle[index] ==
                                'Customer Support 24x7') {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return MyCustomerSupport('Customer Support');
                              }));
                            } else if (arrTitle[index] == 'AboutUs') {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return MyAboutUs('About Us');
                              }));
                            }
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(height: 30, thickness: 3);
                      },
                      itemCount: arrTitle.length),
                ),
              ),
            ),
            Container(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () async {
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout && context.mounted) {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                fixedSize: const Size(200, 50),
                elevation: 11,
                shadowColor: Colors.grey,
              ),
              child: const Text(
                'LOGOUT',
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
