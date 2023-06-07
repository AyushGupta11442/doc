import 'package:doctor/Home/view/modals/clinicspecialityclass.dart';
import 'package:doctor/Home/view/searchbydoctornamescreen.dart';
import 'package:doctor/Home/view/searchbyspecialistscreen.dart';
import 'package:doctor/client/DioClientToken/DioClient_Token.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late String entered_name;
  double bottomcontainerheight = 0;
  bool showBottomScreen = false;
  final List<clinicspeciality> allspecialist = [];
  List<clinicspeciality> foundspeacialist = [];
  void getspecialitylist() async {
    try {
      final response =
          await DioClinetToken.instance.dio!.get('/specialities/all');

      var speciality = response.data['data']['specialities'];

      if (response.statusCode == 200) {
        for (var d in speciality) {
          clinicspeciality dc = clinicspeciality(
            id: d['id'],
            name: d['name'],
            status: d['status'],
            created_at: d['created_at'],
            updated_at: d['updated_at'],
          );
          allspecialist.add(dc);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<clinicspeciality> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allspecialist;
    } else {
      results = allspecialist
          .where((user) =>
              user.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      foundspeacialist = results;
    });
  }

  int selectedPage = 0;

  double Nearestlocationnumber = 120;
  String Nearestlocationtext = "See all";
  @override
  double pageheight = 500;

  ScrollPhysics physic = const NeverScrollableScrollPhysics();

  @override
  void initState() {
    getspecialitylist();
    foundspeacialist = allspecialist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFF1484ff), size: 30.0),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 25),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: const <Widget>[
            Text(
              'Find your health concern',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey),
            ),
            SizedBox(
              width: 8.0,
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ! location
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: GestureDetector(
              //     onTap: () {
              //       showSearch(context: context, delegate: SearchUser());
              //     },
              //     child: Row(
              //       children: [
              //         const Icon(
              //           Icons.location_on,
              //           color: Color(0xff14FFB8),
              //           size: 25,
              //         ),
              //         5.widthBox,
              //         SharedPreferencesHelper.getLocation()
              //             .text
              //             .size(18)
              //             .make(),
              //         5.widthBox,
              //         const Icon(CupertinoIcons.chevron_down,
              //             color: Color(0xFF1484ff), size: 15),
              //       ],
              //     ),
              //   ),
              // ),

              Row(
                children: <Widget>[
                  // const SizedBox(
                  //   width: 12.0,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 8.0, left: 15, top: 8.0, bottom: 8.0),
                    child: SizedBox(
                      // height: 39.0,
                      // width: 313.0,
                      height: MediaQuery.of(context).size.height / 21.5,
                      width: MediaQuery.of(context).size.width / 1.41,
                      child: TextField(
                        onChanged: (value) {
                          _runFilter(value);
                          setState(() {
                            bottomcontainerheight = 220;
                            entered_name = value;
                            showBottomScreen = true;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[250],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                          hintText: 'Search...',
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Searchbyspecialistname(
                                      name: entered_name,
                                    )));
                        bottomcontainerheight = 0;
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                          color: const Color(0xFF14B2FF),
                          child: const Icon(Icons.search,
                              size: 30.0, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          (showBottomScreen)
              ? SizedBox(
                  height: bottomcontainerheight,
                  child: foundspeacialist.isNotEmpty
                      ? ListView.builder(
                          itemCount: foundspeacialist.length,
                          itemBuilder: (context, index) => Card(
                            elevation: 1,
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Searchbyspecialist(
                                                id: foundspeacialist[index].id!,
                                              )));
                                });
                              },
                              child: ListTile(
                                title: Text(
                                    foundspeacialist[index].name.toString()),
                              ),
                            ),
                          ),
                        )
                      : const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'No results found Please try with diffrent search',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                )
              : const SizedBox(),
          SizedBox(
            height: (MediaQuery.of(context).size.height / 1.259) -
                bottomcontainerheight,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Book an Appointment by Speciality',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: pageheight,
                        child: GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio:
                              ((MediaQuery.of(context).size.width / 3.6) /
                                  (MediaQuery.of(context).size.height / 7)),
                          shrinkWrap: true,
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const Searchbyspecialist(
                                          id: 140,
                                        )),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Image.asset(
                                            'assets/doctor-specialities-Icons/Skin,Hair,Nails(Dermatologist).png'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Text(
                                    'Skin Problem',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 135,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Image.asset(
                                            'assets/doctor-specialities-Icons/Dental Care ( Dentist ).png'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Text(
                                    "Dentist",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 197,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Image.asset(
                                            'assets/doctor-specialities-Icons/Digestive Issues ( Gastroenterologist ).png'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Text(
                                    "Digestive Issues",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 1000,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Image.asset(
                                            'assets/doctor-specialities-Icons/Covid Care.png'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Covid",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 1000,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Image.asset(
                                            'assets/doctor-specialities-Icons/Dietition _ Nutritionist.png'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Text(
                                    "Dietition",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 1000,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Image.asset(
                                            'assets/doctor-specialities-Icons/General Surgery.png'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Text(
                                    "General Surgery",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 1000,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Image.asset(
                                            'assets/doctor-specialities-Icons/Gynecologists - Obstetrician.png'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Text(
                                    "Gynecologists",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 1000,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Image.asset(
                                            'assets/doctor-specialities-Icons/Physiotherapist.png'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Physiotherapist",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 1000,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Image.asset(
                                            'assets/doctor-specialities-Icons/Veterinary.png'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Veterinary",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 539,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/Sexual Health ( Sexologist ).png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Text(
                                    "Women's Health",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 68,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/Heart ( Cardiologist ).png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Text(
                                    "Heart Peoblem",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 116,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/Eye Specialist ( Ophthalmologist ).png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Text(
                                    "Eye Specialist",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 116,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/Cancer Care ( Oncologist ).png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Cancer",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 203,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/General Physician.png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "General Physician",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 624,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/Urinary Issues ( Urologist ).png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Urinary Issue",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 140,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/Skin,Hair,Nails(Dermatologist).png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Hair Issue",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 323,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/Kidney ( Nephrologist ).png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Kidney Issue",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 460,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/Child Specialist ( Pediatrician ).png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Child Specialist",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 338,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/Brain _ Nerves ( Neurologist ).png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Brain & nerves",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 508,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/Lungs _ breath ( Pulmonologist ).png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Lungs & breath",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 396,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/Bones _ Joints ( Orthopedist ).png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Bones & Joint",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 164,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/Diabetes ( Endocrinologist ).png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Endocrinologist",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 539,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/Sexual Health ( Sexologist ).png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Sex Specialist",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/Path - pill.png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Medical Sp.",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/Homeopathy.png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Homeopathy",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 30,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      color: const Color(0xFF14DFFF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.asset(
                                              'assets/doctor-specialities-Icons/Ayurveda.png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Ayurveda",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                        child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red),
                          child: const Center(
                              child: Text(
                            "Looking for more? Search",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                        onTap: (() {})),
                    const SizedBox(
                      height: 30,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Book an Appointment by Health Concern',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // const Align(
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     '   ',
                    //     style: TextStyle(
                    //         fontSize: 22, fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '   General Physician',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 400,
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        childAspectRatio:
                            ((MediaQuery.of(context).size.width / 3.6) /
                                (MediaQuery.of(context).size.height / 7.2)),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        children: <Widget>[
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 203,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              'assets/categoryimage/fever.jpg',
                                            ),
                                            fit: BoxFit.fill)),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Fever",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 203,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              'assets/categoryimage/pneumonia.jpg',
                                            ),
                                            fit: BoxFit.fill)),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "pneumonia",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 203,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height /
                                        10.5,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              'assets/categoryimage/High blood pressure.jpg',
                                            ),
                                            fit: BoxFit.fill)),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Column(
                                        children: const [
                                          Text(
                                            "High Blood",
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Pressure",
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 203,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              'assets/categoryimage/cough and cold.jpg',
                                            ),
                                            fit: BoxFit.fill)),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Cough & cold",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 203,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              'assets/categoryimage/kid sick.jpg',
                                            ),
                                            fit: BoxFit.fill)),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Is your Kid sick?",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 203,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              'assets/categoryimage/headaches.jpg',
                                            ),
                                            fit: BoxFit.fill)),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Headaches",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 203,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              'assets/categoryimage/Stomach Pain.jpg',
                                            ),
                                            fit: BoxFit.fill)),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Stomach Pain",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 203,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              'assets/categoryimage/Vertigo.jpg',
                                            ),
                                            fit: BoxFit.fill)),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Vertigo",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 203,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/Loose Motion.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Loose Motion",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '   Dermatologist',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 260,
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio:
                            ((MediaQuery.of(context).size.width / 3.6) /
                                (MediaQuery.of(context).size.height / 7)),
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 9,
                            width: MediaQuery.of(context).size.width / 3.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF14B2FF),
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const Searchbyspecialist(
                                        id: 140,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/vitiligo.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Center(
                                    child: Text(
                                  "vitiligo",
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 140,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/Acne Scars.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Acne Scars",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 140,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/Dandruff.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Dandruff",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 140,
                                ),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/Hare fall.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Hair",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 140,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/Skin Problems.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Skin Problem",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 140,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/fungal infection.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Fungal infection",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '   Orthopedist',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                        height: 300,
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio:
                              ((MediaQuery.of(context).size.width / 3.6) /
                                  (MediaQuery.of(context).size.height / 7)),
                          primary: false,
                          padding: const EdgeInsets.all(20),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 3,
                          children: <Widget>[
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 396,
                                  ),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF14B2FF),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                            'assets/categoryimage/Shoulder Pain.jpg',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Center(
                                        child: Text(
                                      "Sholder Pain",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 396,
                                  ),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF14B2FF),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                            'assets/categoryimage/Leg Pain.jpg',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Center(
                                        child: Text(
                                      "Leg Pain",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 396,
                                  ),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF14B2FF),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                            'assets/categoryimage/Carpal Tunnel Syndrome.jpg',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Center(
                                        child: Text(
                                      "CTS",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 396,
                                  ),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF14B2FF),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                            'assets/categoryimage/knee pain.jpg',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Center(
                                        child: Text(
                                      "Knee Pain",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Searchbyspecialist(
                                    id: 396,
                                  ),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF14B2FF),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                            'assets/categoryimage/back pain.jpg',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Center(
                                        child: Text(
                                      "Back Pain",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '   Gnecologist',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        primary: false,
                        childAspectRatio:
                            ((MediaQuery.of(context).size.width / 3.6) /
                                (MediaQuery.of(context).size.height / 6.5)),
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        children: <Widget>[
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 224,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/Irregular Periods.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Irregular Periods",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 224,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/MENOPAUSE.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Menopause",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 224,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/Vaginal Discharge.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Column(
                                        children: const [
                                          Text(
                                            "Vaginal",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Discharge",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 224,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/pcos.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "PCOS",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 224,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/ovarian cysts.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Ovarian Cysts",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 224,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/Vaginal infection.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Ovarian Cysts",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '   Ear, Nose,Throat Specialist',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 260,
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        childAspectRatio:
                            ((MediaQuery.of(context).size.width / 3.6) /
                                (MediaQuery.of(context).size.height / 7)),
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        children: <Widget>[
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 1000,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/Mouth Sores.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Mouth Sores",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 1000,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/Coughing.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Coughing",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 1000,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/Snoring.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Snoring",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 1000,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/Sore Throat.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Sore Throat",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '   Sexologist',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 135,
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio:
                            ((MediaQuery.of(context).size.width / 3.6) /
                                (MediaQuery.of(context).size.height / 7)),
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        children: <Widget>[
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 539,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/Sex Problems.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Sex Problem?",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '   Phychiatrist',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 135,
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio:
                            ((MediaQuery.of(context).size.width / 3.6) /
                                (MediaQuery.of(context).size.height / 7)),
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        children: <Widget>[
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 6,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/depression.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "Depression ?",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '   Nutritionist',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 135,
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio:
                            ((MediaQuery.of(context).size.width / 3.6) /
                                (MediaQuery.of(context).size.height / 7)),
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        children: <Widget>[
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Searchbyspecialist(
                                  id: 1000,
                                ),
                              ),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF14B2FF),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/categoryimage/Want to weight loss or gain.jpg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    "loss/gain weight? ",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
