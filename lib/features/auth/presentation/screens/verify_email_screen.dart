import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  Future<void> _reloadUser(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      // This will trigger auth state changes in AuthBloc
    }
  }

  Future<void> _resendEmail(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification email sent!')),
        );
      }
    }
  }

  Future<void> _signOut(BuildContext context) async {
    context.read<AuthBloc>().add(const SignOutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          // Router will handle redirect to login
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Verify Email'),
          actions: [
            TextButton(
              onPressed: () => _signOut(context),
              child: const Text('Sign Out'),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.email_outlined,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 24),
                Text(
                  'Verify Your Email',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'We\'ve sent a verification email to your email address. Please check your inbox and click the verification link to continue.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _reloadUser(context),
                    child: const Text('I\'ve Verified My Email'),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => _resendEmail(context),
                  child: const Text('Resend Verification Email'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
