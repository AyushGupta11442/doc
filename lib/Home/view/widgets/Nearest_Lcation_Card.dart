import 'package:flutter/material.dart';

Widget nearestLocationCard({required assetImagUrl, required titleText}) {
  return Builder(builder: (context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width - 212,
      // height: 170,
      child: FittedBox(
        child: Material(
          color: Colors.white70,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(assetImagUrl),
              ),
              Container(
                margin: const EdgeInsets.all(2),
                width: 100,
                child: Text(
                  titleText,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      fontSize: 10,
                      fontFamily: 'Poppins Bold',
                      fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ),
      ),
    );
  });
}
