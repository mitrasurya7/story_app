import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/core/constants/app_route_name.dart';
import 'package:story_app/core/widgets/custom_text_field.dart';
import 'package:story_app/features/auth/provider/register_auth_provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterAuthProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D9EEB), Color(0xFF3C78D8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3C78D8),
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        label: 'Username',
                        icon: Icons.person,
                        onChanged: registerProvider.setUsername,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Email',
                        icon: Icons.email,
                        onChanged: registerProvider.setEmail,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Password',
                        icon: Icons.lock,
                        obscureText: true,
                        onChanged: registerProvider.setPassword,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Confirm Password',
                        icon: Icons.lock_outline,
                        obscureText: true,
                        onChanged: registerProvider.setPasswordRepeat,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3C78D8),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            await registerProvider.register(context);
                            if (registerProvider.error != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(registerProvider.error!),
                                ),
                              );
                            } else if (registerProvider.responseModel != null) {
                              Navigator.popAndPushNamed(
                                context,
                                AppRouteName.login,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    registerProvider.responseModel!.message,
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
