import 'package:doctor/models/location_data.dart';
import 'package:doctor/provider/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/home_controller.dart';
import '../Homepage.dart';

// final DistProvider = StateProvider<District>((ref) {
//   return const District(
//       id: 0,
//       state: "",
//       district: "",
//       stateType: "",
//       createdAt: "",
//       updatedAt: "");
// });

// class LocationSearch extends StatefulWidget {
//   const LocationSearch({Key? key}) : super(key: key);

//   @override
//   State<LocationSearch> createState() => _LocationSearchState();
// }

// class _LocationSearchState extends State<LocationSearch> {
//   @override
//   void initState() {
//     super.initState();
//     LocationController locationController = LocationController();
//     locationController.getuserList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('UserList'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               showSearch(context: context, delegate: SearchUser());
//             },
//             icon: const Icon(Icons.search_sharp),
//           )
//         ],
//       ),
//       body: const Center(
//         child: Text('data'),
//       ),
//     );
//   }
// }
// class LocationSearch extends ConsumerStatefulWidget {
//   const LocationSearch({Key? key}) : super(key: key);

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _LocationSearchState();
// }

// class _LocationSearchState extends ConsumerState<LocationSearch> {
//   TextEditingController searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final locationData = ref.watch(getLocationProvider);
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Column(
//           children: [
//             TextField(
//               onChanged: ((value) {}),
//               style: const TextStyle(
//                 color: Colors.white,
//               ),
//               controller: searchController,
//               decoration: const InputDecoration(
//                 filled: true,
//                 fillColor: Colors.amber,
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(
//                   Icons.search,
//                 ),
//                 hintText: 'eg the dark king',
//               ),
//             ),
//             Expanded(
//               child: locationData.when(
//                 data: ((data) {
//                   return ListView.builder(
//                     itemCount: distMain.length,
//                     itemBuilder: ((context, index) {
//                       return Text(distMain[index].district);
//                     }),
//                   );
//                 }),
//                 error: ((error, stackTrace) => Center(
//                       child: Text(error.toString()),
//                     )),
//                 loading: (() => const Center(
//                       child: CircularProgressIndicator(),
//                     )),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
final locationFetchProvider = StateProvider<String>((ref) {
  return "";
});

class SearchUser extends SearchDelegate {
  // FetchUserList _userList = FetchUserList();
  LocationController locationController = LocationController();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<District>>(
        future: locationController.getLocationList(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<District>? data = snapshot.data;
          return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (() {
                    District val = data![index];
                    SharedPreferencesHelper.setLocation(val.district);

                    data.clear();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  }),
                  child: ListTile(
                    title: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '${data?[index].id}',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data?[index].district}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${data?[index].state}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text(
        "Please search your location",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    // return FutureBuilder<List<District>>(
    //     future: locationController.getLocationList(query: query),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       List<District>? data = snapshot.data;
    //       return ListView.builder(
    //           itemCount: data?.length,
    //           itemBuilder: (context, index) {
    //             return InkWell(
    //               onTap: (() {
    //                 District val = data![index];
    //                 SharedPreferencesHelper.setLocation(val.district);

    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => const HomePage(),
    //                   ),
    //                 );
    //               }),
    //               child: ListTile(
    //                 title: Row(
    //                   children: [
    //                     Container(
    //                       width: 60,
    //                       height: 60,
    //                       decoration: BoxDecoration(
    //                         color: Colors.blueAccent,
    //                         borderRadius: BorderRadius.circular(10),
    //                       ),
    //                       child: Center(
    //                         child: Text(
    //                           '${data?[index].id}',
    //                           style: const TextStyle(
    //                               fontSize: 20,
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.white),
    //                           overflow: TextOverflow.clip,
    //                         ),
    //                       ),
    //                     ),
    //                     const SizedBox(width: 20),
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           '${data?[index].district}',
    //                           style: const TextStyle(
    //                               fontSize: 18, fontWeight: FontWeight.w600),
    //                         ),
    //                         const SizedBox(height: 10),
    //                         Text(
    //                           '${data?[index].state}',
    //                           style: const TextStyle(
    //                             color: Colors.black,
    //                             fontSize: 14,
    //                             fontWeight: FontWeight.w400,
    //                           ),
    //                         ),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             );
    //           });
    //     });
  }
}
// search field

// List<District> distMain = [];
// List<District> dist = [];
// void updateList(String value) {
//   dist = distMain
//       .where((element) =>
//           element.state.toLowerCase().contains(value.toLowerCase()))
//       .toList();
// }



//  child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text('Location ${locationData.state}'),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 50,
//             ),
//             child: DropdownSearch<District>(
//               asyncItems: (String filter) async {
//                 var response = await Dio().get(
//                   "https://api.doctrro.com/api/district_index",
//                   queryParameters: {"filter": filter},
//                 );
//                 var models =
//                     District.fromJsonList(response.data["data"]["districts"]);
//                 return models;
//               },
//               onChanged: (District? data) {
//                 log(data!.district);
//                 ref.read(DistProvider.notifier).state = data;
//               },
//             ),
//           ),
//         ],
//       ),