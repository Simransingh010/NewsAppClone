import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_clone_app/models/news_channel_headline.dart';

class NewsRepository {
  Future<news_channel_headline> fetchNewsChannelHeadlinesApi() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=6504b7d828a445f1a9b293bc1a044b42';

    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return news_channel_headline.fromJson(body);
    }
    throw Exception('error');
  }
}


//
// class CategoryNews extends StatelessWidget {
//   const CategoryNews({
//     super.key,
//     required this.tabs,
//     required this.apiEndpoints,
//   });
//   final List<String> tabs;
//   fina
//   @override
//   Widget build(BuildContext context) {
//     final articles = Article.articles;
//     return Column(
//       children: [
//         TabBar(
//           isScrollable: true,
//           indicatorColor: Colors.black,
//           tabs: tabs
//               .map(
//                 (tab) => Tab(
//                   icon: Text(
//                     tab,
//                     style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                 ),
//               )
//               .toList(),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.56,
//           child: SizedBox(
//             child: TabBarView(
//               children: tabs                      /// change the child to which you have mapped
//                   .map((tab) => return FutureBuilder(
//                       future: fetchDataForTabs(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         } else if (snapshot.hasError) {
//                           return Center(
//                             child: Text('Error: ${snapshot.error}'),
//                           );
//                         } else {
//                           return ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             itemCount: snapshot.data!.length,
//                             itemBuilder: (context, index) {
//                               return InkWell(
//                                 onTap: () {
//                                   Navigator.pushNamed(
//                                     context,
//                                     ProfilePage.routeName,
//                                     arguments: articles[index],
//                                   );
//                                 },
//                                 child: Row(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 1),
//                                       child: ImageContainer(
//                                         width: 80,
//                                         height: 80,
//                                         imageUrl:
//                                             snapshot.data![index].urlToImage ??
//                                                 "Not Available",
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             snapshot.data![index].title ??
//                                                 " NOT AVAILABLE",
//                                             maxLines: 2,
//                                             overflow: TextOverflow.clip,
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .bodyLarge!
//                                                 .copyWith(
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                           ),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           Row(
//                                             children: [
//                                               const Icon(
//                                                 Icons.schedule,
//                                                 size: 18,
//                                               ),
//                                               const SizedBox(
//                                                 width: 5,
//                                               ),
//                                               Text(
//                                                   '${(snapshot.data![index].publishedAt)}',
//                                                   style: const TextStyle(
//                                                       fontSize: 12)),
//                                               const SizedBox(
//                                                 width: 45,
//                                               ),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           );
//                         }
//                       }))
//                   .toList(),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }