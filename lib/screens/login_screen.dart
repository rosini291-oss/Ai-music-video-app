import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
const LoginScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.black,
body: Padding(
padding: const EdgeInsets.all(24),
child: Center(
child: SingleChildScrollView(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [

const Text(
'Welcome Back',
style: TextStyle(
color: Colors.white,
fontSize: 32,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 40),

TextField(
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
hintText: 'Email',
hintStyle: const TextStyle(color: Colors.grey),
filled: true,
fillColor: Colors.white12,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(12),
),
),
),

const SizedBox(height: 20),

TextField(
obscureText: true,
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
hintText: 'Password',
hintStyle: const TextStyle(color: Colors.grey),
filled: true,
fillColor: Colors.white12,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(12),
),
),
),

const SizedBox(height: 30),

SizedBox(
width: double.infinity,
height: 55,
child: ElevatedButton(
onPressed: () {
Navigator.pushReplacement(
context,
MaterialPageRoute(
builder: (context) => const HomeScreen(),
),
);
},
child: const Text(
'LOGIN',
style: TextStyle(fontSize: 18),
),
),
),

const SizedBox(height: 20),

TextButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => const RegisterScreen(),
),
);
},
child: const Text(
'Create new account',
style: TextStyle(
color: Colors.deepPurple,
),
),
),
],
),
),
),
),
);
}
}