import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List users = [];
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final url = Uri.parse("https://api.reqres.in/api/users?page=1");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          users = data["data"];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Failed to load users (Status ${response.statusCode})";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error: $e";
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose a User"), centerTitle: true),

      // LOADING
      body: isLoading
          ? const Center(child: CircularProgressIndicator())

          // ERROR HANDLING
          : errorMessage.isNotEmpty
          ? Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            )

          // LIST USER
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final fullName = "${user['first_name']} ${user['last_name']}";

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user["avatar"]),
                  ),
                  title: Text(fullName),
                  subtitle: Text(user["email"]),
                  onTap: () {
                    Navigator.pop(context, fullName);
                  },
                );
              },
            ),
    );
  }
}
