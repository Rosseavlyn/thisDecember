import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user-provider.dart';
import 'user_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedUser = "";

  @override
  Widget build(BuildContext context) {
    final loginUsername = Provider.of<UserProvider>(context).username;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================
            // Bagian kiri atas (username login)
            // =========================
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              loginUsername,
              style: const TextStyle(fontSize: 22),
            ),

            const Spacer(),

            // =========================
            // Bagian tengah layar (Selected User)
            // =========================
            Center(
              child: Column(
                children: [
                  const Text(
                    "Selected User Name",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    selectedUser.isEmpty ? "-" : selectedUser,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // =========================
            // Tombol choose user
            // =========================
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: const Text("Choose a User"),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(const Color(0xFF006C6C)),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () async {
                  final user = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserListPage(),
                    ),
                  );

                  if (user != null) {
                    setState(() {
                      selectedUser = user; // tampil di tengah
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
