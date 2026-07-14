import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepPurple,
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'AI Creator',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Premium Member',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 35),

            Card(
              color: Colors.white12,
              child: ListTile(
                leading: const Icon(
                  Icons.video_library,
                  color: Colors.white,
                ),
                title: const Text(
                  'My Videos',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Card(
              color: Colors.white12,
              child: ListTile(
                leading: const Icon(
                  Icons.payment,
                  color: Colors.white,
                ),
                title: const Text(
                  'Subscription',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'LOGOUT',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}