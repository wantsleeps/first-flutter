import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/companion_model.dart';
import '../widgets/interaction_widgets.dart';
import '../widgets/glass_scaffold.dart'; // Import
import '../widgets/glass_card.dart'; // Import
import '../utils/style.dart'; // Import
import '../pages/chat_page.dart';

class CompanionDetailPage extends StatelessWidget {
  final Companion companion;

  const CompanionDetailPage({super.key, required this.companion});

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      useSafeArea: false,
      body: Stack(
        children: [
          // Content
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Image
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Scaffold(
                              backgroundColor: Colors.black,
                              body: Dismissible(
                                key: const Key('image_viewer'),
                                direction: DismissDirection.down,
                                onDismissed: (_) => Navigator.pop(context),
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Center(
                                    child: InteractiveViewer(
                                      child: Image.network(
                                        companion.avatarUrl,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Image.network(
                        companion.avatarUrl,
                        height: 450, // Taller image
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.backgroundStart.withOpacity(0.0),
                              AppColors
                                  .backgroundStart, // Blend into background? No, blend to transparent usually
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Overlapping Glass Content
                Transform.translate(
                  offset: const Offset(0, -40),
                  child: GlassCard(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    borderRadius: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(companion.name, style: AppTextStyles.header),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: companion.isOnline
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: companion.isOnline
                                      ? Colors.green.withOpacity(0.5)
                                      : Colors.grey.withOpacity(0.5),
                                ),
                              ),
                              child: Text(
                                companion.isOnline ? "在线" : "离线",
                                style: TextStyle(
                                  color: companion.isOnline
                                      ? Colors.green
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Game and Rank
                        Row(
                          children: [
                            _buildTag(
                              companion.game,
                              AppColors.primary.withOpacity(0.1),
                              AppColors.primary,
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 22,
                            ),
                            Text(
                              " ${companion.rating} (${companion.orderCount}+ 接单)",
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 14,
                                color: AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Tags
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: companion.tags
                              .map(
                                (tag) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.glassWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppColors.glassBorder,
                                    ),
                                  ),
                                  child: Text(
                                    tag,
                                    style: TextStyle(
                                      color: AppColors.textBlack.withOpacity(
                                        0.7,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 24),

                        // About Section
                        const Text("个人简介", style: AppTextStyles.subHeader),
                        const SizedBox(height: 8),
                        Text(
                          companion.description,
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textGrey,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Audio Sample (Mock)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.glassWhite,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.glassBorder),
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: AppColors.textBlack,
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: 0.3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Text(
                                "0:12",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Back Button
          Positioned(
            top: 50,
            left: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.glassWhite,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.textBlack,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
          ),

          // Bottom Bar
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              borderRadius: 30,
              color: AppColors.glassWhiteHigh, // Less transparent for contrast
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "¥${companion.price.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textBlack,
                        ),
                      ),
                      const Text(
                        "/小时",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SecondaryButton(
                    text: "私聊",
                    icon: Icons.chat_bubble_outline,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(companion: companion),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  PrimaryButton(
                    text: "立即下单",
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    onPressed: () {
                      _showBookingModal(context);
                    },
                    width: 120,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  void _showBookingModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "确认订单",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("服务项目", style: TextStyle(fontSize: 16)),
                Text(
                  "${companion.game} 陪玩",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("时长", style: TextStyle(fontSize: 16)),
                const Text(
                  "1 小时",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("合计", style: TextStyle(fontSize: 16)),
                Text(
                  "¥${companion.price.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            PrimaryButton(
              text: "确认支付",
              fullWidth: true,
              onPressed: () {
                final userProvider = Provider.of<UserProvider>(
                  context,
                  listen: false,
                );

                // Close modal first
                Navigator.pop(context);

                final success = userProvider.placeOrder(companion, 1);

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("下单成功！快去和陪玩大神聊天吧~"),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("余额不足，请先充值！"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
