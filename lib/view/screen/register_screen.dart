import 'package:ecommerce/controller/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/utility/app_routes.dart';
import 'package:ecommerce/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    // Email/Phone field
                    PaymentTextField(
                      validator: _validateEmail,
                      controller: _usernameController,
                      title: "Email",
                      hintText: "e.g. contact@kgharib.com",
                      icon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 16),
                    PaymentTextField(
                      validator: _validatePassword,
                      controller: _passwordController,
                      title: "Password",
                      hintText: "Enter your password",
                      icon: Icons.password,
                      // obscureText: true,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.login,
                          ModalRoute.withName('/'),
                        );
                      },
                      child: Text("Already have an account?"),
                    ),
                    const SizedBox(height: 24),
                    // Create Account button
                    BlocConsumer<AuthCubit, AuthState>(
                      bloc: authCubit,
                      buildWhen:
                          (previous, current) =>
                              current is AuthLoading ||
                              current is AuthError ||
                              current is AuthInitial,
                      listener: (context, state) {
                        if (state is AuthAuthenticated) {
                          Navigator.of(context).pushNamed(AppRoutes.homeRoute);
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthError) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage)),
                            );
                          });
                        }
                        if (state is AuthLoading) {
                          return SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5C4FE1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          );
                        }
                        return SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await authCubit.signUp(
                                  _usernameController.text,
                                  _passwordController.text,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5C4FE1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Create Account',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Or using other method text
              Center(
                child: Text(
                  'Or using other method',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              const SizedBox(height: 16),
              // Social login buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      // icon: Image.asset('assets/icon/google.png', height: 24),
                      label: const Text('Sign Up with Google'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      // icon: Image.asset('assets/icon/facebook.png', height: 24),
                      label: const Text('Sign Up with Facebook'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
