import 'dart:convert';
import 'dart:core';
import 'package:doctor/Home/view/modals/notification/get_notification.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:doctor/provider/shared_pref_helper.dart';
import 'package:flutter/material.dart';

class Notification_page extends StatefulWidget {
  const Notification_page({Key? key}) : super(key: key);

  @override
  State<Notification_page> createState() => _Notification_pageState();
}

class _Notification_pageState extends State<Notification_page> {
  bool isloaded = false;
  late get_notification Notification_pages;
  void getNotification_page() async {
    final response =
        await DioClinetToken.instance.dio!.get('/get_notification');
    var data = jsonDecode(response.toString());
    setState(() {
      Notification_pages = get_notification.fromJson(data);
      isloaded = true;
    });
  }

  void markAll() async {
    setState(() {
      isloaded = false;
    });
    final response = await DioClinetToken.instance.dio!.get('/mark_all_read');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.toString());
      getNotification_page();
    }
    setState(() {
      isloaded = true;
    });
  }

  bool one_read = false;

  Future<void> markRead(String id) async {
    final response =
        await DioClinetToken.instance.dio!.get('/mark_as_read/$id');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.toString());
      getNotification_page();
      setState(() {});
    }
  }

  String token = SharedPreferencesHelper.getAuthToken();

  // void markindividual() async {
  //   final response = await DioClinetToken.instance.dio!
  //       .get('/mark_as_read/${SharedPreferencesHelper.getUserId()}');
  //   var data = jsonDecode(response.toString());
  //   setState(() {
  //     Notification_pages = get_notification.fromJson(data);
  //     isloaded = true;
  //   });
  // }

  @override
  void initState() {
    getNotification_page();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF14DFFF),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: Row(
          children: const [
            Icon(Icons.notifications_active),
            Text('  Notifications')
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      if (one_read == true) {
                        markAll();
                      }
                    },
                    child: const Text('Mark all as read'))),
            SizedBox(
                height: MediaQuery.of(context).size.height / 1.2,
                child: SingleChildScrollView(
                  child: isloaded
                      ? Column(
                          children: notification_list(),
                        )
                      : const Center(
                          child: Text("Loading ..."),
                        ),
                )),
          ],
        ),
      ),
    );
  }

  List<Widget> notification_list() {
    List<Widget> lists = [];
    if (isloaded) {
      for (Notification_data n in Notification_pages.data!.notification!) {
        print(n.data?.appointmentId);
        lists.add(My_Appointment(
            n.type!,
            n.data!.customerName!,
            n.data?.appointmentId,
            n.data?.date,
            n.data?.slotTiming,
            n.data?.doctorName,
            n.readAt,
            n.id!));
      }
    }
    return lists;
  }

  Widget My_Appointment(String Heading, String name, String? AppointmentId,
      String? date, String? timing, String? drName, String? readat, String Id) {
    bool isclick = true;
    if (readat == null) {
      setState(() {
        one_read = true;
      });
    }
    Heading = Heading.split('\\')[2];
    String heading = '';
    for (int i = 0; i < Heading.length; i++) {
      if (Heading[i].toUpperCase() == Heading[i]) {
        if (i > 1) //stops from adding a space at if string starts with Capital
        {
          heading = heading + ' ';
          heading += Heading[i];
        } else {
          heading += Heading[i];
        }
      } else {
        heading += Heading[i];
      }
    }
    return InkWell(
      onTap: () {
        if (readat == null) {
          markRead(Id);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 75,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                color: Colors.greenAccent,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          heading,
                          style: const TextStyle(
                            color: (Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                          "Schedule Confermed. Appointment ID: $AppointmentId for $name on $date at $timing with $drName "),
                    ),
                  ],
                ),
              ),
              (readat == null)
                  ? const Icon(
                      Icons.circle,
                      color: Color.fromARGB(255, 240, 125, 105),
                      size: 10,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
