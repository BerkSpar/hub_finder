# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Development Commands

```bash
flutter pub get                    # Install dependencies
flutter run                        # Run the app
flutter build apk                  # Build Android APK
flutter build ios                  # Build iOS app
flutter analyze                    # Run linter
flutter test                       # Run tests
dart run build_runner build        # Generate MobX code (*.g.dart files)
dart run build_runner watch        # Watch and generate MobX code
```

## Architecture

This is a Flutter mobile app for searching GitHub users, repositories, and organizations.

### State Management
Uses **MobX** with code generation. Controllers use `@observable` and `@action` annotations, with generated files (`*.g.dart`) created via `build_runner`.

### Data Layer
- `lib/shared/repositories/` - Data sources for GitHub API (`GithubDataSource`) and trending data (`TrendingDatasource`)
- Uses **Dio** for HTTP requests against `api.github.com`

### Local Storage
- **Hive** for local persistence (`LocalStorageService` in `lib/shared/services/database_service.dart`)
- Stores: cached users, history points (streak tracking), user config, ad/review timestamps

### Page Structure
Each page follows the pattern:
- `lib/pages/{feature}/{feature}_page.dart` - UI widget
- `lib/pages/{feature}/{feature}_controller.dart` - MobX store
- `lib/pages/{feature}/{feature}_controller.g.dart` - Generated MobX code
- `lib/pages/{feature}/widgets/` - Page-specific widgets

### Services
- `lib/shared/services/firebase_service.dart` - Firebase integration
- `lib/shared/services/notification_service.dart` - Push notifications
- `lib/shared/services/review_service.dart` - In-app review

### Integrations
- Firebase (Analytics, Crashlytics, Performance, In-App Messaging, Cloud Messaging)
- Google Mobile Ads
- In-app review
- do not write .g.dart files, generate after with `dart run build_runner -d`
- do not create function that return widgets. Instead prefer to create Stateful or Stateless widgets