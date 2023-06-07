import 'package:flutter/material.dart';
import 'package:doctor/view/clinicReview/model/clinicReview.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({Key? key, required this.r}) : super(key: key);
  final Reviews r;
  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipOval(
                            child: image(widget.r.customer?.imageFile, 'https://api.doctrro.com/assets/uploads/customer/profile_pictures/${widget.r.customer?.imageFile}')
                          )),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      widget.r.customer!.name.toString(),
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  '${(widget.r.customer?.dateOfBirth == null)?'N/A':2023 - int.parse(widget.r.customer!.dateOfBirth!.substring(0,4))} ${(widget.r.customer?.gender == null) ? 'N/A' : (widget.r.customer!.gender!.substring(0,1))}',
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 48.0,
                    ),
                    Row(
                      children: [
                        // ListView.builder(
                        //   itemCount: r.rating,
                        //   itemBuilder:
                        //       (BuildContext context,
                        //           int index) {
                        //     return ListTile(
                        //         leading:
                        //             const Icon(Icons.list),
                        //         trailing: const Text(
                        //           "GFG",
                        //           style: TextStyle(
                        //               color: Colors.green,
                        //               fontSize: 15),
                        //         ),
                        //         title: Text(
                        //             "List item $index"));
                        //   }),
                        for (int i = 0; i < widget.r.rating!; i++)
                          const Icon(
                            Icons.star,
                            size: 20.0,
                            color: Color(0xFF14b2ff),
                          ),
                      ],
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    'Date : ' + widget.r.updatedAt!.substring(0, 10),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 52),
                child: Text(
                  widget.r.message.toString(),
                  style: const TextStyle(fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
   Widget image(String? image, String imageURL) {
    if (image != null) {
      return Container(
          width: 90,
          height: 100,
          margin: const EdgeInsets.only(left: 8, top: 2),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(
                    imageURL,
                  ),
                  fit: BoxFit.fill)));
    } else {
      return Container(
        width: 90,
        height: 100,
        margin: const EdgeInsets.only(left: 8, top: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          image: const DecorationImage(
              image: AssetImage('assets/images/docto.png'), fit: BoxFit.fill),
        ),
      );
    }
  }
  
}
