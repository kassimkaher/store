import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_web/utils/injector/injector.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

/// Example page showing how to use AuthCubit with Freezed state
class AuthExamplePage extends StatelessWidget {
  const AuthExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AuthCubit>()..loadAuthData(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Auth Example')),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return state.when(
              initial: (data, loading, errorMessage) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not initialized',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthCubit>().loadAuthData();
                        },
                        child: const Text('Load Auth Data'),
                      ),
                    ],
                  ),
                );
              },
              loading: (data, loading, errorMessage) {
                return const Center(child: CircularProgressIndicator());
              },
              authenticated: (data, loading, errorMessage) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Authentication Data',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _InfoCard(
                        title: 'User Information',
                        children: [
                          _InfoRow('ID', data.id),
                          _InfoRow('Name', data.name),
                          _InfoRow('Email', data.email),
                          _InfoRow('Phone', data.phone),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _InfoCard(
                        title: 'Store Information',
                        children: [
                          _InfoRow('Store Name', data.storeName),
                          _InfoRow('Store ID', data.storeId),
                          _InfoRow('Store URL', data.storeUrl),
                          _InfoRow('Store Logo', data.storeLogo),
                          _InfoRow('Content URL', data.contentUrl),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _InfoCard(
                        title: 'Token',
                        children: [_InfoRow('Token', data.token)],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthCubit>().logout();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Logout'),
                        ),
                      ),
                    ],
                  ),
                );
              },
              error: (data, loading, errorMessage) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error: $errorMessage',
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthCubit>().loadAuthData();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              },
              unauthenticated: (data, loading, errorMessage) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not authenticated',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthCubit>().loadAuthData();
                        },
                        child: const Text('Load Auth Data'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _InfoCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
