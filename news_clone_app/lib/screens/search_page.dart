import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_clone_app/models/article_model.dart';
import 'package:news_clone_app/widgets/image_container.dart';
// import 'package:news_clone_app/screens/BottomNavbar1.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static const routeName = '/Search';
  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      'Health',
      'Politics',
      'Art',
      'Food',
      'Science',
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
            _CategoryNews(tabs: tabs),
          ],
        ),
      ),
    );
  }
}

class _CategoryNews extends StatelessWidget {
  const _CategoryNews({
    super.key,
    required this.tabs,
  });
  final List<String> tabs;
  @override
  Widget build(BuildContext context) {
    final articles = Article.articles;
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
          height: MediaQuery.of(context).size.height * 0.5,
          child: SizedBox(
            child: TabBarView(
              children: tabs
                  .map(
                    (tab) => ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ImageContainer(
                                width: 80,
                                height: 80,
                                imageUrl: articles[index].imageUrl,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    articles[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.schedule,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          '${DateTime.now().difference(articles[index].createdAt).inHours} Hours Ago',
                                          style: const TextStyle(fontSize: 12)),
                                      const SizedBox(
                                        width: 45,
                                      ),
                                      const Icon(
                                        Icons.visibility,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text('${articles[index].views} views',
                                          style: const TextStyle(fontSize: 12))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        )
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
