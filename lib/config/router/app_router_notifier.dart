import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/auth/presentation/providers/auth_provider.dart';

final GoRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

class GoRouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;

  EstatusSesion _authStatus = EstatusSesion.revisando;

  GoRouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.estatusSesion;
    });
  }

  EstatusSesion get authStatus => _authStatus;

  set authStatus(EstatusSesion value) {
    _authStatus = value;
    notifyListeners();
  }
}
