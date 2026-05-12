package com.example.san_digi

import android.content.Intent
import android.net.VpnService
import android.os.IBinder
import android.os.ParcelFileDescriptor
import java.io.IOException

class WireGuardVpnService : VpnService() {
    private var vpnInterface: ParcelFileDescriptor? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_CONNECT -> connect(
                interfaceAddress = intent.getStringExtra("interfaceAddress"),
                allowedIps = intent.getStringExtra("allowedIps"),
                endpoint = intent.getStringExtra("endpoint"),
            )

            ACTION_DISCONNECT -> disconnect("VPN disconnected")
        }
        return START_STICKY
    }

    override fun onBind(intent: android.content.Intent?): IBinder? {
        return super.onBind(intent)
    }

    override fun onDestroy() {
        disconnect("VPN service destroyed")
        super.onDestroy()
    }

    private fun connect(interfaceAddress: String?, allowedIps: String?, endpoint: String?) {
        synchronized(lock) {
            currentState = "connecting"
            lastMessage = "Starting VPN tunnel"

            try {
                if (vpnInterface != null) {
                    closeTunnel()
                }

                val builder = Builder()
                    .setSession("SanDigi VPN")
                    .setMtu(1280)

                val parsedAddress = parseAddress(interfaceAddress)
                builder.addAddress(parsedAddress.first, parsedAddress.second)

                val routes = parseAllowedIps(allowedIps)
                if (routes.isEmpty()) {
                    builder.addRoute("0.0.0.0", 0)
                } else {
                    routes.forEach { route ->
                        builder.addRoute(route.first, route.second)
                    }
                }

                vpnInterface = builder.establish()
                if (vpnInterface == null) {
                    currentState = "failed"
                    lastMessage = "Unable to establish VPN interface"
                    return
                }

                currentState = "connected"
                lastMessage = "Tunnel established${endpoint?.let { " ($it)" } ?: ""}"
            } catch (error: Exception) {
                closeTunnel()
                currentState = "failed"
                lastMessage = error.message ?: "VPN connection failed"
            }
        }
    }

    private fun disconnect(message: String) {
        synchronized(lock) {
            currentState = "disconnecting"
            closeTunnel()
            currentState = "disconnected"
            lastMessage = message
            stopSelf()
        }
    }

    private fun closeTunnel() {
        try {
            vpnInterface?.close()
        } catch (_: IOException) {
        } finally {
            vpnInterface = null
        }
    }

    private fun parseAddress(rawAddress: String?): Pair<String, Int> {
        val defaultAddress = "10.7.0.2/32"
        val value = if (rawAddress.isNullOrBlank()) defaultAddress else rawAddress.trim()
        val parts = value.split("/")
        val ip = parts.firstOrNull().orEmpty().ifBlank { "10.7.0.2" }
        val prefix = parts.getOrNull(1)?.toIntOrNull() ?: 32
        return ip to prefix
    }

    private fun parseAllowedIps(rawAllowedIps: String?): List<Pair<String, Int>> {
        if (rawAllowedIps.isNullOrBlank()) return emptyList()

        return rawAllowedIps
            .split(",")
            .map { it.trim() }
            .filter { it.isNotBlank() }
            .mapNotNull { entry ->
                val parts = entry.split("/")
                val ip = parts.firstOrNull()?.trim().orEmpty()
                val prefix = parts.getOrNull(1)?.trim()?.toIntOrNull()
                if (ip.isBlank() || prefix == null) {
                    null
                } else {
                    ip to prefix
                }
            }
    }

    companion object {
        const val ACTION_CONNECT = "com.example.san_digi.VPN_CONNECT"
        const val ACTION_DISCONNECT = "com.example.san_digi.VPN_DISCONNECT"

        @Volatile
        var currentState: String = "disconnected"

        @Volatile
        var lastMessage: String? = "VPN idle"

        private val lock = Any()
    }
}
