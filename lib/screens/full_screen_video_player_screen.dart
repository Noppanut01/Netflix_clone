// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class FullScreenVideoPlayer extends StatefulWidget {
//   final String videoId;
//   const FullScreenVideoPlayer({super.key, required this.videoId});

//   @override
//   State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
// }

// class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
//   late YoutubePlayerController _youtubeController;

//   @override
//   void initState() {
//     super.initState();
//     _youtubeController = YoutubePlayerController(
//       initialVideoId: widget.videoId,
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//         isLive: false,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             YoutubePlayer(
//               controller: _youtubeController,
//               showVideoProgressIndicator: true,
//               onReady: () {},
//             ),
//             Positioned(
//               top: 20,
//               left: 10,
//               child: IconButton(
//                 icon: Icon(Icons.close, color: Colors.white, size: 30),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _youtubeController.dispose();
//     super.dispose();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:flutter/services.dart';

// class FullScreenVideoPlayer extends StatefulWidget {
//   final String videoId;
//   const FullScreenVideoPlayer({super.key, required this.videoId});

//   @override
//   // ignore: library_private_types_in_public_api
//   _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
// }

// class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     // Lock the screen orientation to landscape when the page is loaded
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);

//     _controller = YoutubePlayerController(
//       initialVideoId: widget.videoId,
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//         isLive: false,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text('Full-Screen Video'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             // Reset the orientation to portrait before navigating back
//             SystemChrome.setPreferredOrientations([
//               DeviceOrientation.portraitUp,
//               DeviceOrientation.portraitDown,
//             ]);
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Center(
//         child: YoutubePlayer(
//           controller: _controller,
//           showVideoProgressIndicator: true,
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Reset to portrait when exiting full-screen
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     _controller.dispose();
//     super.dispose();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:flutter/services.dart';

// class FullScreenVideoPlayer extends StatefulWidget {
//   final String videoId;
//   const FullScreenVideoPlayer({super.key, required this.videoId});

//   @override
//   // ignore: library_private_types_in_public_api
//   _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
// }

// class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     // Lock the screen orientation to landscape when the page is loaded
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);

//     _controller = YoutubePlayerController(
//       initialVideoId: widget.videoId,
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//         isLive: false,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Hide controls when tapped outside (optional feature)
//         setState(() {});
//       },
//       child: Stack(
//         children: [
//           // YoutubePlayer filling the whole screen without padding
//           Positioned.fill(
//             child: YoutubePlayer(
//               controller: _controller,
//               showVideoProgressIndicator: true,
//               progressIndicatorColor: Colors.red,
//               onReady: () {},
//             ),
//           ),
//           // Back button to exit full-screen
//           Positioned(
//             top: 40,
//             left: 20,
//             child: IconButton(
//               icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
//               onPressed: () {
//                 // Reset orientation to portrait before navigating back
//                 SystemChrome.setPreferredOrientations([
//                   DeviceOrientation.portraitUp,
//                   DeviceOrientation.portraitDown,
//                 ]);
//                 Navigator.pop(context); // Pop the full screen video player
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Reset orientation to portrait when exiting full-screen
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     _controller.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final String videoId;
  const FullScreenVideoPlayer({super.key, required this.videoId});

  @override
  // ignore: library_private_types_in_public_api
  _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Lock the screen orientation to landscape when the page is loaded
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        isLive: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Optional: hide controls when tapped outside
        setState(() {});
      },
      child: Stack(
        children: [
          // Adding padding around the YoutubePlayer
          Padding(
            padding: const EdgeInsets.all(16.0), // Add padding here
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
              onReady: () {},
            ),
          ),
          // Back button with extra padding
          Positioned(
            top: 40,
            left: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Padding around the button
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  // Reset orientation to portrait before navigating back
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ]);
                  Navigator.pop(context); // Pop the full screen video player
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Reset orientation to portrait when exiting full-screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controller.dispose();
    super.dispose();
  }
}
