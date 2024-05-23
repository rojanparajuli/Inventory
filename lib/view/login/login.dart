import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/controller/login_controller.dart';
import 'package:inventory/view/home/inventory_screen.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final LoginController loginController = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Obx(
                () => TextFormField(
                  obscureText: loginController.obscureText.value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        loginController.obscureText.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: loginController.togglePasswordVisibility,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                   Get.to(()=>InventoryPage());
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 16.0),
              const Text('or'),
              const SizedBox(height: 16.0),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle Google login
                },
                icon: Image.asset('assets/Google.png', height: 24.0),
                label: const Text('Continue with Google'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle Facebook login
                },
                icon: Image.asset('assets/Facebook.png', height: 24.0),
                label: const Text('Continue with Facebook'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}