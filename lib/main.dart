import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'views/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

   await Supabase.initialize(
    url: 'https://scxrehepdqmtpxanxtkw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNjeHJlaGVwZHFtdHB4YW54dGt3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg0OTY0ODcsImV4cCI6MjA5NDA3MjQ4N30.l71PJl8YjXREQXRDighogYSIJPoOnUEatzzdyE4XVhE',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (_) => AuthViewModel(),
        ),

      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Assistant App',
        home: const LoginScreen(),
      )
    );
  }
}