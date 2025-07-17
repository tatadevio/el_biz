import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/network_check_controller.dart';

class ConnectivityBanner extends StatefulWidget {
  const ConnectivityBanner({super.key});

  @override
  State<ConnectivityBanner> createState() => _ConnectivityBannerState();
}

class _ConnectivityBannerState extends State<ConnectivityBanner>
    with SingleTickerProviderStateMixin {
  final NetworkCheckController _controller = Get.put(NetworkCheckController());
  // bool _showOnline = false;
  bool _hasDisconnected = false;
  bool _visible = false;
  String? _currentMessage;
  Color? _currentColor;
  IconData? _currentIcon;

  @override
  void initState() {
    super.initState();
    _controller.networkStatus.listen((status) {
      if (status == NetworkStatus.disconnected && mounted) {
        _hasDisconnected = true;
        _showBanner('no_internet_connection'.tr, Colors.red, Icons.wifi_off);
      }
      if (status == NetworkStatus.connected && mounted && _hasDisconnected) {
        _showBanner('back_online'.tr, Colors.green, Icons.wifi);
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _visible = false;
            });
          }
        });
      }
      if (status == NetworkStatus.connected && !_hasDisconnected) {
        // Hide banner if showing on first launch
        setState(() {
          _visible = false;
        });
      }
    });
  }

  void _showBanner(String message, Color color, IconData icon) {
    setState(() {
      _currentMessage = message;
      _currentColor = color;
      _currentIcon = icon;
      _visible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      offset: _visible ? Offset.zero : const Offset(0, -1),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 350),
        opacity: _visible ? 1.0 : 0.0,
        child: (_currentMessage != null && _visible)
            ? _buildBanner(
                context,
                _currentMessage!,
                _currentColor!,
                _currentIcon!,
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildBanner(
      BuildContext context, String message, Color color, IconData icon) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: color,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12, // Reduced font size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
