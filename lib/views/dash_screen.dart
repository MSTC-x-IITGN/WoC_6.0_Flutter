import 'package:stocks_app/model/firebase_user_provider.dart';
import 'package:stocks_app/model/user.dart';
import 'package:stocks_app/profile/profile_view.dart';

import '../app.dart';
import 'watch_list_view.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = "/tabs";

  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    var name = FirebaseAuth.instance.currentUser?.displayName;
    name ??= "User";
    _pages = [
      {"page": const WatchlistScreen(), "title": "Watchlist"},
      {"page": const MarketsScreen(), "title": "Stock Market"},
      {"page": const HomeScreen(), "title": "Stock News"},
      {"page": MyProfile(name), "title": "Profile"},
    ];
    super.initState();
  }

  int _selectedIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex]["title"] as String),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages.map((data) => data['page'] as Widget).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        onTap: _selectPage,
        enableFeedback: false,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(fontFamily: "Poppins"),
        selectedLabelStyle: const TextStyle(fontFamily: "Poppins"),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.eye_outline),
              activeIcon: Icon(CustomIcons.eye),
              label: "Watchlist"),
          BottomNavigationBarItem(icon: Icon(CustomIcons.bar), label: "Stocks"),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "News"),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.home),
            label: "Profile",
          )
        ],
      ),
    );
  }
}
