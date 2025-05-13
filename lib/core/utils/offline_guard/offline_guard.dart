import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class OfflineGuard extends StatefulWidget {
  final Widget homePage;
  final Widget downloadPage;

  const OfflineGuard({
    super.key,
    required this.homePage,
    required this.downloadPage,
  });

  @override
  State<OfflineGuard> createState() => _OfflineGuardState();
}

class _OfflineGuardState extends State<OfflineGuard> {
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkInitialConnection();

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      final connected = results.any((r) => r != ConnectivityResult.none);

      if (connected != _isConnected) {
        setState(() {
          _isConnected = connected;
        });
      }
    });
  }

  Future<void> _checkInitialConnection() async {
    final results = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = results.any((r) => r != ConnectivityResult.none);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isConnected ? widget.homePage : widget.downloadPage;
  }
}
