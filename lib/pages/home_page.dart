import 'package:flutter/material.dart';
import '../models/companion_model.dart';
import '../widgets/companion_card.dart';
import '../widgets/glass_card.dart'; // Import GlassCard
import '../utils/style.dart'; // Import Styles

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ["全部", ...MockData.games];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // Filter companions based on selection and search query
    final filteredCompanions = MockData.companions.where((c) {
      final matchesCategory =
          _selectedCategoryIndex == 0 ||
          c.game == _categories[_selectedCategoryIndex];
      final matchesSearch =
          _searchQuery.isEmpty ||
          c.name.contains(_searchQuery) ||
          c.game.contains(_searchQuery);
      return matchesCategory && matchesSearch;
    }).toList();

    return Column(
      children: [
        // Header / Search using GlassCard
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: GlassCard(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  borderRadius: 30,
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: AppColors.textGrey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          style: AppTextStyles.body,
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "搜索陪玩大神...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: AppColors.textGrey),
                            contentPadding:
                                EdgeInsets.zero, // Align text vertically
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Filter Button
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  gradient: AppGradients.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(Icons.tune, color: Colors.white, size: 24),
              ),
            ],
          ),
        ),

        // Categories Horizontal List
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedCategoryIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.glassWhite,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : AppColors.glassBorder,
                      width: 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      _categories[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Companion List
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              16,
              8,
              16,
              100,
            ), // padding for bottom nav
            itemCount: filteredCompanions.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return CompanionCard(companion: filteredCompanions[index]);
            },
          ),
        ),
      ],
    );
  }
}
