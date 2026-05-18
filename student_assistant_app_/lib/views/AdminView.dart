import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../viewmodel/student_viewmodel.dart';
import '../models/student.dart';
import '../routes/app_routes.dart';
import 'edit_student_page.dart';
import '../viewmodel/admin_viewModel.dart';



 // VIEW: AdminDashboard
  //Provides the administrative interface for managing applications.
 // Requirement 2.1: View, Review, Approve, Reject, Update, and Filter applications.
 
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  void initState() {
    super.initState();
    // Fetch all applications for the admin overview
    Future.microtask(() => 
      context.read<StudentViewModel>().fetchStudents()
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch the StudentViewModel for data changes and filtering
    final vm = context.watch<StudentViewModel>();
        final vm1 = context.watch<AdminViewModel>();

    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Portal"),
        backgroundColor: Colors.indigo.shade50,
        actions: [
          // Requirement: Optionally filter application data
          PopupMenuButton<String>(
            onSelected: (val) => vm.setFilter(val),
            itemBuilder: (context) => ['All', 'Pending', 'Approved', 'Rejected']
                .map((e) => PopupMenuItem(value: e, child: Text(e)))
                .toList(),
            icon: const Icon(Icons.filter_list),
          ),
          // Logout functionality
          IconButton(
            icon: const Icon(Icons.logout), 
            onPressed: () => context.read<AuthViewModel>().signOut(),
          )
        ],
      ),
      body: Column(
        children: [
          // Dashboard Header / Stats
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            color: Colors.indigo.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Applications: ${vm.students.length}", 
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                ),
                
              ],
            ),
          ),
          
          // Requirement: View all submitted applications
          Expanded(
            child: vm.isLoading 
              ? const Center(child: CircularProgressIndicator()) 
              : vm.students.isEmpty 
                  ? const Center(child: Text("No applications found matching criteria."))
                  : ListView.builder(
                      itemCount: vm.students.length,
                      itemBuilder: (context, index) {
                        final s = vm.students[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ExpansionTile(
                            leading: CircleAvatar(
                              backgroundColor: _getStatusColor(s.status).withOpacity(0.2),
                              child: Icon(Icons.person, color: _getStatusColor(s.status)),
                            ),
                            title: Text(s.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text("Student #: ${s.id} | Status: ${s.status}"),
                            children: [
                              // Requirement: Review applicant information
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Application Details", style: TextStyle(fontWeight: FontWeight.bold)),
                                    const Divider(),
                                    Text("Requested Course: ${s.modules}"),
                                    const SizedBox(height: 20),
                                    
                                    // Requirement: Approve, Reject, or Remove invalid applications
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () => vm1.updateApplicationStatus(s.id!, 'Approved'),
                                          icon: const Icon(Icons.check),
                                          label: const Text("Approve"),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green, 
                                            foregroundColor: Colors.white
                                          ),
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () => vm1.updateApplicationStatus(s.id!, 'Rejected'),
                                          icon: const Icon(Icons.close),
                                          label: const Text("Reject"),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red, 
                                            foregroundColor: Colors.white
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete_outline, color: Colors.grey),
                                          tooltip: "Remove Invalid",
                                          onPressed: () => _confirmDelete(context, vm, s.id!),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

  // Helper to get color based on application status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved': return Colors.green;
      case 'Rejected': return Colors.red;
      default: return Colors.orange;
    }
  }

  // Confirmation dialog for deleting applications
  void _confirmDelete(BuildContext context, StudentViewModel vm, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Remove Application?"),
        content: const Text("This will permanently delete the invalid application record."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              vm.deleteStudent(id);
              Navigator.pop(ctx);
            }, 
            child: const Text("Delete", style: TextStyle(color: Colors.red))
          ),
        ],
      ),
    );
  }
}
