import 'package:flutter/material.dart';

class MockHomePage extends StatelessWidget {
  const MockHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'JobTok',
          style: TextStyle(
            color: Colors.white, // Text color in the app bar
          ),
        ),
        backgroundColor: Colors.blue, // Primary color for the app bar
      ),
      body: ListView.builder(
        itemCount: jobList.length,
        itemBuilder: (context, index) {
          final job = jobList[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    job.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    job.description,
                    style: const TextStyle(
                      color: Colors.grey, // Text color for job descriptions
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        job.location,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Implement action for applying to the job
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.orange, // Accent color for buttons
                        ),
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement action for creating a new job post
        },
        backgroundColor: Colors.blue, // Primary color for the FAB
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Job {
  final String title;
  final String description;
  final String location;

  Job(this.title, this.description, this.location);
}

final List<Job> jobList = [
  Job('Job Title 1', 'Job Description 1', 'Location 1'),
  Job('Job Title 2', 'Job Description 2', 'Location 2'),
  // Add more job listings as needed
];
