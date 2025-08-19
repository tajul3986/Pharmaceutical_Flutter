import 'package:flutter/material.dart';
import 'package:pharma_app/auth/auth_service.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();


  String _selectedRole = 'user'; // default role
  bool _isLoading = false;

  List<String> roles = ['admin', 'user'];

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      bool success = await AuthService().register(
        nameController.text.trim(),
        emailController.text.trim(),
        phoneController.text.trim(),
        usernameController.text.trim(),
        passwordController.text.trim(),
        confirmPasswordController.text.trim(),
        _selectedRole,
      );

      setState(() => _isLoading = false);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Successful! Please login.')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Failed. Try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Enter email' : null,
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) => value!.isEmpty ? 'Enter phone' : null,
              ),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) => value!.isEmpty ? 'Enter username' : null,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                //validator: (value) => value!.length < 3 ? 'Min 3 characters' : null,
              ),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: InputDecoration(labelText: 'Select Role'),
                items: roles.map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role.toUpperCase()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() => _selectedRole = newValue!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _register,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Register'),
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  );
                },
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:pharma_app/auth/auth_service.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   String _selectedRole = 'USER';

//   void _register() async {
//     if (_formKey.currentState!.validate()) {
//       bool success = await AuthService().register(
//         _nameController.text.trim(),
//         _emailController.text.trim(),
//         _phoneController.text.trim(),
//         _usernameController.text.trim(),
//         _passwordController.text.trim(),
//         _confirmPasswordController.text.trim(),
//         _selectedRole,
//       );

//       if (success) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Registration successful')),
//         );
//         Navigator.pop(context); // Go back to login
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Registration failed')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Register")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(labelText: "Name"),
//                 validator: (value) => value!.isEmpty ? 'Enter name' : null,
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(labelText: "Email"),
//                 validator: (value) => value!.isEmpty ? 'Enter email' : null,
//               ),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: const InputDecoration(labelText: "Phone"),
//                 validator: (value) => value!.isEmpty ? 'Enter phone' : null,
//               ),
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: const InputDecoration(labelText: "Username"),
//                 validator: (value) => value!.isEmpty ? 'Enter username' : null,
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: const InputDecoration(labelText: "Password"),
//                 obscureText: true,
//                 validator: (value) => value!.length < 6 ? 'Min 6 chars' : null,
//               ),
//               TextFormField(
//                 controller: _confirmPasswordController,
//                 decoration: const InputDecoration(labelText: "Confirm Password"),
//                 obscureText: true,
//                 validator: (value) =>
//                     value != _passwordController.text ? 'Passwords don\'t match' : null,
//               ),
//               const SizedBox(height: 10),
//               DropdownButtonFormField<String>(
//                 value: _selectedRole,
//                 decoration: const InputDecoration(labelText: "Select Role"),
//                 items: const [
//                   DropdownMenuItem(value: "USER", child: Text("User")),
//                   DropdownMenuItem(value: "ADMIN", child: Text("Admin")),
//                 ],
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedRole = value!;
//                   });
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _register,
//                 child: const Text("Register"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }