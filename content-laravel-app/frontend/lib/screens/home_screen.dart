import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/screens/home/dashboard_content.dart';
import 'package:frontend/screens/home/projects_screen.dart';
import 'package:frontend/screens/home/todo_screen.dart';
import 'package:frontend/screens/home/billing_screen.dart';
import 'package:frontend/screens/home/profile_screen.dart';
import 'package:frontend/screens/helper/helper_user_terms.dart';
import 'package:frontend/services/api_services.dart';
import 'package:frontend/services/auth_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;
  String? uuid;
  int? id;
  bool _dialogShown = false;

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    DashboardContent(),
    const ProjectsScreen(),
    const TodoScreen(),
    const BillingScreen(),
    const ProfileScreen(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is Map<String, dynamic>) {
      user = args['user'] as User?;
      uuid = args['uuid'] as String?;
      id = args['id'] as int?;

      _checkUserAgreementsAndNavigate(id!);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 25, 25),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut(context);
            }
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Billing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Future<void> _checkUserAgreementsAndNavigate(int id) async {
    try {
      final Object agreementsAccepted = await ApiService().checkUserAgreements(id);

      if (agreementsAccepted is Map<String, dynamic>) {
        if (agreementsAccepted['tos'] == '1' && agreementsAccepted['pp'] == '1') {
          // Directly navigate to TreemapScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          // Show dialog if not already shown
          if (!_dialogShown) {
            _dialogShown = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showTermsDialog(context, id, uuid);
            });
          }
        }
      }
    } catch (e) {
      print('Error checking user agreements: $e');
    }
  }

  void showErrorSnackBar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      ),
    );
  }
}