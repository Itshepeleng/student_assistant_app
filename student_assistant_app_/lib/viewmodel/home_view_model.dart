import 'package:flutter/material.dart';
import '../models/application.dart';

class HomeViewModel extends ChangeNotifier {
  List<Application> _applications = [];
  bool _isLoading = false;

  List<Application> get applications => _applications;
  bool get isLoading => _isLoading;

  // Fetches applications from the backend (e.g., Supabase)
  Future<void> fetchUserApplications() async {
    _isLoading = true;
    notifyListeners();

    // Simulation of data retrieval scoped to the authenticated user
    await Future.delayed(Duration(seconds: 2)); 
    
    _applications = [
      Application(id: '1', position: 'IT Lab Assistant', status: 'Pending', dateSubmitted: DateTime.now()),
      Application(id: '2', position: 'Library Peer Tutor', status: 'Approved', dateSubmitted: DateTime.now().subtract(Duration(days: 5))),
    ];

    _isLoading = false;
    notifyListeners();
  }
}