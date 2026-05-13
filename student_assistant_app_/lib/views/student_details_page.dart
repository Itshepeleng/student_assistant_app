import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/student_viewmodel.dart';
import '../models/student.dart';

class StudentDetailsPage extends StatelessWidget {
  final Student student;

  const StudentDetailsPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Application Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Status: ${student.status.toUpperCase()}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Divider(),
            Text("Current Year: ${student.currentYear}"),
            const SizedBox(height: 10),
            Text("Applied Modules: ${student.modules}"),
            const Spacer(),

            // Only show Edit/Delete if status is 'pending'
            if (student.status == 'pending') ...[
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/edit',
                          arguments: student),
                      child: const Text("Edit Application"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () => _confirmDelete(context),
                      child: const Text("Delete"),
                    ),
                  ),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content:
            const Text("Are you sure you want to delete this application?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                Provider.of<StudentViewModel>(context, listen: false)
                    .deleteStudent(student.id);
                Navigator.popUntil(context, ModalRoute.withName('/home'));
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}
