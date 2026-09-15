import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_neon/UI/register_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_screen.dart';

//Login Page Class..............................................................Class
class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginPage();
}

class LoginPage extends State<LoginScreen> {
  bool _loading = false;
  bool _isPasswordVisible = false;
  final supabase = Supabase.instance.client;

  final _emailController =
      TextEditingController(text: 'cyberpunkstha@gmail.com');
  final _passwordController = TextEditingController(text: '123games');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(


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
                  height: 30,
                ),
                SizedBox(
                  height: 480,
                  width: 325,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Sign in into your Neon account.',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            labelText: 'Email Address  *',
                            labelStyle: TextStyle(
                              color: Colors.black54,
                            ),
                            filled: true,
                            fillColor: Colors.black26,
                            suffixIcon: FaIcon(
                              FontAwesomeIcons.envelope,
                              size: 17,
                              color: Colors.black87,
                            )),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password  *',
                          labelStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          filled: true,
                          fillColor: Colors.black26,
                          suffixIcon: IconButton(
                            icon: FaIcon(
                              _isPasswordVisible
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              size: 17,
                              color: Colors.black87,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(50, 1, 30, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.purple[300],
                                ),
                                child: const Text('Forget Password?'),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                try {
                                  final email = _emailController.text.trim();
                                  final password =
                                      _passwordController.text.trim();
                                  await supabase.auth.signInWithPassword(
                                    email: email,
                                    password: password,
                                  );
                                  await Future.delayed(
                                      Duration(milliseconds: 1));

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Login Success'),
                                      backgroundColor: Colors.lightGreen,
                                    ),
                                  );
                                  await Future.delayed(Duration(seconds: 1));
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()),
                                  );
                                } on AuthException catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(error.message),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                }
                                setState(() {
                                  _loading = false;
                                });
                              },
                              child: _loading
                                  ? const CircularProgressIndicator()
                                  : const Text('Sign in to Neon'),
                            )
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'New on Neon?',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()),
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.purple[300],
                            ),
                            child: const Text('Register.'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /*const Text(
                        'Or',
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Login Using.',
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black38,
                              foregroundColor: Colors.white70,
                            ),
                            onPressed: () async {
                              try {} catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Login failed'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } finally {}
                            },
                            icon: const Icon(
                              FontAwesomeIcons.google,
                            ),
                            label: const Text('Sign in with Google Account'),
                          ),
                        ],
                      ),*/
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
