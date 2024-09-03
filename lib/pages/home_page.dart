import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_app/pages/phone_page.dart';
import 'package:sign_in_button/sign_in_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool isSigningIn =
      false; // Bandera para controlar el estado de inicio de sesión

  @override
  void initState() {
    super.initState();
    initialization();
    _listenToAuthState();
  }

  void _listenToAuthState() {
    _auth.authStateChanges().listen((user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google SignIn"),
      ),
      body: _user == null ? _buildSignInWidget() : _buildUserInfo(),
    );
  }

  Widget _buildSignInWidget() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: SignInButton(
              Buttons.google,
              text: isSigningIn ? "Iniciando sesión..." : "Acceder con Google",
              onPressed: isSigningIn
                  ? () => {}
                  : _handleGoogleSignIn, // Deshabilita el botón si ya está iniciando sesión
            ),
          ),

          SizedBox(
            height: 50,
            child: SignInButton(
              Buttons.email,
              text: "Acceder con telefono",
              onPressed: isSigningIn
                  ? () => {}
                  :() => Navigator.push(context, MaterialPageRoute(builder: (context) => const PhonePage())), // Deshabilita el botón si ya está iniciando sesión
            ),
          ),


        ],
      ),
    );
  }

  Widget _buildSignOutButton() {
    return GestureDetector(
      onTap: _handleSignOut,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(child: Text("Cerrar sesión")),
      ),
    );
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      isSigningIn =
          true; // Marca que la operación de inicio de sesión está en curso
    });

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('Error al iniciar sesión: $e');
    } finally {
      setState(() {
        isSigningIn =
            false; // Restablece la bandera después de completar la operación
      });
    }
  }

  Future<void> _handleSignOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error al cerrar sesión: $e');
    }
  }

  Widget _buildUserInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Bienvenido, ${_user?.email ?? 'Usuario'}"),
        const SizedBox(height: 20),
        _buildSignOutButton(),
      ],
    );
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }
}
