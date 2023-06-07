import 'package:doctor/auth/otpscreenNumber.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:flutter/material.dart';

class DeleteAccountConferm extends StatefulWidget {
  const DeleteAccountConferm({Key? key}) : super(key: key);

  @override
  State<DeleteAccountConferm> createState() => _DeleteAccountConfermState();
}

class _DeleteAccountConfermState extends State<DeleteAccountConferm> {


  String password = '';
  String conferm_password = '';

  Future<void> Delete() async {
    final response = await DioClinetToken.instance.dio!
        .put('/customer/account_disable', data: {
      'password': password,
      'new_password_conformation': conferm_password
    } );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Row(
            children: const [
              Icon(
                Icons.delete,
                color: Colors.black,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Delete Account',
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
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    //set border radius more than 50% of height and width to make circle
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: Column(children: [
                        Text(
                          'Are You Sure? You Will Permanently Delete Your Account',
                          style: TextStyle(
                              color: Colors.blueGrey.shade900,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                            'When you delete your doctrro account, you wont be able to retrieve any data/information or reactivate your account.'),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                            'You will loose access to every thing from your Doctrro account, including following'),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            child: Column(children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    size: 10,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Appointment')
                                ],
                              ),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    size: 10,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Medical Records')
                                ],
                              ),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    size: 10,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Lab Tests')
                                ],
                              ),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    size: 10,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Orders')
                                ],
                              )
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                         Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Enter password to delete your account permanently',
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade700,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: TextField(
                                        onChanged: (value) {
                                          setState(() {
                                            password = value;
                                          });
                                        },
                                        // obscureText: true,
                                        decoration: const InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: InputBorder.none,
                                            hintText: 'password',
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: TextField(
                                        onChanged: (value) {
                                          setState(() {
                                            conferm_password = value;
                                          });
                                        },
                                        // obscureText: true,
                                        decoration: const InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: InputBorder.none,
                                            hintText: 'confirm password',
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
              padding: const EdgeInsets.all(8),
              onPressed: () {
                setState(() {
                  // Delete();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Otp()));
                });
              },
              color: Colors.red,
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              )),
        ),
      );
}
