import 'package:doctor/view/HealthArticles/views/ArticleCard.dart';
import 'package:doctor/view/HealthArticles/views/BookmarkedArticles.dart';
import 'package:doctor/view/HealthArticles/views/FilterArticle.dart';
import 'package:flutter/material.dart';

class ArticleHomePage extends StatelessWidget {
  const ArticleHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 20.0,
              color: Color.fromARGB(255, 252, 252, 252),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.radar_rounded,
                size: 20.0,
                color: Color.fromARGB(255, 252, 252, 252),
              ),
              Text('Health Article'),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.blue.shade300,
        ),
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 20,
                  color: Colors.white,
                  //FIXME:when i use textfield the screen becomes blank otherwise it works fine
                  // child: TextButton(
                  //   onPressed: () {  },
                  //   child: TextFormField(
                  //     decoration: const InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       hintText: 'Add Your Experience',
                  //     ),
                  //   ),
                  // )
                ),
                // MaterialButton(
                //   onPressed: () {},
                //   elevation: 1.0,
                //   color: Colors.blue.shade300,
                //   child: const Icon(
                //     Icons.search,
                //     size: 20.0,
                //     color: Color.fromARGB(255, 252, 252, 252),
                //   ),
                // )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  // shape: const CircleBorder(side: BorderSide(width: 1,color: Colors.black)),
                  color: Colors.blue.shade300,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const BookmarkedArticles(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.star,
                          size: 20.0,
                          color: Color.fromARGB(255, 252, 252, 252),
                        ),
                        Text(
                          'Bookmarked Articles',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  // shape: const CircleBorder(side: BorderSide(width: 1,color: Colors.black)),
                  color: Colors.blue.shade300,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              //TODO:add filter article page
                              const FilterArticle(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.filter_alt_sharp,
                          size: 20.0,
                          color: Color.fromARGB(255, 252, 252, 252),
                        ),
                        Text(
                          'Filtered Articles',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Column(
              children: [for (int i = 0; i < 8; i++) const ArticleCard()],
            )
          ],
        )),
      );
}
