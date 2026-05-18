import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/student.dart';
import '../models/admin.dart';


 // VIEWMODEL: AdminViewModel
 // Review, Approve, Reject, and Manage Applications.

class AdminViewModel extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  
   
   // Requirement: Display an overview of all submitted applications.
   
  Future<List<Student>> fetchAllApplications() async {
    try {
      final response = await _supabase
          .from('students')
          .select()
          .order('id', ascending: false);
      
      return (response as List)
          .map((json) => Student.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch applications: $e");
    }
  }

  
   //UPDATE METHOD: Approves or Rejects an application.
   //Requirement: Update application status based on administrative review.
   
  Future<void> updateApplicationStatus(String id, String newStatus) async {
    try {
      await _supabase
          .from('students')
          .update({'status': newStatus})
          .eq('id', id);
      
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to update status: $e");
    }
  }

  
   // DELETE METHOD: Removes invalid or erroneous records.
   // Requirement: Ability to remove invalid applications from the system.
   
  Future<void> removeApplication(String id) async {
    try {
      await _supabase.from('students').delete().eq('id', id);
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to delete record: $e");
    }
  }

  
   // FILTER METHOD: Logic to filter the list based on status.
   // Useful for UI implementation of Requirement 2.1.
   
  List<Student> filterApplications(List<Student> list, String criteria) {
    if (criteria == 'All') return list;
    return list.where((app) => app.status == criteria).toList();
  }
}
