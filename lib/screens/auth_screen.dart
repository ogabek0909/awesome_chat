import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthMode {
  login,
  register,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const routeName = 'auth-screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isobscure = true;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.login;

  void _onSaved() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      setState(() {
        _isLoading = true;
      });
      if (_authMode == AuthMode.login) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      }
      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Something went wrong"),
          content: Text(e.message!),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              TextFormField(
                key: UniqueKey(),
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'example@examp.com',
                  labelText: 'Email',
                ),
                validator: (value) {
                  bool isValidEmail(String email) {
                    String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                    return RegExp(emailRegex).hasMatch(email);
                  }

                  if (!isValidEmail(value!)) {
                    return 'Email is invalid, please check your email';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {},
              ),
              const SizedBox(height: 15),
              if (_authMode == AuthMode.register)
                TextFormField(
                  key: UniqueKey(),
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'example01',
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    
                    if (value!.isEmpty) {
                      return 'Please, Enter username';
                    } else if (value.length < 6) {
                      return 'Username must be at least 6 characters';
                    }  else {
                      return null;
                    }
                  },
                ),
              const SizedBox(height: 15),
              TextFormField(
                key: UniqueKey(),
                controller: _passwordController,
                obscureText: _isobscure,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please, Enter password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Kh23ja18',
                  labelText: 'Password',
                  suffix: InkWell(
                    child: Icon(
                      !_isobscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onTap: () {
                      setState(() {
                        _isobscure = !_isobscure;
                      });
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (_authMode == AuthMode.register) {
                          _authMode = AuthMode.login;
                        } else {
                          _authMode = AuthMode.register;
                        }
                      });
                    },
                    child: Text(
                      _authMode == AuthMode.login ? "Register?" : "Login?",
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _onSaved,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                      ),
                      child: Text(
                        _authMode != AuthMode.login ? "Register" : "Login",
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
