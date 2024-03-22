import 'package:flutter/material.dart';
import 'package:news_clone_app/models/news_channel_headline.dart';
import 'package:news_clone_app/widgets/custom_tag.dart';
import 'package:news_clone_app/widgets/image_container.dart';
import 'package:timeago/timeago.dart' as timeago;
// import 'package:news_clone_app/screens/BottomNavbar1.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static String get routeName => '/Profile';
  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as Articles;
    return ImageContainer(
      width: double.infinity,
      imageUrl: article.urlToImage ?? " no data",
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

  final Articles article;

  String formatPublishedAt(String publishedAt) {
    DateTime dateTime = DateTime.parse(publishedAt);
    return timeago.format(dateTime);
  }

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTag(backgroundColor: Colors.black, children: [
                CircleAvatar(
                  radius: 10,
                  backgroundImage:
                      NetworkImage(article.urlToImage ?? " No Image"),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  article.author ?? "Not Given",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ]),
              const SizedBox(
                width: 15,
              ),
              CustomTag(
                backgroundColor: Colors.grey.withAlpha(60),
                children: [
                  Icon(
                    Icons.schedule,
                    size: 13,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    article.publishedAt != null
                        ? formatPublishedAt(article.publishedAt!)
                        : "Not Available",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
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
            article.title ?? " Not Given",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            maxLines: 200,
            article.description ?? " Not Given",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 2,
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
                            imageUrl: article.urlToImage ?? "NOT AVAILABLE",
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

  final Articles article;
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
          const SizedBox(
            height: 10,
          ),
          Text(
            article.title ?? "NOT GIVEN",
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
            article.author ?? " Not Given",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
          )
        ],
      ),
    );
  }
}
