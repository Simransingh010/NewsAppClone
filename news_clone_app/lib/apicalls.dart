import 'dart:convert';
import 'package:news_clone_app/models/news_channel_headline.dart';
import 'package:http/http.dart' as http;

final endpointUrl =
    "https://newsapi.org/v2/top-headlines?country=in&apiKey=6504b7d828a445f1a9b293bc1a044b42";

Future<List<Articles>> getArticle() async {
  http.Response res = await http.get(Uri.parse(endpointUrl));

  if (res.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(res.body);

    List<dynamic> body = json['articles'];

    List<Articles> articles =
        body.map((dynamic item) => Articles.fromJson(item)).toList();

    return articles;
  } else {
    throw ('cant get the articles');
  }
}


// import 'package:flutter/material.dart';
// import 'package:news_clone_app/models/article_model.dart';
// import 'package:news_clone_app/widgets/custom_tag.dart';
// import 'package:news_clone_app/widgets/image_container.dart';

// class NewsOfTheDay extends StatelessWidget {
//   const NewsOfTheDay({
//     super.key,
//     required this.article,
//   });

//   final Article article;

//   @override
//   Widget build(BuildContext context) {
//     return ImageContainer(
//       height: MediaQuery.of(context).size.height * 0.45,
//       imageUrl: article.imageUrl,
//       // padding: const EdgeInsets.all(20),
//       width: double.infinity,
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomTag(
//               backgroundColor: Colors.grey.withAlpha(150),
//               children: [
//                 Text(
//                   'News of the Day',
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                         color: Colors.white,
//                       ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(
//               article.title,
//               style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                     fontWeight: FontWeight.bold,
//                     height: 1.25,
//                     color: Colors.white,
//                   ),
//             ),
//             TextButton(
//               onPressed: () {},
//               style: TextButton.styleFrom(padding: EdgeInsets.zero),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'Learn More',
//                     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                           color: Colors.white,
//                         ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   const Icon(
//                     Icons.arrow_forward,
//                     color: Colors.white,
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
