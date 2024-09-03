
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:login_app/pages/home_page.dart';
import '../pages/verify_otp_page.dart';

class PhoneAuthController {
  static final _auth = FirebaseAuth.instance;

  static Future<void> sendOtp(BuildContext context, String phoneNumber, {int? forceResendingToken}) async {
    try {
      context.loaderOverlay.show();
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        forceResendingToken: forceResendingToken,
        codeSent: (verificationId, x) {
          context.loaderOverlay.hide();

          if (forceResendingToken == null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyOtpPage(
                  phone: phoneNumber,
                  verificationId: verificationId,
                  forceResendingToken: x,
                ),
              ),
            );
          }
        },
        verificationCompleted: (phoneAuthCredential) async {
          final smsCode = phoneAuthCredential.smsCode;
          print("Verification completed $smsCode");
        },
        verificationFailed: (error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentMaterialBanner()
            ..showSnackBar(SnackBar(content: Text("${error.message}")));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(SnackBar(content: Text("${e.message}")));
        print(e);
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("${e.toString()}")));
    } finally {
      context.loaderOverlay.hide();
    }
  }

  static Future<void> logout(BuildContext context) async {
    try {
      context.loaderOverlay.show();
      await _auth.signOut();
      if (!context.mounted) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("${e.toString()}")));
    } finally {
      context.loaderOverlay.hide();
    }
  }

  static Future<void> verifyOtp(
      {required BuildContext context, required String otp, required String verificationId}) async {
    try {
      context.loaderOverlay.show();
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      if (!context.mounted) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("${e.toString()}")));
    } finally {
      context.loaderOverlay.hide();
    }
  }
}