import 'dart:io';

import 'package:flutter/material.dart';

import '../pickers/user_image_picker.dart';

// ignore: must_be_immutable
class AuthForm extends StatefulWidget {
  AuthForm({Key? key, required this.submitFn, required this.isLoading})
      : super(key: key);

  final void Function(
    String email,
    String username,
    String password,
    File userImageFile,
    bool isLogin,
  ) submitFn;

  bool isLoading;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _email = '';
  String _username = '';
  String _password = '';
  File? _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    if (_formKey.currentState == null) return;
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please pick an image.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _email.replaceAll(' ', ''),
        _username.replaceAll(' ', ''),
        _password.replaceAll(' ', ''),
        _userImageFile!,
        _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) UserImagePicker(imagePickFn: _pickedImage),
                  TextFormField(
                    key: const ValueKey('email'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Please enter a valid email address!';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => _email = value!,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                    ),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Username'),
                      key: const ValueKey('username'),
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 4) {
                          return 'Please enter at least 4 characters!';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) => _username = value!,
                    ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    key: const ValueKey('password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long!';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => _password = value!,
                  ),
                  const SizedBox(height: 12),
                  widget.isLoading
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            ElevatedButton(
                              child: Text(_isLogin ? 'Login' : 'Signup'),
                              onPressed: _trySubmit,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  textStyle: const TextStyle().copyWith(
                                      color: Theme.of(context).primaryColor)),
                              child: Text(_isLogin
                                  ? 'Create new account'
                                  : 'I already have an account'),
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                            )
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
