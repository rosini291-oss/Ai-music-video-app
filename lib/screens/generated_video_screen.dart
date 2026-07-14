import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class GeneratedVideoScreen extends StatefulWidget {
  final String imagePath;
  final String prompt;
  final String videoUrl;

  const GeneratedVideoScreen({
    super.key,
    required this.imagePath,
    required this.prompt,
    required this.videoUrl,
  });

  @override
  State<GeneratedVideoScreen> createState() =>
      _GeneratedVideoScreenState();
}

class _GeneratedVideoScreenState extends State<GeneratedVideoScreen> {
  late VideoPlayerController _controller;

  bool downloading = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    _controller.initialize().then((_) {
      _controller.play();
      _controller.setLooping(true);

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String> downloadVideoFile() async {
    final dir = await getTemporaryDirectory();

    final file =
        "${dir.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4";

    await Dio().download(
      widget.videoUrl,
      file,
    );

    return file;
  }

  Future<void> downloadVideo() async {
    try {
      setState(() {
        downloading = true;
      });

      final file = await downloadVideoFile();

      await GallerySaver.saveVideo(file);

      setState(() {
        downloading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Video u ruajt në Gallery"),
        ),
      );
    } catch (e) {
      setState(() {
        downloading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> shareVideo() async {
    final file = await downloadVideoFile();

    await Share.shareXFiles(
      [XFile(file)],
      text: "Created with AI Video Studio",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Generated Video"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.file(
                File(widget.imagePath),
                height: 200,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 20),

              Text(
                widget.prompt,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 20),

              if (_controller.value.isInitialized)
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              else
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: CircularProgressIndicator(),
                ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: () {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }

                  setState(() {});
                },
                icon: Icon(
                  _controller.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                label: Text(
                  _controller.value.isPlaying
                      ? "Pause"
                      : "Play",
                ),
              ),

              const SizedBox(height: 15),

              ElevatedButton.icon(
                onPressed: downloading ? null : downloadVideo,
                icon: downloading
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
                    : const Icon(Icons.download),
                label: const Text("Download"),
              ),

              const SizedBox(height: 15),

              ElevatedButton.icon(
                onPressed: shareVideo,
                icon: const Icon(Icons.share),
                label: const Text("Share"),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}