import 'package:flutter/material.dart';

import '../services/ai_service.dart';
import 'generated_video_screen.dart';

class VideoGenerationScreen extends StatefulWidget {
  final String imagePath;
  final String prompt;

  const VideoGenerationScreen({
    Key? key,
    required this.imagePath,
    required this.prompt,
  }) : super(key: key);

  @override
  State<VideoGenerationScreen> createState() =>
      _VideoGenerationScreenState();
}

class _VideoGenerationScreenState extends State<VideoGenerationScreen> {
  @override
  void initState() {
    super.initState();
    startGeneration();
  }

  Future<void> startGeneration() async {
    final ai = AIService();

    final videoUrl = await ai.generateVideo(
      imageUrl: widget.imagePath,
      prompt: widget.prompt,
    );

    if (!mounted) return;

    if (videoUrl != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => GeneratedVideoScreen(
            imagePath: widget.imagePath,
            prompt: widget.prompt,
            videoUrl: videoUrl,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Video generation failed"),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "AI Video Generator",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.movie_creation,
                color: Colors.deepPurple,
                size: 90,
              ),
              SizedBox(height: 30),
              Text(
                "Generating AI Video...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
              SizedBox(height: 30),
              Text(
                "Please wait 2-3 minutes",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}