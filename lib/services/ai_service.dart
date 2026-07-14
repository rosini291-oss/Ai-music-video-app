import 'dart:convert';

import 'package:http/http.dart' as http;

import 'cloudinary_service.dart';

class AIService {
  static const String apiUrl =
      "https://ai-video-worker.rosini291.workers.dev/";

  final CloudinaryService cloudinary = CloudinaryService();

  Future<String?> generateVideo({
    required String imageUrl,
    required String prompt,
  }) async {
    try {
      // Upload image to Cloudinary
      final cloudinaryUrl =
      await cloudinary.uploadImage(imageUrl);

      if (cloudinaryUrl == null) {
        print("Cloudinary upload failed");
        return null;
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "image": cloudinaryUrl,
          "prompt": prompt,
        }),
      );

      if (response.statusCode != 200) {
        print(response.body);
        return null;
      }

      final data = jsonDecode(response.body);

      if (data["output"] != null) {
        return data["output"].toString();
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}