import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Ensure these paths match your actual file structure
import 'viewmodel/home_view_model.dart'; 
import 'views/home_view/home_view.dart';

void main() {
  runApp(
    // MultiProvider allows you to add more ViewModels (like AuthViewModel) later
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: const StudentPortalApp(),
    ),
  );
}

class StudentPortalApp extends StatelessWidget {
  const StudentPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Assistant Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // The app starts here, fulfilling the "Authentication Screen" requirement 
      // by directing users to the appropriate interface after login.
      home: HomeScreen(), 
    );
  }
}
