

//===============
//   Jobs Crap
//===============


  // @override
  // void initState() {
  //   super.initState();
  //   _controller = WebViewController.fromInitialUrl(
  //       'https://www.indeed.com/?from=gnav-employer--post-press--jobseeker');
  //   _controller.addListener(() {
  //     if (mounted) {
  //       setState(() {
  //         loadingPercentage = (_controller.loadingProgress ?? 0 * 100) as int;
  //       });
  //     }
  //   });
  // }




  // class JobSearchScreen extends StatefulWidget {
//   const JobSearchScreen({super.key});

//   @override
//   State<JobSearchScreen> createState() => _JobSearchScreenState();
// }

// class _JobSearchScreenState extends State<JobSearchScreen> {
//   //const JobSearchScreen({super.key}); //don't need this!!

//   var loadingPercentage = 0;
//   late final GoRouter _router;
//   late final WebViewController controller;

//   @override
//   void initState() {
//     super.initState();
//     _router = GoRouter();
//     widget.controller.setNavigationDelegate(
//       NavigationDelegate(
//         onPageStarted: (indeedURL) {
//           setState(() {
//             loadingPercentage = 0;
//           });
//         },
//         onProgress: (dynamic progress) {
//           setState(() {
//             loadingPercentage = progress as int;
//           });
//         },
//         onPageFinished: (url) {
//           setState(() {
//             loadingPercentage = 100;
//           });
//         },
//       ),
//     );
//     // ...to here.
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         WebViewWidget(
//           controller: widget.controller, // MODIFY
//         ),
//         if (loadingPercentage < 100)
//           LinearProgressIndicator(
//             value: loadingPercentage / 100.0,
//           ),
//       ],
//     );
//   }
// }






