import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
const SplashScreen({super.key});

@override
State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
void initState() {
super.initState();

Future.delayed(const Duration(seconds: 3), () {
if (!mounted) return;

Navigator.pushReplacement(
context,
MaterialPageRoute(
builder: (context) => const LoginScreen(),
),
);
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.black,
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [

const Icon(
Icons.movie_creation,
size: 100,
color: Colors.deepPurple,
),

const SizedBox(height: 30),

const Text(
'AI Video Studio',
style: TextStyle(
color: Colors.white,
fontSize: 34,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 15),

Text(
'Create Professional Music Videos with AI',
textAlign: TextAlign.center,
style: TextStyle(
color: Colors.grey,
fontSize: 16,
),
),
],
),
),
);
}
}