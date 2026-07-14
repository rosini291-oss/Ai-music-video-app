import 'package:dio/dio.dart';

class CloudinaryService {
  static const String cloudName = "bi4ytlzp";
  static const String uploadPreset = "video_app";

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(minutes: 2),
    ),
  );

  Future<String?> uploadImage(String imagePath) async {
    try {
      final String url =
          "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

      final FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(imagePath),
        "upload_preset": uploadPreset,
      });

      final Response response = await _dio.post(
        url,
        data: formData,
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data != null && data["secure_url"] != null) {
          return data["secure_url"] as String;
        }
      }

      return null;
    } catch (e) {
      print("Cloudinary upload error: $e");
      return null;
    }
  }
}