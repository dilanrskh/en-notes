import 'package:ennotes/pages/home_page.dart';
import 'package:ennotes/utils/user_shared_preferences.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController nameController;
  late TextEditingController pinController;
  bool isPinExist = false;
  String? _pin;

  @override
  void initState() {
    nameController = TextEditingController();
    pinController = TextEditingController();
    String? pin = UserSharedPreferences.getPin();
    if (pin != null) {
      setState(() {
        isPinExist = true;
        _pin = pin;
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                '🍁 EN-NOTES 🍁',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Nickname',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 42),
              child: TextField(
                autofocus: true,
            
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.all(0),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const Text(
              'PIN',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 42),
              child: TextField(
                controller: pinController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.all(0),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) => Colors.orangeAccent),
              ),
              onPressed: () async {
                await UserSharedPreferences.setName(
                  name: nameController.text,
                  pin: pinController.text,
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const HomePage();
                    },
                  ),
                );
              },
              child: const Text(
                'Masuk',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
