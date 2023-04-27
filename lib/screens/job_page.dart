// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../app_styles/nav_bar_v2.dart';
import '../firebase/guest_state_firebase.dart';
import 'package:csv/csv.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
// import '../app_styles/nav_bar_v2_ooooooold.dart';

class JobsList extends StatefulWidget {
  const JobsList({super.key});

  @override
  _JobsListState createState() => _JobsListState();
}

class _JobsListState extends State<JobsList> {
  List<List<dynamic>> _data = [];

  Future<void> loadCsv() async {
    final csvData = await rootBundle.loadString('assets/jobs.csv');
    final decodedData = const CsvToListConverter().convert(csvData);
    setState(() {
      _data = decodedData;
    });
  }

  @override
  void initState() {
    super.initState();
    loadCsv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job List'),
      ),
      body: _data.isNotEmpty
          ? ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                final job = _data[index];
                return ListTile(
                  title: Text(job[0] as String),
                  subtitle: Text(job[1] as String),
                  trailing: Text(job[2] as String),
                  onTap: () {
                    // do something when tapped
                  },
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      backgroundColor: Colors.grey[900],
      bottomNavigationBar: const MyNavigationBar(),
      extendBody: true,
    );
  }
}

//=============================
//Search Bar - currently unused
//=============================

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return _rowSearchIconWidget();
  }

  Widget _rowSearchIconWidget() {
    return Row(
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: Image.asset('assets/icons/logo_1.png'),
        ),
        const SizedBox(
          width: 8,
        ),
        Container(
          height: 35,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: const BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Search jobs',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ],
    );
  }
}























// class JobSearchPage extends StatefulWidget {
//   const JobSearchPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _JobSearchPageState createState() => _JobSearchPageState();
// }

// //bottomNavigationBar: const MyNavigationBar(),

// class _JobSearchPageState extends State<JobSearchPage> {
//   var loadingPercentage = 0;
//   late WebViewController _controller; //not used anywhere

//   // final MyNavigationBarState _navigationBarKey =
//   //     MyNavigationBarState(); //MyNavigationBarState
//   // final int jobIndex = 2;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _navigationBarKey.setSelectedIndex(jobIndex);
//   //   print('job_page: _navigationBarKey.setSelectedIndex($jobIndex);');
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Job Page!!'),
//       ),
//       body: Stack(
//         children: [
//           WebView(
//             initialUrl:
//                 'https://www.indeed.com/?from=gnav-employer--post-press--jobseeker',
//             javascriptMode: JavascriptMode.unrestricted,
//             navigationDelegate: (request) {
//               if (request.url.startsWith('https://www.indeed.com')) {
//                 // Allow the request
//                 return NavigationDecision.navigate;
//               }
//               // Don't allow the request
//               return NavigationDecision.prevent;
//             },
//             onWebViewCreated: (webViewController) {
//               _controller = webViewController;
//             },
//             onPageStarted: (indeedURL) {
//               setState(() {
//                 loadingPercentage = 0;
//               });
//             },
//             onProgress: (progress) {
//               setState(() {
//                 loadingPercentage = progress * 100;
//               });
//             },
//             onPageFinished: (url) {
//               setState(() {
//                 loadingPercentage = 100;
//               });
//             },
//           ),
//           if (loadingPercentage < 100)
//             LinearProgressIndicator(
//               value: loadingPercentage / 100.0,
//             ),
//         ],
//       ),
//       bottomNavigationBar: const MyNavigationBar(key: Key('navKey')),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         WebView(
//           initialUrl:
//               'https://www.indeed.com/?from=gnav-employer--post-press--jobseeker',
//           javascriptMode: JavascriptMode.unrestricted,
//           navigationDelegate: (request) {
//             if (request.url.startsWith('https://www.indeed.com')) {
//               // Allow request :)
//               return NavigationDecision.navigate;
//             }
//             // Don't allow request :(
//             return NavigationDecision.prevent;
//           },
//           onWebViewCreated: (webViewController) {
//             _controller = webViewController;
//           },
//           onPageStarted: (indeedURL) {
//             setState(() {
//               loadingPercentage = 0;
//             });
//           },
//           onProgress: (progress) {
//             setState(() {
//               loadingPercentage = progress * 100;
//             });
//           },
//           onPageFinished: (url) {
//             setState(() {
//               loadingPercentage = 100;
//             });
//           },
//         ),
//         if (loadingPercentage < 100)
//           LinearProgressIndicator(
//             value: loadingPercentage / 100.0,
//           ),
//       ],
//     );
//   }
// }

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//


