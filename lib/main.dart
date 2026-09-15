import 'package:flutter/material.dart';
import 'package:khalti/khalti.dart';
import 'package:project_neon/ui/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Khalti.init(
      publicKey: 'test_public_key_f65077ad4a114458a95df7c0cff36170',
      enabledDebugging: false);
  await Supabase.initialize(
    url: 'https://rnowluzzzxtzeeirudcj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub3dsdXp6enh0emVlaXJ1ZGNqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE3NzAxOTgsImV4cCI6MjAxNzM0NjE5OH0.NnkDsDd-gigpd-L7LhU7WuIEQc8o_f83zvq6Nnb2Yos',
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.red[300]),
      home: SplashScreen(),
    ),
  ); //My App
}
