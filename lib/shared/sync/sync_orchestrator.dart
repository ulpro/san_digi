import 'dart:async';

import '../vpn/vpn_manager.dart';
import '../vpn/vpn_models.dart';

typedef SyncJob = Future<void> Function();

class SyncOrchestrator {
  final VpnManager vpnManager;
  final Duration connectTimeout;
  final Duration statusTimeout;

  SyncOrchestrator({
    required this.vpnManager,
    this.connectTimeout = const Duration(seconds: 20),
    this.statusTimeout = const Duration(seconds: 6),
  });

  Future<void> runSync({
    required VpnConfig config,
    required SyncJob syncJob,
  }) async {
    final permissionGranted = await vpnManager.ensurePermission();
    if (!permissionGranted) {
      throw Exception('VPN permission denied');
    }

    final connectStatus = await vpnManager
        .connect(config)
        .timeout(
          connectTimeout,
          onTimeout: () => const VpnStatus(
            state: VpnConnectionState.failed,
            message: 'VPN connection timeout',
          ),
        );

    if (connectStatus.state != VpnConnectionState.connected) {
      throw Exception(connectStatus.message ?? 'VPN connection failed');
    }

    final tunnelStatus = await vpnManager.getStatus().timeout(
      statusTimeout,
      onTimeout: () => const VpnStatus(
        state: VpnConnectionState.failed,
        message: 'VPN status timeout',
      ),
    );

    if (tunnelStatus.state != VpnConnectionState.connected) {
      await vpnManager.disconnect();
      throw Exception(tunnelStatus.message ?? 'VPN tunnel is down');
    }

    Object? syncError;
    try {
      await syncJob();
    } catch (error) {
      syncError = error;
      rethrow;
    } finally {
      final disconnectStatus = await vpnManager.disconnect();
      if (disconnectStatus.state == VpnConnectionState.failed &&
          syncError == null) {
        throw Exception(disconnectStatus.message ?? 'VPN disconnect failed');
      }
    }
  }
}
