import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Google SignIn"),
        ),
        body: _user == null ? _googleSignInBtn() : _userInfo());
  }

  Widget _googleSignInBtn() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.google, 
          text: "Acceder con Google",
          onPressed: _handleGoogleSignIn), 
          
        ),

      
    );
  }

  Widget _googleSignOutBtn() {
    return Center(
      child: GestureDetector(
        onTap: _auth.signOut,
        child: SizedBox(
          height: 50,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: Center(child: Text("Cerrar sesion")),
          )
        
        
            ),
      ));
  }

  void _handleGoogleSignIn(){
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_googleAuthProvider);
    } catch (e) {
      print(e);
    }
  }

  Widget _userInfo() {
    return Column(
      children: [
        Text("Bienvenido " + _user!.email!),
        _googleSignOutBtn(),

      ],
    );
  }
}
