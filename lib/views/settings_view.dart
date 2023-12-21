import 'package:stocks_app/app.dart';

// import '../app_drawer.dart';
import '../widgets/profile/card_settings.dart';
import '../widgets/profile/list_settings.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/settings";

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      // drawer: AppDrawer(),
      body: Container(
        margin: const EdgeInsets.all(25),
        child: Column(
          children: [
            SettingsCard(),
            const SizedBox(height: 20),
            SettingsList()
          ],
        ),
      ),
    );
  }
}
