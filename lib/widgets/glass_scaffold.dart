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
      backgroundColor: Colors.transparent, // 显示背景的关键
      body: Stack(
        children: [
          // 1. 混合渐变背景
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppGradients.liquidMesh,
              ),
              child: Stack(
                children: [
                  // 添加一些“有机球体”以营造流动感
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

          // 2. 主要内容
          useSafeArea
              ? SafeArea(
                  bottom: false, // 如果需要，允许内容延伸到底部导航栏下方
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
