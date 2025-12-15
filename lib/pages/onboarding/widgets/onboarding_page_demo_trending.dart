import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
import 'package:hub_finder/pages/onboarding/widgets/onboarding_demo_container.dart';

class OnboardingPageDemoTrending extends StatelessWidget {
  final OnboardingController controller;

  const OnboardingPageDemoTrending({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingDemoContainer(
      controller: controller,
      headline: "Never Miss What's Hot",
      benefitCopy: "Discover trending repos and developers daily",
      bottomText: "Stay ahead of the curve",
      currentPage: 3,
      totalPages: 9,
      demoWidget: const _TrendingDemoWidget(),
    );
  }
}

class _TrendingDemoWidget extends StatelessWidget {
  const _TrendingDemoWidget();

  static const List<_MockUser> _mockUsers = [
    _MockUser(name: 'sindresorhus', color: Color(0xFF6366F1)),
    _MockUser(name: 'tj', color: Color(0xFF10B981)),
    _MockUser(name: 'yyx990803', color: Color(0xFFF59E0B)),
    _MockUser(name: 'gaearon', color: Color(0xFFEF4444)),
  ];

  static const List<_MockRepo> _mockRepos = [
    _MockRepo(
      name: 'next.js',
      description: 'The React Framework',
      language: 'TypeScript',
      languageColor: Color(0xFF3178C6),
      stars: '126k',
    ),
    _MockRepo(
      name: 'rust',
      description: 'A language for everyone',
      language: 'Rust',
      languageColor: Color(0xFFDEA584),
      stars: '98k',
    ),
    _MockRepo(
      name: 'flutter',
      description: 'Build beautiful apps',
      language: 'Dart',
      languageColor: Color(0xFF00B4AB),
      stars: '166k',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Trending Users"),
          const SizedBox(height: 12),
          _buildUsersGrid(),
          const SizedBox(height: 20),
          _buildSectionTitle("Trending Repos"),
          const SizedBox(height: 12),
          _buildReposList(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade700,
      ),
    ).animate().fadeIn(delay: const Duration(milliseconds: 200));
  }

  Widget _buildUsersGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        final user = _mockUsers[index];
        return _buildUserCard(user, index);
      }),
    );
  }

  Widget _buildUserCard(_MockUser user, int index) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: user.color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: user.color, width: 2),
          ),
          child: Center(
            child: Text(
              user.name[0].toUpperCase(),
              style: TextStyle(
                color: user.color,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          user.name,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    )
        .animate(delay: Duration(milliseconds: 300 + (index * 100)))
        .fadeIn()
        .scale(begin: const Offset(0.8, 0.8));
  }

  Widget _buildReposList() {
    return Column(
      children: List.generate(_mockRepos.length, (index) {
        return _buildRepoItem(_mockRepos[index], index);
      }),
    );
  }

  Widget _buildRepoItem(_MockRepo repo, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: index < 2 ? 10 : 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  repo.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  repo.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: repo.languageColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    repo.language,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star_outline,
                    size: 14,
                    color: Colors.amber.shade600,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    repo.stars,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: 500 + (index * 150)))
        .fadeIn()
        .slideX(begin: 0.1);
  }
}

class _MockUser {
  final String name;
  final Color color;

  const _MockUser({required this.name, required this.color});
}

class _MockRepo {
  final String name;
  final String description;
  final String language;
  final Color languageColor;
  final String stars;

  const _MockRepo({
    required this.name,
    required this.description,
    required this.language,
    required this.languageColor,
    required this.stars,
  });
}
