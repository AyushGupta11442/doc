import 'package:doctor/view/HealthArticles/views/ArticleCard.dart';
import 'package:flutter/material.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({Key? key, this.pageTitle = 'Catgory Name'})
      : super(key: key);
  final String pageTitle;

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
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
          children: [
            Text(widget.pageTitle),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade300,
      ),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(
          children: [
             const SizedBox(
              height: 20.0,
            ),
            for (int i = 0; i < 8; i++)
             const ArticleCard()
          ],
        ),
      ));
}
