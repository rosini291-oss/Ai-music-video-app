import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/project_model.dart';

class ProjectService {
  static const String storageKey = 'video_projects';

  Future<void> saveProject(ProjectModel project) async {
    final prefs = await SharedPreferences.getInstance();

    final projects = prefs.getStringList(storageKey) ?? [];

    projects.add(jsonEncode(project.toMap()));

    await prefs.setStringList(storageKey, projects);
  }

  Future<List<ProjectModel>> getProjects() async {
    final prefs = await SharedPreferences.getInstance();

    final projects = prefs.getStringList(storageKey) ?? [];

    return projects
        .map(
          (item) => ProjectModel.fromMap(
        jsonDecode(item),
      ),
    )
        .toList();
  }

  Future<void> deleteProject(String id) async {
    final prefs = await SharedPreferences.getInstance();

    final projects = prefs.getStringList(storageKey) ?? [];

    projects.removeWhere((item) {
      final project = ProjectModel.fromMap(jsonDecode(item));
      return project.id == id;
    });

    await prefs.setStringList(storageKey, projects);
  }

  Future<void> clearProjects() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(storageKey);
  }
}