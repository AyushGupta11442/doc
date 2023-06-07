import 'package:doctor/view/HealthArticles/views/ArticleCard.dart';
import 'package:flutter/material.dart';

class AuthorsArticles extends StatelessWidget {
  const AuthorsArticles({Key? key}) : super(key: key);

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
              Text('All Articles'),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.blue.shade300,
        ),
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
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
                        const Text('Dr Sudipta Banerjee',
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    // color: Colors.,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                                    Text('Gynechologyst',
                                style: TextStyle(
                                    color: Colors.blueGrey.shade300,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w100)),

                                    const SizedBox(height: 8,),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MaterialButton(
                                                                  // shape: const CircleBorder(side: BorderSide(width: 1,color: Colors.black)),
                                                                  color: Colors.blue.shade300,
                                                                  onPressed: () {
                                                                   
                                                                  },
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
                      ],),
                    ],
                  )
                  ,
                  Text('18.12.22',
                        style: TextStyle(
                            color: Colors.blueGrey.shade300,
                            fontSize: 12,
                            fontWeight: FontWeight.w100)),

                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Authors All Articles',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.blueGrey.shade500, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            for (int i = 0; i < 8; i++) const ArticleCard()
          ]),
        ),
      );
}
