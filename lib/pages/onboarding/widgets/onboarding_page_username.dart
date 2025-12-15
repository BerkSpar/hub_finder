import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
import 'package:hub_finder/pages/onboarding/widgets/onboarding_page_indicator.dart';
import 'package:hub_finder/shared/core/app_colors.dart';
import 'package:hub_finder/shared/models/user.dart';
import 'package:hub_finder/shared/repositories/github_datasource.dart';

class OnboardingPageUsername extends StatefulWidget {
  final OnboardingController controller;

  const OnboardingPageUsername({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<OnboardingPageUsername> createState() => _OnboardingPageUsernameState();
}

class _OnboardingPageUsernameState extends State<OnboardingPageUsername> {
  bool get _canSubmit =>
      widget.controller.config.username?.isNotEmpty ?? false;

  User? user;

  bool isLoading = false;

  final usernameController = TextEditingController();

  Timer _debounce = Timer(Duration(milliseconds: 0), () {});
  void debounceSearch() {
    if (_debounce.isActive) _debounce.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      searchUsername();
    });
  }

  void searchUsername() async {
    if (usernameController.text.isEmpty) {
      setState(() {
        user = null;
        isLoading = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      user = await GithubDataSource().getUser(usernameController.text);
    } catch (e) {
      user = null;
    }

    setState(() {
      isLoading = false;
    });
  }

  void _skip() {
    widget.controller.config.username = null;
    widget.controller.next();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('asset/images/logo_light.png', height: 32),
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _skip,
            child: Text(
              "Skip",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.code_rounded,
                  size: 48,
                  color: Colors.grey.shade800,
                ),
              )
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 500))
                  .scale(begin: const Offset(0.5, 0.5)),
              const SizedBox(height: 24),
              Text(
                "Link Your GitHub",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 200),
                  )
                  .slideY(begin: 0.2, end: 0),
              const SizedBox(height: 8),
              Text(
                "Connect your GitHub account to unlock personalized features",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 300),
                  ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: user != null ? Colors.green : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: usernameController,
                  onChanged: (value) {
                    setState(() {
                      widget.controller.config.username = value.isEmpty ? null : value;
                      user = null;
                    });

                    debounceSearch();
                  },
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  cursorColor: darkColor,
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "username",
                    hintStyle: TextStyle(
                      color: Color(0xFF9A9A9A),
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "github.com/",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(minWidth: 0),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    suffixIcon: isLoading
                        ? Padding(
                            padding: const EdgeInsets.all(12),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.green),
                              ),
                            ),
                          )
                        : user != null
                            ? Padding(
                                padding: const EdgeInsets.all(12),
                                child: Icon(Icons.check_circle, color: Colors.green),
                              )
                            : null,
                  ),
                ),
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 400),
                  )
                  .slideY(begin: 0.2, end: 0),
              const SizedBox(height: 16),
              if (user != null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          user?.avatarUrl ?? "",
                          width: 50,
                          height: 50,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.name ?? user?.login ?? "",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (user?.bio != null)
                              Text(
                                user!.bio!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                      Icon(Icons.verified, color: Colors.green),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(duration: const Duration(milliseconds: 300))
                    .scale(begin: const Offset(0.95, 0.95)),
              const Spacer(),
              const OnboardingPageIndicator(currentPage: 5),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _canSubmit ? widget.controller.next : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Continue"),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
