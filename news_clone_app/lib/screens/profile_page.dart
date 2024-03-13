import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_clone_app/models/article_model.dart';
import 'package:news_clone_app/widgets/custom_tag.dart';
import 'package:news_clone_app/widgets/image_container.dart';
// import 'package:news_clone_app/screens/BottomNavbar1.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static String get routeName => '/Profile';
  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as Article;
    return ImageContainer(
      width: double.infinity,
      imageUrl: article.imageUrl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView(
          children: [
            _NewsHeadline(
              article: article,
            ),
            const SizedBox(
              height: 20,
            ),
            NewsInfo(article: article)
          ],
        ),
      ),
    );
  }
}

class NewsInfo extends StatelessWidget {
  const NewsInfo({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: const Border.symmetric(),
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomTag(backgroundColor: Colors.black, children: [
                CircleAvatar(
                  radius: 10,
                  backgroundImage: NetworkImage(article.authorImageUrl),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  article.author,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ]),
              const SizedBox(
                width: 20,
              ),
              CustomTag(
                backgroundColor: Colors.grey.withAlpha(60),
                children: [
                  Icon(
                    Icons.schedule,
                    size: 10,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${DateTime.now().difference(article.createdAt).inHours}h',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              CustomTag(
                backgroundColor: Colors.grey.withAlpha(60),
                children: [
                  Icon(
                    Icons.visibility,
                    size: 10,
                  ),
                  Text(
                    '${article.views}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            article.title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            article.body,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          // GridView.builder(
          //   shrinkWrap: true,
          //   itemCount: 2,
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     childAspectRatio: 1.25,
          //   ),
          //   itemBuilder: (context, index) {
          //     return Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: ImageContainer(
          //           imageUrl: article.imageUrl,
          //           width: MediaQuery.of(context).size.width * 0.4),
          //     );
          //   },
          // ),
          SizedBox(
            height: 150,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ProfilePage.routeName,
                        arguments: article,
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageContainer(
                            imageUrl: article.imageUrl,
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          const SizedBox(
                            height: 10,
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

class _NewsHeadline extends StatelessWidget {
  const _NewsHeadline({
    required this.article,
    super.key,
  });

  final Article article;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          CustomTag(
            backgroundColor: Colors.grey.withAlpha(150),
            children: [
              Text(
                article.category,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            article.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            article.subtitle,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
          )
        ],
      ),
    );
  }
}
