import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:timeago/timeago.dart' as timeago;
import 'package:news_clone_app/models/news_channel_headline.dart';
import 'package:news_clone_app/screens/profile_page.dart';
import 'package:news_clone_app/widgets/image_container.dart';
import 'package:http/http.dart' as http;
// import 'package:news_clone_app/screens/BottomNavbar1.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});
  static const routeName = '/Search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> apiEndpoints = [
    'https://newsapi.org/v2/top-headlines?country=in&category=general&apiKey=6504b7d828a445f1a9b293bc1a044b42',
    'https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=6504b7d828a445f1a9b293bc1a044b42',
    'https://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey=6504b7d828a445f1a9b293bc1a044b42',
    'https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=6504b7d828a445f1a9b293bc1a044b42',
    'https://newsapi.org/v2/top-headlines?country=in&category=science&apiKey=6504b7d828a445f1a9b293bc1a044b42',
    'https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=6504b7d828a445f1a9b293bc1a044b42',
  ];
  Future<List<Articles>> fetchDataForTabs() async {
    List<Articles> allArticles = [];

    for (int i = 0; i < apiEndpoints.length; i++) {
      String apiUrl = apiEndpoints[i];
      http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['articles'];
        List<Articles> articles =
            body.map((dynamic item) => Articles.fromJson(item)).toList();

        // Add fetched articles to the list of all articles
        allArticles.addAll(articles);
      } else {
        throw Exception('Failed to fetch articles');
      }
    }

    // Return all fetched articles
    return allArticles;
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      'General',
      'Health',
      'Entertainment',
      'Sports',
      'Science',
      'Business'
    ];

    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                Icons.menu,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            const DiscoverNews(),
            CategoryNews(
              tabs: tabs,
              apiEndpoints: apiEndpoints,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryNews extends StatelessWidget {
  const CategoryNews({
    Key? key,
    required this.apiEndpoints,
    required this.tabs,
  }) : super(key: key);

  final List<String> apiEndpoints;
  final List<String> tabs;

  Future<List<Articles>> fetchDataForTab(String apiUrl) async {
    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];
      List<Articles> articles =
          body.map((dynamic item) => Articles.fromJson(item)).toList();
      return articles;
    } else {
      throw Exception('Failed to fetch articles');
    }
  }

  String formatPublishedAt(String publishedAt) {
    DateTime dateTime = DateTime.parse(publishedAt);
    return timeago.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          indicatorColor: Colors.black,
          tabs: tabs
              .map(
                (tab) => Tab(
                  icon: Text(
                    tab,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.56,
          child: TabBarView(
            children: apiEndpoints.map((apiUrl) {
              return FutureBuilder<List<Articles>>(
                future: fetchDataForTab(apiUrl),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final article = snapshot.data![index];
                        return ListTile(
                          leading: ImageContainer(
                            imageUrl: snapshot.data![index].urlToImage ??
                                "Not Available",
                            width: 80,
                            height: 80,
                          ),
                          title: Text(
                            article.title ?? "Not Available",
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(article.publishedAt != null
                              ? formatPublishedAt(article.publishedAt!)
                              : "Not Available"),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ProfilePage.routeName,
                              arguments: article,
                            );
                          },
                        );
                      },
                    );
                  }
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class DiscoverNews extends StatelessWidget {
  const DiscoverNews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Discover',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'News From All Over The World!',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Search',
              fillColor: Colors.grey.shade200,
              filled: true,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              suffixIcon: const RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.tune,
                  color: Colors.grey,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
