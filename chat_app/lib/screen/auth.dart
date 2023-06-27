import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// firebase instance 생성
final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLogin = true;

  final _formKey = GlobalKey<FormState>();

  var _enteredEmaiil = '';
  var _enteredPassword = '';

  final emailTc = TextEditingController();
  final passwordTc = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_enteredEmaiil);
      print(_enteredPassword);
    }

    if (_isLogin) {
      // login
      try {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredPassword, password: _enteredPassword);
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? 'Authentication failed')));
      }
    } else {
      // sign up
      try {
        //
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmaiil, password: _enteredPassword);
        print(userCredentials);
      } on FirebaseAuthException catch(error) {
        if (error.code == 'email-already-in-use') {
          // .. 
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? 'Authentication failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20
                ),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        // content가 필요한 만큼만 공간을 갖음
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Email Address"
                            ),
                            keyboardType: TextInputType.emailAddress,
                            // 자동 오탈자 수정 방지
                            autocorrect: false,
                            // 첫 글자 대문자로 써짐 방지
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null || value.isEmpty
                                  || !value.contains('@')) {
                                return "Please enter a valid email address";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmaiil = value!;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Password"
                            ),
                            // 입력값 숨김
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return "Password must be at least 6 characters long";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(height: 12,),
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme
                                  .primaryContainer
                            ),
                            child: Text( _isLogin ? "Login" : "Signup")
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(
                              _isLogin ? "Create an account"
                              : 'I already have an account',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}