class ProjectModel {
  final String id;
  final String title;
  final String imagePath;
  final String musicName;
  final String prompt;
  final String videoPath;
  final DateTime createdAt;

  ProjectModel({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.musicName,
    required this.prompt,
    required this.videoPath,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imagePath': imagePath,
      'musicName': musicName,
      'prompt': prompt,
      'videoPath': videoPath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'],
      title: map['title'],
      imagePath: map['imagePath'],
      musicName: map['musicName'],
      prompt: map['prompt'],
      videoPath: map['videoPath'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}