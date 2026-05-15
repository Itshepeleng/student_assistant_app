import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_app_/models/student.dart';
import 'package:student_assistant_app_/viewmodel/student_viewmodel.dart';
import 'package:student_assistant_app_/routes/app_routes.dart';

class EditStudentPage extends StatefulWidget {
  final Student? student;

  const EditStudentPage({super.key, this.student});

  @override
  State<EditStudentPage> createState() => _EditStudentPageState();
}

class _EditStudentPageState extends State<EditStudentPage> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController moduleController;
  late TextEditingController yearController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student?.name ?? '');
    phoneController =
        TextEditingController(text: widget.student?.phone ?? '');
    moduleController =
        TextEditingController(text: widget.student?.modules ?? '');
    yearController =
        TextEditingController(text: widget.student?.currentYear ?? '1');
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    moduleController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null ? 'Add Student' : 'Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: moduleController,
              decoration: const InputDecoration(labelText: 'Modules'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: yearController,
              decoration: const InputDecoration(labelText: 'Current Year'),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _saveStudent(context),
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _saveStudent(BuildContext context) {
    final studentVM = context.read<StudentViewModel>();
    final name = nameController.text;
    final phone = phoneController.text;

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name and phone are required')),
      );
      return;
    }

    if (widget.student == null) {
      // Create new student
      studentVM.addStudent(name, phone);
    } else {
      // Update existing student
      studentVM.updateStudent(widget.student!.id, name, phone);
    }

    Navigator.pop(context);
  }
}
