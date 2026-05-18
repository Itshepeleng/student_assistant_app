import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/student_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/student.dart';

class AddStudentPage extends StatefulWidget {
  final Student? student;

  const AddStudentPage({super.key, this.student});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedYear = '1st Year';

  // Requirement: two modules max
  final List<String> _availableModules = [
    'TPG 116_Level:4',
    'TPG 216_Level:5',
    'TPG 316_Level:6',
    'SOD 116_Level:4',
    'SOD 216_Level:5',
    'SOD 316_Level:6',
    'SOE 116_Level:4',
    'SOE 216_Level:5',
    'SOE 316_Level:6',
    'ITS 116_Level:4',
    'ITS 216_Level:5',
    'ITS 316_Level:6',
    'CMN 116_Level:4',
    'CMN 216_Level:5',
    'CMN 316_Level:6',
  ];
  final List<String> _selectedModules = [];

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<StudentViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Student Assistant Application")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Capturing Name and Phone per your Student Class
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Full Name"),
              validator: (v) => v!.isEmpty ? "Required" : null,
            ),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.phone,
              validator: (v) => v!.isEmpty ? "Required" : null,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedYear,
              decoration: const InputDecoration(labelText: "Year of Study"),
              items: ['1st Year', '2nd Year', '3rd Year']
                  .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedYear = val!),
            ),
            const Divider(),
            const Text("Select Modules (Max 2)"),
            ..._availableModules.map((m) => CheckboxListTile(
                  title: Text(m),
                  value: _selectedModules.contains(m),
                  onChanged: (bool? checked) {
                    setState(() {
                      if (checked!) {
                        if (_selectedModules.length < 2)
                          _selectedModules.add(m);
                      } else {
                        _selectedModules.remove(m);
                      }
                    });
                  },
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() &&
                    _selectedModules.isNotEmpty) {
                  // Logic to save student profile and application to Supabase
                  final userId = Supabase.instance.client.auth.currentUser!.id;

                  final student = Student(
                    name: _nameController.text,
                    phone: _phoneController.text,
                    currentYear: _selectedYear,
                    modules: _selectedModules.join(', '),
                    userId: userId,
                  );

                  await vm.addStudent(userId, student.toJson().toString());

                  Navigator.pop(context);
                }
              },
              child: vm.isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Submit Application"),
            ),
          ],
        ),
      ),
    );
  }
}
