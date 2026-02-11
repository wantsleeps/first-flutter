import 'package:flutter/material.dart';
import 'package:hello_flutter/utils/style.dart';

class GlassScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool useSafeArea;

  const GlassScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.extendBody = true,
    this.extendBodyBehindAppBar = true,
    this.useSafeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: appBar,
      backgroundColor: Colors.transparent, // Important for background to show
      body: Stack(
        children: [
          // 1. Mesh Gradient Background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppGradients.liquidMesh,
              ),
              child: Stack(
                children: [
                  // Add some "Organic Orbs" for the liquid feel
                  Positioned(
                    top: -100,
                    right: -100,
                    child: _buildOrb(300, const Color(0xFFCBF0FF)),
                  ),
                  Positioned(
                    bottom: 100,
                    left: -50,
                    child: _buildOrb(200, const Color(0xFFF3E2FF)),
                  ),
                ],
              ),
            ),
          ),

          // 2. Main Content
          useSafeArea
              ? SafeArea(
                  bottom: false, // Let content flow behind bottom nav if needed
                  child: body,
                )
              : body,
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  Widget _buildOrb(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.6),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 60,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }
}
