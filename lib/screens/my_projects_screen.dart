import 'dart:io';

import 'package:flutter/material.dart';

import '../models/project_model.dart';
import '../services/project_service.dart';

class MyProjectsScreen extends StatefulWidget {
  const MyProjectsScreen({super.key});

  @override
  State<MyProjectsScreen> createState() => _MyProjectsScreenState();
}

class _MyProjectsScreenState extends State<MyProjectsScreen> {
final ProjectService projectService = ProjectService();

List<ProjectModel> projects = [];

@override
void initState() {
super.initState();
loadProjects();
}

Future<void> loadProjects() async {
projects = await projectService.getProjects();

if (mounted) {
setState(() {});
}
}

Future<void> deleteProject(int index) async {
await projectService.deleteProject(
projects[index].id,
);

await loadProjects();
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.black,
appBar: AppBar(
backgroundColor: Colors.black,
title: const Text(
'My Projects',
style: TextStyle(
color: Colors.white,
),
),
),
body: projects.isEmpty
? const Center(
child: Text(
'No projects yet',
style: TextStyle(
color: Colors.grey,
fontSize: 18,
),
),
)
: ListView.builder(
padding: const EdgeInsets.all(20),
itemCount: projects.length,
itemBuilder: (context, index) {
  final project = projects[index];

  return Card(
  color: Colors.white12,
  margin: const EdgeInsets.only(bottom: 15),
  child: ListTile(
  leading: ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: Image.file(
  File(project.imagePath),
  width: 60,
  height: 60,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) {
  return const Icon(
  Icons.movie,
  color: Colors.deepPurple,
  size: 40,
  );
  },
  ),
  ),
  title: Text(
  project.title,
  style: const TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  ),
  ),
  subtitle: Text(
  project.createdAt.toString(),
  style: const TextStyle(
  color: Colors.grey,
  ),
  ),
  trailing: IconButton(
  icon: const Icon(
  Icons.delete,
  color: Colors.red,
  ),
  onPressed: () {
  deleteProject(index);
  },
  ),
  ),
  );
},
),
);
}
}