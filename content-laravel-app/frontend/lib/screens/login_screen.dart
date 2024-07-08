import 'package:flutter/material.dart';
import 'package:frontend/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/services/api_services.dart';

final Uri _url = Uri.parse('https://karir.diawan.id/');

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 25, 25),
        title: const Text(''),
      ),
      body: _isLoading
        ? const Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 50.0,
            ),
          )
        : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/diawan-logo.png',
              height: 150.0,
            ),
            const SizedBox(height: 60.0),
            Text(
              'Welcome back!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Hello there, please login to continue.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: 250, // Set your desired fixed width here
              child: FilledButton.icon(
                onPressed: _signInWithGoogle,
                icon: Image.asset(
                  'assets/google-icon.png',
                  height: 16.0,
                  width: 16.0,
                ),
                label: const Text('Sign-In with Google'),
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Don\'t have an Account?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 4.0),
                GestureDetector(
                  onTap: _launchUrl,
                  child: const Text(
                    'Sign-Up',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 132, 255),
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<int> _returnUserId (String u) async {
    final int temp = await ApiService().getUserId(u);

    return temp;
  }

  void _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      User? googleUser = await _authService.signInWithGoogle();

      if (googleUser != null && mounted) {
        final Map<String, dynamic> checkResult = await ApiService().checkUser(googleUser.email);
        final bool emailCheck = checkResult['exists'] as bool;
        final String uuid = checkResult['unique_id'] as String;
        final String userStatus = checkResult['status'] as String;
        int id = await _returnUserId(uuid);

        emailCheck 
          ? userStatus == '0'
            ? Navigator.pushReplacementNamed(
                context,
                '/key', 
                arguments: {
                  'user': googleUser,
                  'uuid': uuid,
                  'id': id,
                }
              )
            : Navigator.pushReplacementNamed(
                context,
                '/home',
                arguments: {
                  'user': googleUser,
                  'uuid': uuid,
                  'id': id,
                }
              )
          : _showCareerPageDialog(context);
      } else {
        showErrorSnackBar('Sign-In Failed');
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showCareerPageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color.fromARGB(255, 25, 25, 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SizedBox(
            width: 480.0,  // Set your desired width here
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Notice',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Your email has not been registered in our Careers page! You will be redirected to our Careers page from this button.",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _launchUrl();
                      },
                      child: const Text('Register Now'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    ).then((_) {
      _authService.signOut(context);
    });
  }

  void showErrorSnackBar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      ),
    );
  }
    
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}