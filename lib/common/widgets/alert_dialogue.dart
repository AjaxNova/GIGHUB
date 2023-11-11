import 'package:flutter/material.dart';

class StoragePermissionDeniedDialog extends StatelessWidget {
  const StoragePermissionDeniedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Storage Permission Denied'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Storage permission is required to access and save files.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            'Please go to settings and grant storage permission.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Use your desired color
          ),
          child: const Text('OK'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement code to open app settings
            // For Android, you can use AppSettings.openAppSettings();
            // For iOS, you can use AppSettings.openAppSettings();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Use your desired color
          ),
          child: const Text('Go to Settings'),
        ),
      ],
    );
  }
}
