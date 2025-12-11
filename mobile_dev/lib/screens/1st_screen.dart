import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user-provider.dart';
import '../providers/palindrome-provider.dart';
import '2nd_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameText = TextEditingController();
  TextEditingController palindromeText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);
    final palindromeProv = Provider.of<PalindromeProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   //title: const Text("Palindrome Check"),
      // ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // <— ini penting!
                crossAxisAlignment:
                    CrossAxisAlignment.center, // <— optional, biar rapi
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/images/profile-icon.png'),
                  ),

                  const SizedBox(height: 60),

                  TextField(
                    controller: usernameText,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Username',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: palindromeText,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Palindrome',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),

                  const SizedBox(height: 45),

                  SizedBox(
                    height: 50,
                    width: 450,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          const Color(0xFF006C6C),
                        ), // dark tosca
                        foregroundColor: WidgetStateProperty.all(
                          Colors.white,
                        ), // warna teks
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      child: const Text("CHECK"),
                      onPressed: () {
                        bool result = palindromeProv.checkPalindrome(
                          palindromeText.text,
                        );

                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(
                              result ? "Palindrome" : "Not Palindrome",
                            ),
                            content: Text(
                              '"${palindromeText.text}" is ${result ? "" : "not "}a palindrome',
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    height: 50,
                    width: 450,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          const Color(0xFF006C6C),
                        ), // dark tosca
                        foregroundColor: WidgetStateProperty.all(
                          Colors.white,
                        ), // warna teks
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      child: const Text("NEXT"),
                      onPressed: () {
                        if (usernameText.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (_) => const AlertDialog(
                              title: Text("Username Required"),
                              content: Text("Please enter a username first."),
                            ),
                          );
                          return;
                        }

                        userProv.setUsername(usernameText.text);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// // =================== HOME PAGE ===================

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final username = Provider.of<UserProvider>(context).username;

//     return Scaffold(
//       appBar: AppBar(title: const Text("Home Page")),
//       body: Center(
//         child: Text("Hello, $username!", style: const TextStyle(fontSize: 22)),
//       ),
//     );
//   }
// }
