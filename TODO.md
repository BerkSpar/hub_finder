# DevSidekick Pro - Implementation Plan

## Overview

Premium subscription bundle at **$9.99/month** (or $79.99/year) with four major features:
- **AI Dev Coach** - Code review, explanations, learning tips (Claude API)
- **Focus Mode** - Pomodoro timer with analytics
- **Income Tracker** - Freelance project & earnings management
- **Career Insights** - Skills analysis & market trends

---

## Subscription Tiers

| Feature | Free | Pro ($9.99/mo) |
|---------|------|----------------|
| GitHub Search | ✅ | ✅ |
| Streak Tracking | ✅ | ✅ |
| Trending Devs/Repos | ✅ | ✅ |
| AI Dev Coach | 3/day | Unlimited |
| Focus Mode | Basic | Full analytics |
| Income Tracker | ❌ | ✅ |
| Career Insights | ❌ | ✅ |
| Ads | Yes | No |

---

## Phase 1: Focus Mode + Subscriptions (MVP)

### 1.1 Subscription Infrastructure
- [ ] Add RevenueCat SDK (`purchases_flutter`)
- [ ] Create `lib/shared/services/subscription_service.dart`
- [ ] Implement `isPro()`, `purchasePro()`, `restorePurchases()`
- [ ] Add subscription status to LocalStorageService
- [ ] Create paywall UI (`lib/pages/subscription/paywall_page.dart`)

### 1.2 Focus Mode (Pomodoro Timer)
- [ ] Create `lib/pages/focus/focus_page.dart`
- [ ] Create `lib/pages/focus/focus_controller.dart` (MobX)
- [ ] Build circular countdown timer widget
- [ ] Implement timer controls (start/pause/reset)
- [ ] Add customizable durations (default: 25min work, 5min break)
- [ ] Store sessions in Hive (new box: `focus_sessions`)
- [ ] Add sound/vibration notifications
- [ ] Support background timer

### 1.3 Focus Analytics
- [ ] Build daily/weekly focus time charts (`fl_chart`)
- [ ] Track session count and total focus time
- [ ] Integrate with existing streak system
- [ ] Add "Focus Score" gamification element

### 1.4 Navigation Update
- [ ] Add Focus tab to bottom navigation
- [ ] Add premium badge/lock icons for Pro features
- [ ] Update app routing

---

## Phase 2: AI Dev Coach (Claude API)

### 2.1 Claude Integration
- [ ] Create `lib/shared/services/claude_service.dart`
- [ ] Create `lib/shared/repositories/claude_datasource.dart`
- [ ] Implement API calls with error handling
- [ ] Add rate limiting for free tier (3 queries/day)

### 2.2 Features
- [ ] Create `lib/pages/ai_coach/ai_coach_page.dart`
- [ ] Build code input widget with syntax highlighting
- [ ] Implement Code Review feature
- [ ] Implement Code Explainer feature
- [ ] Implement Ask Anything chat
- [ ] Add Daily Programming Tips

---

## Phase 3: Full Bundle

### 3.1 Income Tracker
- [ ] Create `lib/pages/income/income_page.dart`
- [ ] Build project tracking (name, client, earnings)
- [ ] Add time logging per project
- [ ] Create monthly reports with charts
- [ ] Add CSV export functionality

### 3.2 Career Insights
- [ ] Create `lib/pages/career/career_page.dart`
- [ ] Build skill analysis (from GitHub + self-assessment)
- [ ] Add market trends data
- [ ] Show salary benchmarks
- [ ] Provide learning suggestions

### 3.3 Finalization
- [ ] Remove ads for Pro users
- [ ] Update onboarding with Pro features
- [ ] Add settings for subscription management

---

## Dependencies to Add

```yaml
dependencies:
  purchases_flutter: ^8.0.0
  http: ^1.2.0
  fl_chart: ^0.68.0
  circular_countdown_timer: ^0.2.3
  intl: ^0.19.0
```

---

## File Structure

```
lib/
├── pages/
│   ├── focus/
│   │   ├── focus_page.dart
│   │   ├── focus_controller.dart
│   │   └── widgets/
│   │       ├── circular_timer.dart
│   │       ├── timer_controls.dart
│   │       └── focus_stats_card.dart
│   ├── ai_coach/
│   │   ├── ai_coach_page.dart
│   │   ├── ai_coach_controller.dart
│   │   └── widgets/
│   ├── income/
│   │   ├── income_page.dart
│   │   └── income_controller.dart
│   ├── career/
│   │   ├── career_page.dart
│   │   └── career_controller.dart
│   └── subscription/
│       ├── paywall_page.dart
│       └── subscription_controller.dart
├── shared/
│   ├── services/
│   │   ├── subscription_service.dart
│   │   └── claude_service.dart
│   └── models/
│       └── focus_session.dart
```

---

## Revenue Projections

| Active Users | 1% Conversion | Monthly Revenue |
|--------------|---------------|-----------------|
| 1,000 | 10 Pro | $100 |
| 10,000 | 100 Pro | $1,000 |
| 50,000 | 500 Pro | $5,000 |
| 100,000 | 1,000 Pro | $10,000 |

**Net margin: ~60-70%** (after API costs, store fees)

---

## Sources

- [Best Developer Productivity Tools 2025](https://www.atlassian.com/blog/loom/developer-productivity-tools)
- [AI Tools Worth Paying For](https://medium.com/@laura.wade/ai-tools-worth-paying-for-in-2025-2026-my-tested-picks-d835dc93012b)
- [GitHub Copilot Pricing](https://github.com/features/copilot)
- [Best Pomodoro Apps 2025](https://zapier.com/blog/best-pomodoro-apps/)
