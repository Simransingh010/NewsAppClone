import 'package:flutter/material.dart';
import 'package:news_clone_app/models/article_model.dart';
import 'package:news_clone_app/screens/profile_page.dart';
import 'package:news_clone_app/widgets/image_container.dart';
import 'package:news_clone_app/widgets/news_of_the_day.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    Article article = Article.articles[0];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          NewsOfTheDay(article: article),
          BreakingNews(
            articles: Article.articles,
          )
        ],
      ),
    );
  }
}

class BreakingNews extends StatelessWidget {
  const BreakingNews({
    super.key,
    required this.articles,
  });

  final List<Article> articles;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Breaking News',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'More',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ProfilePage.routeName,
                        arguments: articles[index],
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageContainer(
                            imageUrl: articles[index].imageUrl,
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            articles[index].title,
                            maxLines: 2,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      height: 1.5,
                                    ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${DateTime.now().difference(articles[index].createdAt).inHours} hours ago',
                            style: Theme.of(context).textTheme.bodySmall!,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'By ${articles[index].author}',
                            style: Theme.of(context).textTheme.bodySmall!,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
