import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'ubermorgen.dart' show L, S, StateModel;

class StationOne extends StatefulWidget {
  const StationOne({super.key});

  @override
  State<StationOne> createState() => _StationOneState();
}

class _StationOneState extends State<StationOne> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  // bool canBeMarkedDone =
  //     true; // TODO Video has been watched or some time has gone ...

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset(
      'assets/videos/bastelanleitung.mp4',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(false);
    _controller.addListener(checkVideo);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(S.station1Title),
        ),
        body: Container(
          padding: const EdgeInsets.all(25.0),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: L.heightOfTaskDescription,
                child: Container(
                  padding: const EdgeInsets.all(25.0),
                  child: const Text(S.station1Task,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: L.fontSize)),
                ),
              ),
              Flexible(
                flex: L.heightOfContent,
                child: IntrinsicWidth(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // If the VideoPlayerController has finished initialization, use
                            // the data it provides to limit the aspect ratio of the video.
                            return AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              // Use the VideoPlayer widget to display the video.
                              child: VideoPlayer(_controller),
                            );
                          } else {
                            // If the VideoPlayerController is still initializing, show a
                            // loading spinner.
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      Center(
                        child: IconButton(
                          icon: _controller.value.isPlaying
                              ? const Icon(Icons.pause)
                              : const Icon(Icons.play_arrow),
                          tooltip:
                              _controller.value.isPlaying ? S.pause : S.start,
                          iconSize: 80,
                          color: const Color.fromARGB(140, 10, 10, 10),
                          onPressed: () {
                            setState(() {
                              // If the video is playing, pause it.
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                // If the video is paused, play it.
                                _controller.play();
                              }
                            });
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        // height: 5,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          colors: const VideoProgressColors(
                              backgroundColor:
                                  Color.fromARGB(100, 234, 239, 242),
                              bufferedColor: Color.fromARGB(100, 170, 189, 199),
                              playedColor: Color.fromARGB(150, 13, 34, 69)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                  flex: L.heightOfFooter,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Consumer<StateModel>(
                      builder: (BuildContext context, model, Widget? child) {
                        return TextButton.icon(
                          icon: const Icon(Icons.check),
                          label: const Text(S.done),
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: model.station1TaskCompleted &&
                                  !model.station1Checked
                              ? () {
                                  setState(() {
                                    model.station1SetChecked(true);
                                  });
                                }
                              : null,
                        );
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void checkVideo() {
    // Implement your calls inside these conditions' bodies :
    if (_controller.value.position == _controller.value.duration) {
      setState(() {
        _controller.pause();
        Provider.of<StateModel>(context, listen: false)
            .station1SetTaskCompleted();
      });
    }
  }
}
