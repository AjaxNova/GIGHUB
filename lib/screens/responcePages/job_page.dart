// import 'package:flutter/material.dart';

// class JobHomePage extends StatelessWidget {
//   const JobHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         // appBar: const (),
//         body: const JobList(),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             // Handle FAB press to post a new job
//           },
//           child: const Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }

// class JobList extends StatelessWidget {
//   const JobList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Replace with actual job data or use a ListView.builder
//     return ListView(
//       padding: const EdgeInsets.all(16.0),
//       children: const [
//         JobCard(
//           title: 'Software Engineer',
//           description: 'Develop and maintain software applications...',
//           amount: '\$80,000 - \$100,000',
//           applicantsCount: 25,
//           date: 'Aug 28, 2023',
//         ),
//         JobCard(
//           title: 'Software Engineer',
//           description: 'Develop and maintain software applications...',
//           amount: '\$80,000 - \$100,000',
//           applicantsCount: 25,
//           date: 'Aug 28, 2023',
//         ),
//         JobCard(
//           title: 'Software Engineer',
//           description: 'Develop and maintain software applications...',
//           amount: '\$80,000 - \$100,000',
//           applicantsCount: 25,
//           date: 'Aug 28, 2023',
//         ),
//         JobCard(
//           title: 'Software Engineer',
//           description: 'Develop and maintain software applications...',
//           amount: '\$80,000 - \$100,000',
//           applicantsCount: 25,
//           date: 'Aug 28, 2023',
//         ),
//         JobCard(
//           title: 'Software Engineer',
//           description: 'Develop and maintain software applications...',
//           amount: '\$80,000 - \$100,000',
//           applicantsCount: 25,
//           date: 'Aug 28, 2023',
//         ),
//         // Add more JobCard widgets here
//       ],
//     );
//   }
// }

// class JobCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final String amount;
//   final int applicantsCount;
//   final String date;

//   const JobCard({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.amount,
//     required this.applicantsCount,
//     required this.date,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8.0),
//             Text(description),
//             const SizedBox(height: 12.0),
//             Text(
//               amount,
//               style: TextStyle(color: Theme.of(context).colorScheme.secondary),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     const Icon(Icons.person, color: Colors.grey),
//                     const SizedBox(width: 4.0),
//                     Text('$applicantsCount applicants'),
//                   ],
//                 ),
//                 Text(date, style: const TextStyle(color: Colors.grey)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class JObbbScreen extends StatelessWidget {
  const JObbbScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2A47),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              "Welcome, Ayush",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: jobList.length,
                itemBuilder: (context, index) {
                  return JobCard(job: jobList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//job card 1
// class JobCard extends StatelessWidget {
//   final Job job;

//   const JobCard({super.key, required this.job});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to job description
//       },
//       child: Card(
//         elevation: 5,
//         color: const Color(0xFF2E3E5E),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     job.date,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   Text(
//                     job.price,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 job.title,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               ),
//               Text(
//                 job.description,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.white.withOpacity(0.8),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     "Applied: ${job.totalApplied}",
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white.withOpacity(0.8),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 200,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/user_avatar.jpg'),
                  // You can replace this with the actual user's image
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    job.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
              child: Text(
                job.description,
                maxLines: 2, // Adjust as needed
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  job.timeAgo,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                Text(
                  job.price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE53935),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.monetization_on,
                  size: 16,
                  color: Colors.black.withOpacity(0.7),
                ),
                const SizedBox(width: 4),
                Text(
                  'Cash Details',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Job {
  final String title;
  final String description;
  final String timeAgo;
  final String price;
  final int totalApplied;

  Job({
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.price,
    required this.totalApplied,
  });
}

List<Job> jobList = [
  Job(
    title: "Graphic Designer",
    description: "Create stunning visuals.",
    timeAgo: "12 min ago ",
    price: "\$25/hour",
    totalApplied: 8,
  ),
];
