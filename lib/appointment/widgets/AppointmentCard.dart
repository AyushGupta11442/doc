import 'package:doctor/appointment/models/AppointmentClass.dart';
import 'package:doctor/appointmentBooking/details_appointment.dart';
import 'package:flutter/material.dart';

class ApmntCard extends StatefulWidget {
  const ApmntCard({Key? key, required this.appointment}) : super(key: key);
  final Appointment appointment;
  @override
  State<ApmntCard> createState() => _ApmntCardState();
}

class _ApmntCardState extends State<ApmntCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.appointment.doctor_image_file);
    return Container(
      child: SizedBox(
        height: 150.0,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Appointment_Confirmation(
                  appointment: widget.appointment,
                  string1: widget.appointment.clinic_name.toString(),
                  string2: widget.appointment.date.toString(),
                  string3: widget.appointment.slotTiming.toString(),
                  image: widget.appointment.doctor_image_file,
                ),
              ),
            );
          },
          child: Card(
            elevation: 4.0,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black.withOpacity(0.4),
                width: 1,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            //or 15.0
                            child: Container(
                              height: 90.0,
                              width: 90.0,
                              color: const Color(0x00b2e2fc),
                              child: image(widget.appointment.doctor_image_file,
                                  'https://api.doctrro.com/assets/uploads/doctor/profile_pictures/${widget.appointment.doctor_image_file}'),
                              // child: Image.network(
                              //   'https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-profiles/avatar-2.webp',
                              //   fit: BoxFit.fill,
                              // ),
                            ),
                          ),
                          const SizedBox(
                            width: 18.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 200,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        widget.appointment.doctor_name.toString(),
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.visible,
                                                                  
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    RoundIcon(
                                      status: widget.appointment.status!,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              SizedBox(
                                width: 180,
                                child: Text(
                                  widget.appointment.clinic_name.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  //textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.appointment.date.toString(),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    widget.appointment.slotTiming.toString(),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                 
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RoundIcon extends StatelessWidget {
  const RoundIcon({
    Key? key,
    required this.status,
  }) : super(key: key);
  final int status;
  @override
  Widget build(BuildContext context) {
    //!@FIX : no SHOW needs to added!!!
    switch (status) {
      case 0:
        {
          return Card(
            elevation: 1.0,
            color: Colors.orange,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.orange.withOpacity(0.4), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              child: Text("Booked", style: TextStyle(color: Colors.white),),
            ),
          );
        }
        break;

      case 1:
        {
          return Card(
            elevation: 1.0,
            color: Colors.orange,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.orange.withOpacity(0.4), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),

              child: Text(
                "Resheduled",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
        break;
      case 2:
        {}
        break;
      case 3:
        {}
        break;
      case 4:
        {
          return Card(
            elevation: 1.0,
            color: Colors.green,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.green.withOpacity(0.4), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
                           padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),

              child: Text(
                "Completed",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      case -1:
        {
          return Card(
            elevation: 1.0,
            color: Colors.red,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.red.withOpacity(0.4), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
                           padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),

              child: Text(
                "Expired",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      case -2:
        {
           return Card(
            elevation: 1.0,
            color: Colors.red,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.red.withOpacity(0.4), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
                         padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),

              child: Text(
                "Cancelled",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
        break;
      case -3:
        {
          return Card(
            elevation: 1.0,
            color: Colors.red,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.red.withOpacity(0.4), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),

              child: Text(
                "Cancelled",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
        break;
    }
    return const SizedBox();
  }
}

// !image

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
