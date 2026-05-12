enum VpnConnectionState {
  disconnected,
  connecting,
  connected,
  disconnecting,
  failed,
}

class VpnConfig {
  final String interfacePrivateKey;
  final String interfaceAddress;
  final String peerPublicKey;
  final String endpoint;
  final String allowedIps;
  final int persistentKeepalive;

  const VpnConfig({
    required this.interfacePrivateKey,
    required this.interfaceAddress,
    required this.peerPublicKey,
    required this.endpoint,
    required this.allowedIps,
    this.persistentKeepalive = 25,
  });

  Map<String, dynamic> toMap() {
    return {
      'interfacePrivateKey': interfacePrivateKey,
      'interfaceAddress': interfaceAddress,
      'peerPublicKey': peerPublicKey,
      'endpoint': endpoint,
      'allowedIps': allowedIps,
      'persistentKeepalive': persistentKeepalive,
    };
  }
}

class VpnStatus {
  final VpnConnectionState state;
  final String? message;

  const VpnStatus({required this.state, this.message});
}
