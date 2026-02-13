import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/style.dart';

class LiquidBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const LiquidBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30), // 底部内边距，营造浮动效果
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 70, // 增加高度以优化触摸目标
            decoration: BoxDecoration(
              color: AppColors.glassWhiteHigh,
              borderRadius: BorderRadius.circular(35),
              border: Border.all(
                color: AppColors.glassBorder.withOpacity(0.5),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double itemWidth = constraints.maxWidth / 3;
                const double indicatorHeight = 50;
                const double indicatorWidth = 70; // “扁平”水滴宽度

                return Stack(
                  children: [
                    // “扁平水滴”指示器
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 1500),
                      curve: const ElasticOutCurve(0.85), // 更慢、更平滑的回弹效果
                      left:
                          (currentIndex * itemWidth) +
                          (itemWidth - indicatorWidth) / 2,
                      top: (70 - indicatorHeight) / 2,
                      child: Container(
                        width: indicatorWidth,
                        height: indicatorHeight,
                        decoration: BoxDecoration(
                          gradient: AppGradients.waterDrop,
                          borderRadius: BorderRadius.circular(25), // 胶囊形状
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF66A6FF).withOpacity(0.4),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 图标层
                    Row(
                      children: [
                        _buildNavItem(
                          0,
                          Icons.home_rounded,
                          Icons.home_outlined,
                          itemWidth,
                        ),
                        _buildNavItem(
                          1,
                          Icons.chat_bubble_rounded,
                          Icons.chat_bubble_outline,
                          itemWidth,
                        ),
                        _buildNavItem(
                          2,
                          Icons.person_rounded,
                          Icons.person_outline,
                          itemWidth,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData activeIcon,
    IconData inactiveIcon,
    double width,
  ) {
    final bool isSelected = currentIndex == index;
    return SizedBox(
      width: width,
      height: 70,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Icon(
              isSelected ? activeIcon : inactiveIcon,
              key: ValueKey<bool>(isSelected),
              color: isSelected ? Colors.white : AppColors.textGrey,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
