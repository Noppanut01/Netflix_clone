import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/screens/movie_details_screen.dart';

class MovieCardWidget extends StatelessWidget {
  final Future future;
  final String headlineText;
  const MovieCardWidget({
    super.key,
    required this.future,
    required this.headlineText,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data?.results;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headlineText,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        log(data[index].id.toString());
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          barrierColor: Colors.black,
                          builder: (context) => MovieDetailsScreen(
                            movieId: data[index].id,
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.network(
                            "$imageUrl${data[index].posterPath}",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return SizedBox.shrink();
          // return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import '../common/utils.dart';
// import '../screens/movie_details_screen.dart';

// class MovieCardWidget extends StatelessWidget {
//   final Future future;

//   final String headlineText;
//   const MovieCardWidget({
//     super.key,
//     required this.future,
//     required this.headlineText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: future,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             var data = snapshot.data?.results;
//             return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     headlineText,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       // padding: const EdgeInsets.all(3),
//                       scrollDirection: Axis.horizontal,
//                       itemCount: data!.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                             padding: const EdgeInsets.all(5.0),
//                             child: InkWell(
//                               onTap: () {
//                                 showModalBottomSheet(
//                                   context: context,
//                                   isScrollControlled: true,
//                                   backgroundColor: Colors.transparent,
//                                   barrierColor: Colors.black,
//                                   builder: (context) => MovieDetailsScreen(
//                                     movieId: data[index].id,
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Image.network(
//                                   '$imageUrl${data[index].posterPath}',
//                                   fit: BoxFit.fitHeight,
//                                 ),
//                               ),
//                             ));
//                       },
//                     ),
//                   )
//                 ]);
//           } else {
//             return const SizedBox.shrink();
//           }
//         });
//   }
// }
