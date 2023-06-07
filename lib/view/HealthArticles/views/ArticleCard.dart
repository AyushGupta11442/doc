import 'package:doctor/view/HealthArticles/views/Article.dart';
import 'package:flutter/material.dart';

class ArticleCard extends StatefulWidget {
  const ArticleCard({Key? key}) : super(key: key);

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        //set border radius more than 50% of height and width to make circle
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/images/Smoking.png',
              height: 80,
              width: 80,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Smoking',
                    style: TextStyle(
                        color: Colors.blueGrey.shade300,
                        fontSize: 12,
                        fontWeight: FontWeight.w100),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                            
                                const Article(),
                          ));
                    },
                    child: const Text('The Amazing Benifits of Quitting Smoking !',
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                            // color: Colors.,
                            fontSize: 16,
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text('Dr Sudipta Banerjee',
                      style: TextStyle(
                          color: Colors.blueGrey.shade300,
                          fontSize: 12,
                          fontWeight: FontWeight.w100)),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Icon(
                          Icons.star_border,
                          size: 20.0,
                          color: Colors.blue.shade300,
                        ),
                        Text('22',
                            style: TextStyle(
                                color: Colors.blueGrey.shade300,
                                fontSize: 12,
                                fontWeight: FontWeight.w100)),
                        const SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.share_sharp,
                          size: 20.0,
                          color: Colors.blue.shade300,
                        ),
                      ]),
                      const SizedBox(
                        width: 20,
                      ),
                      Text('17.12.22',
                          style: TextStyle(
                              color: Colors.blueGrey.shade300,
                              fontSize: 12,
                              fontWeight: FontWeight.w100))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}