import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Ensure these paths match your actual file structure
import 'viewmodel/home_viewmodel.dart'; 
import 'views/home_view/home_view.dart';
import 'viewmodel/auth_viewmodel.dart';
import 'views/student_details_page.dart';
import 'viewmodel/student_viewmodel.dart';

/*void main() {
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
}*/

void main() async {
WidgetsFlutterBinding.ensureInitialized();
// Initialize Supabase with your credentials
await Supabase.initialize(
url: 'YOUR_SUPABASE_URL', // From Project Settings > API
anonKey: 'YOUR_ANON_KEY', // From Project Settings > API
);
runApp(const MyApp());
}
class MyApp extends StatelessWidget {
const MyApp({super.key});
@override
Widget build(BuildContext context) {
return MultiProvider(
providers: [
ChangeNotifierProvider(create: (_) => AuthViewModel()),
ChangeNotifierProvider(create: (_) => StudentViewModel()),
],
child: MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Student Manager',
home: const AuthWrapper(), // AuthWrapper decides login or home
),
);
}
}
