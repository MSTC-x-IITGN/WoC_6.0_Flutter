import '../app.dart';
import '../banner_image.dart';
import '../widgets/stocks/stock_list_tile.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  late Future<void> _securitiesFuture;

  @override
  void initState() {
    _securitiesFuture =
        Provider.of<Securities>(context, listen: false).fetchSavedSecurities();
    super.initState();
  }

  Widget showDismissBanner(bool slideToLeft) {
    return Container(
      alignment: slideToLeft ? Alignment.centerLeft : Alignment.centerRight,
      color: Colors.red,
      child: Padding(
        padding: slideToLeft
            ? const EdgeInsets.only(left: 15)
            : const EdgeInsets.only(right: 15),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Security> items = Provider.of<Securities>(context).savedItems;

    if (items.isEmpty) {
      return const ImageBanner(
        imgSrc: "assets/images/gone.png",
        text: "Add Stocks in WatchList!",
      );
    }

    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          FutureBuilder(
            future: _securitiesFuture,
            builder: (ctx, snapshot) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (ctx, i) {
                  var dismissible = Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) async {
                      await Provider.of<Securities>(context, listen: false)
                          .removeSavedSecurity(items[i].ticker);
                      setState(() {
                        items.removeAt(i);
                      });
                    },
                    background: showDismissBanner(true),
                    secondaryBackground: showDismissBanner(false),
                    child: SecurityListTile(
                      name: items[i].name,
                      ticker: items[i].ticker,
                      price: items[i].price,
                      dayChangePercent: items[i].dayChangePercent,
                      icon: false,
                    ),
                  );
                  return dismissible;
                },
                separatorBuilder: (_, i) =>
                    const Divider(color: Color(0xFFa0b0ba)),
                itemCount: items.length,
              );
            },
          )
        ],
      ),
    );
  }
}
