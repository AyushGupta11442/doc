import 'package:flutter/material.dart';

class filter extends StatefulWidget {
  final Function(bool male, bool female, double yearOfExperience, double fee)
      addvalue;
  const filter({required this.addvalue});

  @override
  State<filter> createState() => _filterState();
}

class _filterState extends State<filter> {
  bool isChecked1 = false;

  bool isChecked2 = false;

  late double Year_of_experience;
  late double fee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xFF1484ff), size: 40.0),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 28),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.only(right: 30.0, top: 10, bottom: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.notifications_active,
                    size: 26.0,
                  ),
                )),
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(
                  Icons.menu,
                  size: 35, // Changing Drawer Icon Size
                ),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Gender",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "male",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Checkbox(
                  value: isChecked1,
                  onChanged: (value) {
                    setState(() {
                      isChecked1 = value!;
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Female",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Checkbox(
                value: isChecked2,
                onChanged: (value) {
                  setState(() {
                    isChecked2 = value!;
                  });
                },
              ),
            ],
          ),
          const Text(
            "Year of Experience",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Minimum",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: ListWheelScrollView(
                        onSelectedItemChanged: (value) {
                          if (value == 0) {
                            Year_of_experience = 0;
                          } else if (value == 1) {
                            Year_of_experience = 5;
                          } else if (value == 2) {
                            Year_of_experience = 10;
                          } else if (value == 3) {
                            Year_of_experience = 15;
                          }
                        },
                        itemExtent: 40,
                        children: const <Widget>[
                          Text("00"),
                          Text("05"),
                          Text("10"),
                          Text("15"),
                        ]),
                  ),
                ),
              )
            ],
          ),
          const Text(
            "Consultation fee",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Minimum",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: ListWheelScrollView(
                        onSelectedItemChanged: (value) {
                          if (value == 0) {
                            fee = 0;
                          } else if (value == 1) {
                            fee = 100;
                          } else if (value == 2) {
                            fee = 250;
                          } else if (value == 3) {
                            fee = 500;
                          }
                        },
                        itemExtent: 40,
                        children: const <Widget>[
                          Text("00"),
                          Text("100"),
                          Text("250"),
                          Text("500"),
                        ]),
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel")),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      widget.addvalue(isChecked1,isChecked2,Year_of_experience,fee);
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
