import 'dart:async';

import 'package:flutter/services.dart';

import 'vpn_manager.dart';
import 'vpn_models.dart';

class MethodChannelVpnManager implements VpnManager {
  static const MethodChannel _channel = MethodChannel('san_digi/vpn');
  static const Duration _platformTimeout = Duration(seconds: 15);

  @override
  Future<bool> ensurePermission() async {
    try {
      final granted = await _channel
          .invokeMethod<bool>('prepareVpnPermission')
          .timeout(_platformTimeout);
      return granted ?? false;
    } on TimeoutException {
      return false;
    } on PlatformException {
      return false;
    }
  }

  @override
  Future<VpnStatus> connect(VpnConfig config) async {
    try {
      final connected = await _channel
          .invokeMethod<bool>('connectVpn', config.toMap())
          .timeout(_platformTimeout);

      if (connected == true) {
        return const VpnStatus(state: VpnConnectionState.connected);
      }
      return const VpnStatus(
        state: VpnConnectionState.failed,
        message: 'Native VPN connection failed',
      );
    } on PlatformException catch (error) {
      return VpnStatus(
        state: VpnConnectionState.failed,
        message: error.message ?? 'VPN connect error',
      );
    } on TimeoutException {
      return const VpnStatus(
        state: VpnConnectionState.failed,
        message: 'VPN connect timeout',
      );
    }
  }

  @override
  Future<VpnStatus> disconnect() async {
    try {
      final disconnected = await _channel
          .invokeMethod<bool>('disconnectVpn')
          .timeout(_platformTimeout);
      if (disconnected == true) {
        return const VpnStatus(state: VpnConnectionState.disconnected);
      }
      return const VpnStatus(
        state: VpnConnectionState.failed,
        message: 'Native VPN disconnection failed',
      );
    } on PlatformException catch (error) {
      return VpnStatus(
        state: VpnConnectionState.failed,
        message: error.message ?? 'VPN disconnect error',
      );
    } on TimeoutException {
      return const VpnStatus(
        state: VpnConnectionState.failed,
        message: 'VPN disconnect timeout',
      );
    }
  }

  @override
  Future<VpnStatus> getStatus() async {
    try {
      final result = await _channel
          .invokeMethod<Map<dynamic, dynamic>>('vpnStatus')
          .timeout(_platformTimeout);

      final rawState = (result?['state'] as String?) ?? 'disconnected';
      final message = result?['message'] as String?;

      return VpnStatus(state: _mapState(rawState), message: message);
    } on PlatformException catch (error) {
      return VpnStatus(
        state: VpnConnectionState.failed,
        message: error.message ?? 'VPN status error',
      );
    } on TimeoutException {
      return const VpnStatus(
        state: VpnConnectionState.failed,
        message: 'VPN status timeout',
      );
    }
  }

  VpnConnectionState _mapState(String rawState) {
    switch (rawState) {
      case 'connecting':
        return VpnConnectionState.connecting;
      case 'connected':
        return VpnConnectionState.connected;
      case 'disconnecting':
        return VpnConnectionState.disconnecting;
      case 'failed':
        return VpnConnectionState.failed;
      case 'disconnected':
      default:
        return VpnConnectionState.disconnected;
    }
  }
}
