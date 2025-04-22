import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/core/common/localization.dart';
import 'package:story_app/core/constants/app_route_name.dart';
import 'package:story_app/core/widgets/custom_text_field.dart';
import 'package:story_app/features/auth/provider/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final localization = AppLocalizations.of(context);
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
                      Text(
                        localization!.welcomeBack,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3C78D8),
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        label: 'Email',
                        icon: Icons.email,
                        onChanged: authProvider.setEmail,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Password',
                        icon: Icons.lock,
                        obscureText: true,
                        onChanged: authProvider.setPassword,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child:
                            authProvider.isLoading
                                ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                                : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3C78D8),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await authProvider.login(context);
                                    if (authProvider.loginResult != null) {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AppRouteName.home,
                                        (Route<dynamic> route) => false,
                                      );
                                    } else if (authProvider.error != null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(authProvider.error!),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    localization.login,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () {
                          // Aksi lupa password
                        },
                        child: Text(localization.forgotPassword),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(localization.dontHaveAccount),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRouteName.register,
                              );
                            },
                            child: Text(
                              localization.register,
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
