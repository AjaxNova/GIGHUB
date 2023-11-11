import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class ButJOBCard extends StatelessWidget {
  final JobModel job;

  const ButJOBCard(this.job, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Job Image
          Container(
            height: 100, // Customize the image size as needed
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    NetworkImage(job.photoUrl), // Use the job's photo URL here
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 12),

          // Job Title
          Text(
            job.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // Job Description
          Text(
            job.description,
            style: const TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 12),

          // Job Price and Price Type
          Row(
            children: <Widget>[
              Text(
                job.amount.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green, // Customize the color
                ),
              ),
              const SizedBox(width: 4),
              Text(
                job.amountType,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey, // Customize the color
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Job Location and Date/Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                job.place,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "${job.date.day}/${job.date.month}/${job.date.year} ${job.time}",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
