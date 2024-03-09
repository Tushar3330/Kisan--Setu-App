import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _cropDetailsController = TextEditingController();
  File? _image;

  Future<void> _registerWithEmailAndPassword() async {
    try {
      UserCredential userCredential;

      if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
        // Register with email and password
        userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } else if (_phoneNumberController.text.isNotEmpty) {
        // Register with phone number (optional: add verification logic here)
        // For now, simply sign in with phone number without verification
        userCredential = (await FirebaseAuth.instance.signInWithPhoneNumber(_phoneNumberController.text)) as UserCredential;
      } else {
        // Handle empty fields
        return;
      }

      // Save user registration information to Firebase Realtime Database
      final databaseReference = FirebaseDatabase.instance.reference().child('users').child(userCredential.user!.uid);
      final userData = {
        'email': _emailController.text,
        'phoneNumber': _phoneNumberController.text,
        'username': _usernameController.text,
        'farmName': _farmNameController.text,
        'location': _locationController.text,
        'cropDetails': _cropDetailsController.text,
      };

      // Add photoURL if available
      if (_image != null) {
        final Reference storageReference = FirebaseStorage.instance.ref().child('user_photos/${userCredential.user!.uid}');
        await storageReference.putFile(_image!);
        String photoURL = await storageReference.getDownloadURL();
        userData['photoURL'] = photoURL;
      }

      await databaseReference.set(userData);

      // Navigate back to the login screen upon successful registration
      Navigator.pop(context); // Go back to the previous screen (login screen)
    } catch (error) {
      print('Error registering user: $error');
      // Handle registration errors here
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register as Farmer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Choose an option'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              _pickImage(ImageSource.gallery);
                              Navigator.pop(context);
                            },
                            child: Text('Pick from Gallery'),
                          ),
                          TextButton(
                            onPressed: () {
                              _pickImage(ImageSource.camera);
                              Navigator.pop(context);
                            },
                            child: Text('Take a Photo'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null ? Icon(Icons.camera_alt) : null,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _farmNameController,
                decoration: InputDecoration(labelText: 'Farm Name'),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _cropDetailsController,
                decoration: InputDecoration(labelText: 'Crop Details'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _registerWithEmailAndPassword,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
