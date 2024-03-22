import 'package:flutter/material.dart';
import 'package:news_clone_app/apicalls.dart';
import 'package:news_clone_app/models/news_channel_headline.dart';
import 'package:news_clone_app/widgets/image_container.dart';

class NewsOfTheDay extends StatefulWidget {
  const NewsOfTheDay({super.key});

  @override
  _NewsOfTheDayState createState() => _NewsOfTheDayState();
}

class _NewsOfTheDayState extends State<NewsOfTheDay> {
  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Articles>>(
      future: getArticle(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the data is loading, show a loading indicator
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // If there's an error fetching the data, display an error message
          return Text('Error: ${snapshot.error}');
        } else {
          // Once the data is loaded, display the articles
          return _buildArticles(snapshot.data!);
        }
      },
    );
  }

  Widget _buildArticles(List<Articles> articles) {
    if (articles.isEmpty) {
      return Center(
        child: Text('No articles available'),
      );
    }

    final article =
        articles[5]; // Assuming the first article is the "News of the Day"

    return ImageContainer(
      height: MediaQuery.of(context).size.height * 0.45,
      imageUrl: article.urlToImage ?? " no data",
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'News of the Day',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              article.title ?? " No data",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.25,
                    color: Colors.white,
                  ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Learn More',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
  // void initState() {
  //   super.initState();
  //   _articleFuture = getArticle(); // Call the function to fetch data
  // }

  // Future<List<Articles>> getArticle() async {
  //   final endpointUrl =
  //       "https://newsapi.org/v2/top-headlines?country=in&apiKey=6504b7d828a445f1a9b293bc1a044b42";
  //   http.Response res = await http.get(Uri.parse(endpointUrl));

  //   if (res.statusCode == 200) {
  //     Map<String, dynamic> json = jsonDecode(res.body);

  //     List<dynamic> body = json['articles'];

  //     List<Articles> articles =
  //         body.map((dynamic item) => Articles.fromJson(item)).toList();

  //     return articles;
  //   } else {
  //     throw ('cant get the articles');
  //   }
  // }