import '../../app.dart';
import 'primary_news.dart';
import 'secondary_news.dart';

class ArticleList extends StatelessWidget {
  final List<Article> articleData;

  const ArticleList(this.articleData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Top Headlines",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          separatorBuilder: (_, i) => const Divider(color: Color(0xFFa0b0ba)),
          itemBuilder: (ctx, index) {
            if (1 <= index && index <= 4) {
              return SecondaryArticle(
                articleData[index],
              );
            }
            return PrimaryArticle(articleData[index]);
          },
          itemCount: articleData.length,
        ),
      ],
    );
  }
}
