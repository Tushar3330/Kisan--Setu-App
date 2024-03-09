import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kisan_setu/Screens/homescreeen.dart';
import 'register_screen.dart'; // Import the registration screen

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<String> welcomeMessages = [
    'Welcome', // English
    'नमस्ते', // Hindi (Namaste)
    'స్వాగతం', // Telugu (Swagatham)
  ];
  int currentMessageIndex = 0;
  bool isEmailLogin = true;
  bool isPhoneVerification = false;
  late String verificationId = '';
  String _selectedCountryCode = '+91'; // Default country code

  // Function to display a message
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // Function to handle successful login
  void _handleSuccessfulLogin() {
    _showMessage('Login successful');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  // Function to handle failed login
  void _handleFailedLogin(String errorMessage) {
    _showMessage(errorMessage);
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      if (isEmailLogin) {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } else if (isPhoneVerification) {
        // Handle phone number authentication using OTP
        final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: _otpController.text,
        );
        await _auth.signInWithCredential(credential);
      }
      _handleSuccessfulLogin();
    } catch (error) {
      _handleFailedLogin('Error signing in: $error');
      print('Error signing in: $error');
      // Handle login errors here
    }
  }

  Future<void> _signInWithPhone() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '$_selectedCountryCode${_phoneNumberController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          _handleSuccessfulLogin();
        },
        verificationFailed: (FirebaseAuthException e) {
          _handleFailedLogin('Invalid phone number format');
          print('Error verifying phone number: $e');
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            this.verificationId = verificationId;
            isPhoneVerification = true;
          });
          _showMessage('OTP sent to $_selectedCountryCode${_phoneNumberController.text}');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            this.verificationId = verificationId;
          });
        },
        timeout: Duration(seconds: 60),
        // Specify null to use the default reCAPTCHA flow without opening the browser
        autoRetrievedSmsCodeForTesting: null,
      );
    } catch (error) {
      _handleFailedLogin('Error signing in with phone: $error');
      print('Error signing in with phone: $error');
      // Handle phone sign-in errors here
    }
  }

  void _navigateToRegisterScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  Future<void> _resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      // Show success message or navigate to a screen indicating password reset instructions
    } catch (error) {
      _handleFailedLogin('Error resetting password: $error');
      print('Error resetting password: $error');
      // Handle password reset errors here
    }
  }

  void _changeWelcomeMessage() {
    setState(() {
      currentMessageIndex = (currentMessageIndex + 1) % welcomeMessages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100], // Background color
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.green[700], // App bar color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 1),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/farmer.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                welcomeMessages[currentMessageIndex],
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              isEmailLogin
                  ? Column(
                      children: [
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                        ),
                      ],
                    )
                  : isPhoneVerification
                      ? Column(
                          children: [
                            TextField(
                              controller: _otpController,
                              decoration: InputDecoration(
                                labelText: 'Enter OTP',
                              ),
                            ),
                            SizedBox(height: 20.0),
                            ElevatedButton(
                              onPressed: _signInWithEmailAndPassword,
                              child: Text('Verify OTP'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green[700], // Button color
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                DropdownButton<String>(
                                  value: _selectedCountryCode,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedCountryCode = value!;
                                    });
                                  },
                                  items: <String>['+91', '+1', '+44', '+86', '+81']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: TextField(
                                    controller: _phoneNumberController,
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      prefixIcon: Icon(Icons.phone),
                                      hintText: 'Enter your phone number',
                                    ),
                                    keyboardType: TextInputType.phone,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            ElevatedButton(
                              onPressed: _signInWithPhone,
                              child: Text('Get OTP'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green[700], // Button color
                              ),
                            ),
                          ],
                        ),
              SizedBox(height: 20.0),
              TextButton(
                onPressed: _resetPassword,
                child: Text('Forgot Password?'),
              ),
              SizedBox(height: 10.0),
              Text(
                'Don\'t have an account?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: _navigateToRegisterScreen,
                child: Text(
                  'Register here',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _changeWelcomeMessage,
                child: Text('Change Language'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[700], // Button color
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Login with:'),
                  SizedBox(width: 10),
                  Switch(
                    value: isEmailLogin,
                    onChanged: (value) {
                      setState(() {
                        isEmailLogin = value;
                      });
                    },
                  ),
                  Text(isEmailLogin ? 'Email' : 'Phone Number'),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _signInWithEmailAndPassword,
                child: Text('Sign In'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[700], // Button color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
