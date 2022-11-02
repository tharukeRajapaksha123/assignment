import 'package:assignment/providers/auth_provider.dart';
import 'package:assignment/views/auth/sign_view.dart';
import 'package:assignment/views/home/home_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);
    return _authState.when(
      data: (data) {
        if (data != null) return const HomeView();
        return const SignView();
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, trace) => Center(
        child: Text(
          e.toString(),
        ),
      ),
    );
  }
}
