import 'vpn_models.dart';

abstract class VpnManager {
  Future<bool> ensurePermission();
  Future<VpnStatus> connect(VpnConfig config);
  Future<VpnStatus> disconnect();
  Future<VpnStatus> getStatus();
}
