import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthViewModel extends ChangeNotifier {

  final SupabaseClient supabase =
      Supabase.instance.client;

  bool isLoading = false;

  String? errorMessage;

  bool get isLoggedIn =>
      supabase.auth.currentSession != null;

  // LOGIN
  Future<bool> signIn(
      String email,
      String password,
      ) async {

    try {

      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return true;

    } catch (e) {

      errorMessage = e.toString();
      return false;

    } finally {

      isLoading = false;
      notifyListeners();
    }
  }

  // LOGOUT
  Future<void> signOut() async {

    await supabase.auth.signOut();
    notifyListeners();
  }
}