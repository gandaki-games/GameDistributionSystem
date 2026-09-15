import 'package:flutter/material.dart';
import 'package:project_neon/ui/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final supabase = Supabase.instance.client; //Initialize the Supabase instance.
  bool _loading = false;

  Future<void> insertCurrentUser() async {
    final currentUser = supabase.auth.currentUser;
    if (currentUser != null) {
      final response = await supabase.from('high_scores').upsert(
        {
          'email': currentUser.email,
          'username': currentUser.userMetadata?['display_name'],
        },
        onConflict: currentUser.userMetadata?['email'],
      );
      if (response.error != null) {
        print('Error inserting user data: ${response.error!.message}');
      } else {
        print('User data inserted successfully');
      }
    } else {
      print('No current user authenticated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF424242),
                Color(0xff9C27B0),
                Color(0xFF303030),
              ],
              stops: [0.05, 0.25, 0.7],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 35,
              ),
              //Image.asset(name),
              const SizedBox(
                height: 15,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 200,
                  maxWidth: 200,
                ),
                child: Image.asset(
                  'assets/app_icon.png',
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      'Welcome to Neon. A Gamers Paradise.',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Click on the button to continue.',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black38,
                              foregroundColor: Colors.white70,
                            ),

                            onPressed: () async {

                              setState(() {
                                _loading = true;
                              });
                              await Future.delayed(Duration(seconds: 1));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                              setState(()  {

                                _loading = false;
                              });

                            },
                            child: _loading
                                ? const CircularProgressIndicator()
                                : const Text('Sign in to Neon'),
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
