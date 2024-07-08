import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/screens/treemap_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        title: const Text('TalentPool Login'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/diawan-logo.png',
              height: 150.0,
            ),
            const SizedBox(height: 60.0),
            Text(
              'Welcome back ${user?.displayName}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Hello there',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  void _showTermsDialog(String? uuid) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 25, 25, 25),
          title: const Text('Terms of Service and User Agreement'),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Please read and agree to the Terms of Service and User Agreement before proceeding.',
                ),
                SizedBox(height: 16.0),
                Text(
                  '1. Terms of Service:\nLorem ipsum dolor sit amet, consectetur adipiscing elit.',
                ),
                SizedBox(height: 8.0),
                Text(
                  '2. User Agreement:\nLorem ipsum dolor sit amet, consectetur adipiscing elit.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Decline'),
              onPressed: () {
                exit(0);
              },
            ),
            TextButton(
              child: const Text('Agree'),
              onPressed: () {
                _updateUser(id!, uuid);
                Navigator.of(context).pop();
                _showIdentityDialog();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateUser(int id, String? uuid) async {
    await ApiService().updateAgreementUser(id, uuid!);
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(
          context,
          '/treemap'
        );
      });
    }
  }

  Future<void> _checkUserAgreementsAndNavigate(int id) async {
    try {
      bool agreementsAccepted = await ApiService().checkUserAgreements(id);

      if (agreementsAccepted) {
        // Directly navigate to TreemapScreen
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TreemapScreen(title: 'Your Title')),
            );
          });
        }
      } else {
        // Show dialog if not already shown
        if (!_dialogShown) {
          _dialogShown = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showTermsDialog(uuid);
          });
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