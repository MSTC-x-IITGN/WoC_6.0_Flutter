import '../app.dart';
import '../constants/routes.dart';
import '../menu_action.dart';
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
    _pages = [
      {"page": const HomeScreen(), "title": "Stock News"},
      {"page": const MarketsScreen(), "title": "Stock Market"},
      {"page": const WatchlistScreen(), "title": "Watchlist"},
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
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout && context.mounted) {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      loginRoute as Route<Object?>, (route) => false);
                }
            }
          }, itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                  value: MenuAction.logout, child: Text('Log Out')),
            ];
          })
        ],
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
          BottomNavigationBarItem(icon: Icon(CustomIcons.home), label: "News"),
          BottomNavigationBarItem(icon: Icon(CustomIcons.bar), label: "Stocks"),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.eye_outline),
              activeIcon: Icon(CustomIcons.eye),
              label: "Watchlist"),
        ],
      ),
    );
  }
}
