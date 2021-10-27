import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key, required this.submitFn}) : super(key: key);

  final void Function(
    String email,
    String username,
    String password,
    bool isLogin,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _email = '';
  String _username = '';
  String _password = '';

  void _trySubmit() {
    if (_formKey.currentState == null) return;
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
    }
    widget.submitFn(_email, _username, _password, _isLogin);
    print(_email.replaceAll(' ', ''));
    print(_username.replaceAll(' ', ''));
    print(_password.replaceAll(' ', ''));
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
                  ElevatedButton(
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                    onPressed: _trySubmit,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle()
                            .copyWith(color: Theme.of(context).primaryColor)),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
