import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_app_/viewmodel/auth_viewmodel.dart';
import 'login_view.dart';
import 'student_list_view.dart';

/// AuthWrapper decides which screen to show based on authentication state
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authVM, _) {
        if (authVM.isLoggedIn) {
          return const StudentListView();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
