import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class CloudinaryService {
  static const cloudName = "bi4ytlzp";
  static const uploadPreset = "video_app";

  Future<String?> uploadImage(String imagePath) async {
    try {
      final url =
          "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

      FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(imagePath),
        "upload_preset": uploadPreset,
      });

      final response = await Dio().post(
        url,
        data: data,
      );

      if (response.statusCode == 200) {
        return response.data["secure_url"];
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }

  }
}