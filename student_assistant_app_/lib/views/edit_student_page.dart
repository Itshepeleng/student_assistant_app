import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_app_/models/student.dart';
import 'package:student_assistant_app_/services/storage_service.dart';
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
  File? selectedImage;

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
    selectedImage = null;
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
            GestureDetector(
              onTap: () => _pickImage(context),
              child: CircleAvatar(
                radius: 48,
                backgroundImage: selectedImage != null
                    ? FileImage(selectedImage!)
                    : (widget.student?.profilePictureUrl != null
                        ? NetworkImage(widget.student!.profilePictureUrl!)
                            as ImageProvider
                        : null),
                child: selectedImage == null && widget.student?.profilePictureUrl == null
                    ? const Icon(Icons.add_a_photo, size: 32)
                    : null,
              ),
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: () => _pickImage(context),
              icon: const Icon(Icons.photo_camera),
              label: const Text('Choose image'),
            ),
            const SizedBox(height: 16),
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
      studentVM.addStudent(name, phone, profileImage: selectedImage);
    } else {
      // Update existing student
      studentVM.updateStudent(
        widget.student!.id,
        name,
        phone,
        newProfileImage: selectedImage,
      );
    }

    Navigator.pop(context);
  }

  Future<void> _pickImage(BuildContext context) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final image = await StorageService.pickImage(source);
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
      return;
    }

    setState(() {
      selectedImage = image;
    });
  }
}

