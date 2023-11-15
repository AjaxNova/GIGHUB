import 'package:flutter/material.dart';

class MyAppasdasd extends StatelessWidget {
  const MyAppasdasd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Job Page'),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(255, 255, 255, 0.8), // Transparent white
                Color.fromRGBO(200, 200, 255, 0.5), // Transparent blue
              ],
            ),
          ),
          child: Center(
            child: Card(
              elevation: 5.0, // Add shadow to the card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.all(20.0),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Post a Job',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Add your job posting form here
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
