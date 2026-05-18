import 'package:flutter/material.dart';
import 'package:student_assistant_app_/models/student.dart';
import 'package:student_assistant_app_/views/login_view.dart';
import 'package:student_assistant_app_/views/student_list_view.dart';
import 'package:student_assistant_app_/views/student_details_page.dart';
import 'package:student_assistant_app_/views/edit_student_page.dart';
import 'package:student_assistant_app_/views/auth_wrapper.dart';
import 'package:student_assistant_app_/views/AdminView.dart';
import 'package:student_assistant_app_/models/admin.dart';
///import 'package:student_assistant_app_/viewmodel/admin_viewModel';

/// Route names as constants for type-safe navigation
class AppRoutes {
  static const String initial = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String studentDetails = '/student-details';
  static const String editStudent = '/edit';
  static const String admin = '/admin';

}

/// Route generator function
Route<dynamic>? Function(RouteSettings) get onGenerateRoute {
  return (RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.initial:
        return MaterialPageRoute(builder: (_) => const AuthWrapper());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const StudentListView());

      case AppRoutes.admin:
        return MaterialPageRoute(builder:(_) => const AdminDashboard());


      case AppRoutes.studentDetails:
        if (args is Student) {
          return MaterialPageRoute(
            builder: (_) => StudentDetailsPage(student: args),
          );
        }
        return _errorRoute();

      case AppRoutes.editStudent:
        if (args is Student?) {
          return MaterialPageRoute(
            builder: (_) => EditStudentPage(student: args),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  };
}

/// Error route for undefined routes
Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (_) => const Scaffold(
      body: Center(
        child: Text('No route defined for requested page'),
      ),
    ),
  );
}
