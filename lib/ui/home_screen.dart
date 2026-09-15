import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:project_neon/ui/store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = false;

  final supabase = Supabase.instance.client;

  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  List<String> errors = [];
  int currentPageIndex = 0; 

  @override
  void initState() {
    super.initState();
    // FIX: Updated listener to use 'currentIndex' (v1.0.0 breaking change)
    sideMenu.addListener(() {
      final targetPage = sideMenu.currentIndex; 
      if (pageController.hasClients) {
        pageController.jumpToPage(targetPage);
      }
      setState(() {
        currentPageIndex = targetPage; 
      });
    });
  }

  @override
  void dispose() {
    sideMenu.dispose();
    pageController.dispose();
    super.dispose();
  }

  getCurrentUser() async {
    final currentUser = supabase.auth.currentUser;
    if (currentUser != null) {
      final response = await supabase.from('current_user').select();
      print('User data: $response');
    } else {
      print('No current user authenticated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            // FIX: Updated to the current easy_sidemenu API
            theme: SideMenuThemeData(
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Colors.black26,
              selectedHoverColor: Colors.black26,
              selectedColor: Colors.black54,
              selectedTitleStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              backgroundColor: Colors.black87,
            ),
            title: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                    maxWidth: 200,
                  ),
                  child: Image.asset(
                    'assets/app_icon.png',
                  ),
                ),
                const Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            footer: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Text(
                    'Bigyan Shrestha',
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ),
            ),
            items: [
              SideMenuItem(
                title: 'Store',
                // FIX: Replaced changePage with goTo
                onTap: (index, _) {
                  sideMenu.goTo(index);
                },
                icon: const Icon(Icons.home),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Library',
                // FIX: Replaced changePage with goTo
                onTap: (index, _) {
                  sideMenu.goTo(index);
                },
                icon: const Icon(Icons.supervisor_account),
              ),
              SideMenuItem(
                builder: (context, displayMode) {
                  return const Divider(
                    endIndent: 8,
                    indent: 8,
                  );
                },
              ),
              SideMenuItem(
                title: 'Log Out',
                // FIX: Replaced changePage with goTo
                onTap: (index, _) async {
                  sideMenu.goTo(index);
                },
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: 4, 
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Store(); 
                  case 1:
                    return Container(
                      color: Colors.black87,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'User Information:',
                              style: TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            const SizedBox(height: 20),
                            FutureBuilder(
                              future: getCurrentUser(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return const Column(
                                    children: [
                                      Text('User tracking placeholder', style: TextStyle(color: Colors.white)),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  case 2:
                    return Container(color: Colors.black87); 
                  case 3:
                    return Container(
                      color: Colors.black87,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Are you sure you want to log out?',
                              style: TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            const SizedBox(height: 20),
                            _loading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        _loading = true;
                                      });
                                      await supabase.auth.signOut();
                                      if (mounted) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                                        );
                                      }
                                    },
                                    child: const Text('Log Out'),
                                  ),
                          ],
                        ),
                      ),
                    );
                  default:
                    return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
