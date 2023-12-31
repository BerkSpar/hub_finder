import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
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
  bool get _canSubmit => widget.controller.config.username?.isNotEmpty ?? false;

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
    setState(() {
      isLoading = true;
    });

    try {
      user = await GithubDataSource().getUser(usernameController.text);
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('asset/images/logo_light.png', height: 32),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Spacer(),
              Text(
                "What is your github username?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "We use it to track your progress",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: usernameController,
                onChanged: (value) {
                  setState(() {
                    widget.controller.config.username = value;
                  });

                  debounceSearch();
                },
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  // decoration: TextDecoration.none,
                ),
                cursorColor: darkColor,
                autofocus: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFF2F2F2),
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFF2F2F2),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  hintText: "username",
                  hintStyle: TextStyle(
                    color: Color(0xFF5A5A5A),
                  ),
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'github.com/',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF5A5A5A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF2F2F2),
                  contentPadding: const EdgeInsets.all(16),
                  suffix: isLoading
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(darkColor),
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              if (user != null)
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          user?.avatarUrl ?? "",
                          width: 48,
                          height: 48,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.name ?? "",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (user?.bio != null)
                              Text(
                                user!.bio!,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              Spacer(),
              ElevatedButton(
                onPressed: _canSubmit ? widget.controller.next : null,
                child: Text("Continue"),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
