import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:login_app/controller/phone_controller.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  String phone = "";
  bool enableOtpBtn = false;

  Future<void> getOtp() async {
    PhoneAuthController.sendOtp(context, phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Ingresa tu numero de telefono"),
        titleTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              const Text(""),
              const SizedBox(height: 30),
              InternationalPhoneNumberInput(
                hintText: "Numero de telefono",
                errorMessage: "Numero invalido",
                onInputValidated: (value) {
                  setState(() {
                    enableOtpBtn = value;
                  });
                },
                onInputChanged: (value) {
                  phone = value.phoneNumber!;
                },
                keyboardType: TextInputType.phone,
                formatInput: true,
                autoFocus: true,
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  useEmoji: true,
                ),
                inputDecoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(),
                ),
                searchBoxDecoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Buscar pais",
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: enableOtpBtn ? getOtp : null,
                  child: const Text("Enviar codigo"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}