import 'package:flutter/material.dart';
import 'package:pharma_app/auth/auth_service.dart';
import 'package:pharma_app/auth/login_page.dart';
import 'package:pharma_app/auth/register_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoggedIn = false;

  String? userName;
  String? userEmail;
  //final String profileImageAsset = "assets/images/profile_p.jpg";

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
  final name = await AuthService().getName(); // prefs: 'name'
  final email = await AuthService().getUseremail(); // prefs: 'email'
  setState(() {
    userName = name;
    userEmail = email;
    isLoggedIn = (userName != null && userName!.isNotEmpty);
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: isLoggedIn ? _buildProfileView() : _buildLoginSignupView(),
    );
  }

  Widget _buildProfileView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: CircleAvatar(
            radius: 50,
           // backgroundImage: AssetImage(profileImageAsset),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                userName ?? userEmail ?? 'User',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (userEmail != null)
                Text(userEmail!, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        const Divider(height: 40),
        ListTile(
          leading: const Icon(Icons.shopping_bag),
          title: const Text("My Orders"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text("Wishlist"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text("Address Book"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Settings"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout, color: Color.fromARGB(255, 241, 20, 4)),
          title: const Text("Logout"),
          onTap: () async {
            await AuthService().logout();
            setState(() {
              isLoggedIn = false;
              userName = null;
              userEmail = null;
            });
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Logged out')));
          },
        ),
      ],
    );
  }

  Widget _buildLoginSignupView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              "Hello, Welcome to Pharma!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please login or sign up to continue",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final didLogin = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
                if (didLogin == true) {
                  await _loadUser();
                }
              },
              child: const Text("Login"),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}