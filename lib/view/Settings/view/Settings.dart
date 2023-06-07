import 'package:doctor/view/Settings/view/ChangePassword.dart';
import 'package:flutter/material.dart';

import 'DeleteAccountConfermation.dart';

class MySettings extends StatelessWidget {
  const MySettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          leading:  InkWell(
            onTap: (){Navigator.pop(context);},
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Row(
            children: const [
              Icon(
                Icons.settings,
                color: Colors.black,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Settings',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Account Settings',
                    style: TextStyle(
                        color: Colors.blueGrey.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const ChangePassword())));
                  },
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.key,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Change Password',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                   onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const DeleteAccountConferm())));
                  },
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Delete Account Permanently',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     'Notification Settings',
                //     style: TextStyle(
                //         color: Colors.blueGrey.shade700,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // Card(
                //   color: Colors.white,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Row(
                //           children: const [
                //             Icon(
                //               Icons.notifications,
                //               color: Colors.black,
                //             ),
                //             SizedBox(
                //               width: 8,
                //             ),
                //             Text(
                //               'Popup Notification',
                //               style: TextStyle(color: Colors.black),
                //             ),
                //           ],
                //         ),
                //         const Icon(
                //           Icons.arrow_forward_ios,
                //           color: Colors.black,
                //           size: 16,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
}
