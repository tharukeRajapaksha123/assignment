import 'package:assignment/controllers/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignView extends StatelessWidget {
  const SignView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          color: Colors.amber,
          onPressed: () async {
            AuthService().signinAnounimously();
          },
          child: const Text("Sign in"),
        ),
      ),
    );
  }
}
