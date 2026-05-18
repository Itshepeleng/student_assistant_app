import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_app_/viewmodel/auth_viewmodel.dart';
import 'package:student_assistant_app_/routes/app_routes.dart';


class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() =>
      _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {

  final formKey = GlobalKey<FormState>();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authVM =
    Provider.of<AuthViewModel>(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: formKey,

          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              const Icon(
                Icons.school,
                size: 100,
              ),

              const SizedBox(height: 20),

              const Text(
                "Student Assistant System - Admin",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // EMAIL
              TextFormField(
                controller: emailController,

                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),

                validator: (value) {

                  if (value == null ||
                      value.isEmpty) {
                    return "Email required";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // PASSWORD
              TextFormField(
                controller: passwordController,
                obscureText: true,

                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),

                validator: (value) {

                  if (value == null ||
                      value.isEmpty) {
                    return "Password required";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              // LOGIN BUTTON
              SizedBox(
                width: double.infinity,

                child: ElevatedButton(

                  onPressed: () async {

                    if (formKey.currentState!
                        .validate()) {

                      bool success =
                      await authVM.signIn(
                        emailController.text,
                        passwordController.text,
                      );

                      if (success) {

                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.admin,
                        );

                      } else {

                        ScaffoldMessenger.of(
                            context)
                            .showSnackBar(

                          SnackBar(
                            content: Text(
                              authVM.errorMessage ??
                                  "Login Failed",
                            ),
                          ),
                        );
                      }
                    }
                  },

                  child: authVM.isLoading

                      ? const CircularProgressIndicator()

                      : const Text("Login"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}