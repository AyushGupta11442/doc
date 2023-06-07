import 'package:doctor/view/HealthArticles/views/ArticleOfCategory.dart';
import 'package:flutter/material.dart';

class FilterArticle extends StatefulWidget {
  const FilterArticle({Key? key}) : super(key: key);

  @override
  State<FilterArticle> createState() => _FilterArticleState();
}

class _FilterArticleState extends State<FilterArticle> {
  List<String> Categories = [
    'General Issues',
    'Skin and Haircare',
    'Orthopedist',
    'Chronic Condition',
    'Women Health',
    'Ear,Nose,Throat',
    'Sexual Health',
    'Diet Nutrition'
  ];
  List<String> SubCategories = [
    'Fever',
    'Cold',
    'Caugh',
    'Headaches',
    'Vertiga',
    'Loose Motion',
    'Digestion',
    'Heart Problems'
  ];
  bool open = false;
  var openedID = 0;
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
            Text('Explore Your Articles'),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade300,
      ),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (String items in Categories)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          items,
                          style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontWeight: FontWeight.bold),
                        ),
                        open && Categories.indexOf(items) == openedID
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    open = false;
                                  });
                                },
                                child: const Icon(Icons.keyboard_arrow_up))
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    open = true;
                                    openedID = Categories.indexOf(items);
                                  });
                                },
                                child: const Icon(Icons.keyboard_arrow_down)),
                      ],
                    ),
                    if (open && Categories.indexOf(items) == openedID)
                      for (String subItem in SubCategories)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                               
                                                const ArticleList(),
                                          ));
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/Skin problem.png',
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(subItem),
                                      ],
                                    ),
                                  ),
                                  Radio(
                                    value: true,
                                    onChanged: (value) {
                                      setState(() {
                                        var _site = value;
                                      });
                                    },
                                    groupValue: true,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                  ],
                ),
              ),

            // Text(
            //   'General Issues',
            //   style: TextStyle(
            //       color: Colors.blueGrey.shade500, fontWeight: FontWeight.bold),
            // )
          ],
        ),
      ));
}
