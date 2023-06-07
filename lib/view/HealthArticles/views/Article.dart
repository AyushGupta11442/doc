import 'package:doctor/view/HealthArticles/views/ArticleCard.dart';
import 'package:doctor/view/HealthArticles/views/AuthorsAllArticles.dart';
import 'package:flutter/material.dart';

class Article extends StatefulWidget {
  const Article({Key? key}) : super(key: key);

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text('Add To Bookmark'),
            Icon(
              Icons.star_border,
              size: 20.0,
              color: Color.fromARGB(255, 252, 252, 252),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade300,
      ),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                //set border radius more than 50% of height and width to make circle
              ),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/doctorDP.png',
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        
                                        const AuthorsArticles(),
                                  ));
                            },
                            child: const Text('Dr Sudipta Banerjee',
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    // color: Colors.,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          Text('Gynechologyst',
                              style: TextStyle(
                                  color: Colors.blueGrey.shade300,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w100)),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              // shape: const CircleBorder(side: BorderSide(width: 1,color: Colors.black)),
                              color: Colors.blue.shade300,
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: const [
                                    Text(
                                      'Consult Now',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Text('18.12.22',
                      style: TextStyle(
                          color: Colors.blueGrey.shade300,
                          fontSize: 12,
                          fontWeight: FontWeight.w100)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                //set border radius more than 50% of height and width to make circle
              ),
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/Article.png',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Quitting smoking is one of the most important actions people can take to improve their health. This is true regardless of their age or how long they have been smoking. many adverse health effects, including poor reproductive health outcomes, cardiovascular diseases, chronic obstructive pulmonary disease (COPD), and cancer.benefits people already diagnosed with coronary heart disease or COPD.benefits the health of pregnant women and their fetuses and babies.reduces the financial burden that smoking places on people who smoke, healthcare systems, and society.While quitting earlier in life yields greater health benefits, quitting smoking is beneficial to health at any age. Even people who have smoked for many years or have smoked heavily will benefit from quitting.1Quitting smoking is the single best way to protect family members, coworkers, friends, and others from the health risks associated with breathing secondhand smoke.',
                      overflow: TextOverflow.visible,
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Icon(
                      Icons.star_border,
                      size: 20.0,
                      color: Colors.blue.shade300,
                    ),
                    const Text('22')
                  ]),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.share,
                      size: 20.0,
                      color: Colors.blue.shade300,
                    ),
                    const Text('Share Now')
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'More From this author',
                style: TextStyle(
                    color: Colors.blueGrey.shade500,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              
                              const AuthorsArticles(),
                        ));
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(
                        color: Colors.blue.shade500,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          for (int i = 0; i < 3; i++) const ArticleCard(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Recomended based on this article',
              style: TextStyle(
                  color: Colors.blueGrey.shade500, fontWeight: FontWeight.bold),
            ),
          ),
                      for (int i = 0; i < 3; i++) const ArticleCard()


        ]),
      ));
}
