import "package:flutter/material.dart";
import "package:memoapp/dialogs/sign_in_dialog.dart";
import "package:memoapp/dialogs/create_account_dialog.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.0,
            colors: [
              Colors.white,
              Color(0xff5debd7),
              Colors.white,
            ],
          )),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Memo App",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                child: const Text("Sign in"),
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      builder: (context) => const SignInDialog());
                },
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                child: const Text("Create account"),
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      builder: (context) => const CreateAccountDialog());
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
