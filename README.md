# News App 📰

A modern, feature-rich news application built with Flutter that delivers real-time news from multiple categories. Stay informed with the latest headlines from around the world with support for multiple languages, infinite scrolling, and a beautiful, responsive UI.

## 📸 Screenshots

> Add your app screenshots here to showcase the UI

## 🌟 Project Overview

News App is a comprehensive cross-platform mobile application that aggregates news from various sources using the NewsAPI. The app provides users with curated news content across different categories including Sports, General, Health, Business, Entertainment, Science, and Technology. With support for both English and Arabic languages, the app offers a personalized news reading experience with features like infinite scrolling, article search, and in-app article viewing.

## 🚀 Features

- 📱 **Multiple News Categories** - Browse news across 7 different categories (Sports, General, Health, Business, Entertainment, Science, Technology)
- 🌍 **Multi-Language Support** - Full support for English and Arabic with RTL layout
- 🔍 **Real-time Search** - Search for specific news articles and topics across all sources
- 📖 **Article Details** - View full article details with images, author, and publication date
- 🔗 **External Links** - Open full articles in external browser using URL launcher
- ♾️ **Infinite Scrolling** - Load more news automatically as you scroll with pagination
- 💾 **Persistent Settings** - Language preferences saved locally using SharedPreferences
- 🖼️ **Image Caching** - Optimized image loading and caching for better performance
- 🎨 **Material Design** - Clean and modern UI following Material Design principles
- ⚡ **Fast & Responsive** - Optimized performance with efficient state management using Provider
- 🌐 **Cross-Platform** - Works seamlessly on Android and iOS

## 🛠️ Tech Stack

- **Framework:** Flutter 3.35.5
- **Language:** Dart 3.5.0+
- **State Management:** Provider 6.1.5
- **HTTP Client:** HTTP 1.5.0
- **Image Caching:** Cached Network Image 3.4.1
- **Localization:** Flutter Localizations (intl 0.20.2)
- **Local Storage:** Shared Preferences 2.5.3
- **URL Launcher:** URL Launcher 6.3.2
- **API:** [NewsAPI](https://newsapi.org/)

### Additional Packages:

- `flutter_localizations` - Internationalization support
- `cached_network_image: ^3.4.1` - Efficient image loading and caching
- `provider: ^6.1.5` - State management solution
- `shared_preferences: ^2.5.3` - Local data persistence
- `url_launcher: ^6.3.2` - Opening external URLs
- `intl` - Date formatting and internationalization
- `cupertino_icons: ^1.0.8` - iOS style icons

## 🏗️ Architecture

The project follows a **clean architecture pattern** with **feature-first folder structure** and **Provider** for state management:

```
lib/
├── core/
│   ├── database/
│   │   └── remote/
│   │       ├── api_constants.dart       # API configuration
│   │       └── api_manger.dart          # API client
│   └── utilites/
│       ├── constants/
│       │   └── app_assets.dart          # Asset paths
│       ├── extentions/
│       │   ├── data_time_extension.dart # DateTime utilities
│       │   └── localization_extension.dart # Localization helpers
│       └── styles/
│           ├── app_colors.dart          # Color palette
│           └── app_theme.dart           # Theme configuration
├── features/
│   ├── category/
│   │   ├── model/
│   │   │   └── category_model.dart      # Category data model
│   │   └── presentation/
│   │       ├── view/
│   │       │   ├── screens/
│   │       │   │   └── category_details.dart
│   │       │   └── widgets/
│   │       │       ├── category_fragment.dart
│   │       │       └── category_item.dart
│   │       └── view_model/
│   │           └── category_provider.dart
│   ├── home_screen/
│   │   ├── data/
│   │   │   └── models/
│   │   │       ├── Articles.dart        # Article model
│   │   │       ├── NewsResponse.dart    # News API response
│   │   │       ├── Sources.dart         # Source model
│   │   │       └── SourceResponse.dart  # Source API response
│   │   └── presentation/
│   │       ├── view/
│   │       │   ├── screens/
│   │       │   │   └── home_screen.dart
│   │       │   └── widgets/
│   │       │       ├── tabs/
│   │       │       │   ├── tab_item.dart
│   │       │       │   └── tab_widget.dart
│   │       │       ├── home_drawer.dart
│   │       │       ├── news_item.dart
│   │       │       ├── news_search_delegate.dart
│   │       │       └── news_widget.dart
│   │       └── view_model/
│   │           └── news_provider.dart
│   ├── news_details/
│   │   └── news_details.dart            # Article detail screen
│   ├── settings/
│   │   ├── provider/
│   │   │   └── language_provider.dart   # Language management
│   │   └── settings_tab.dart            # Settings screen
│   └── splash_screen/
│       └── splash_screen.dart           # Splash screen
├── l10n/
│   ├── app_localizations.dart           # Localization base
│   ├── app_localizations_ar.dart        # Arabic translations
│   └── app_localizations_en.dart        # English translations
└── main.dart                            # App entry point
```

### Architectural Layers:

1. **Core Layer** - Shared utilities, constants, API client, and themes
2. **Feature Layer** - Feature-specific code organized by domain
3. **Data Layer** - Models and data sources
4. **Presentation Layer** - UI screens, widgets, and view models (Providers)
5. **Localization Layer** - Multi-language support

## 📂 Folder Structure

```
news-app/
├── android/                  # Android platform files
├── ios/                     # iOS platform files
├── lib/                     # Main application code
│   ├── core/               # Core utilities and configuration
│   │   ├── database/      # API client and configuration
│   │   └── utilites/      # Constants, extensions, styles
│   ├── features/          # Feature modules
│   │   ├── category/      # Category selection and details
│   │   ├── home_screen/   # Home screen with news feed
│   │   ├── news_details/  # Article detail view
│   │   ├── settings/      # App settings
│   │   └── splash_screen/ # Splash screen
│   ├── l10n/              # Localization files
│   └── main.dart          # Entry point
├── test/                   # Unit and widget tests
├── assets/                 # Images and resources
│   └── image/
├── l10n.yaml              # Localization configuration
├── pubspec.yaml           # Package dependencies
└── analysis_options.yaml  # Linter configuration
```

## 🎯 State Management with Provider

The app uses **Provider** for state management with the following key providers:

### CategoryProvider
- Manages category sources
- Handles source loading states
- Error handling for source fetching

### NewsProvider
- Manages news articles list
- Implements infinite scrolling with pagination
- Handles loading states and errors
- Page size: 10 articles per page

### LanguageProvider
- Manages language selection (English/Arabic)
- Persists language preference using SharedPreferences
- Triggers app-wide locale changes

## 🔌 API Integration

The app uses [NewsAPI](https://newsapi.org/) for fetching news articles:

```dart
// API Configuration
Base URL: newsapi.org
API Key: 5f1c414a85e24141b1b7c1a56f2ae6b9

// Endpoints
Sources: /v2/top-headlines/sources
News: /v2/everything
```

**Categories supported:**
- Sports
- General
- Health
- Business
- Entertainment
- Science
- Technology

**API Features:**
- Get sources by category
- Get news by source ID with pagination
- Search news articles by query
- Pagination support for infinite scrolling

## 🌐 Multi-Language Support

The app fully supports **English** and **Arabic** with:

- Dynamic locale switching
- RTL (Right-to-Left) layout support for Arabic
- Localized UI strings
- Persistent language preference
- Context extension for easy access to translations

```dart
// Usage example
Text(context.localization.categories)
```

## 🚦 How to Run the Project

### Prerequisites

- Flutter SDK 3.35.5 or higher
- Dart 3.5.0 or higher
- Android Studio / VS Code with Flutter extensions
- An emulator or physical device
- NewsAPI key (Get yours at [newsapi.org](https://newsapi.org/))

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/news-app.git
   cd news-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Key**

   Update the API key in `lib/core/database/remote/api_constants.dart`:
   ```dart
   static const String apiKey = "YOUR_API_KEY_HERE";
   ```

4. **Generate localization files**
   ```bash
   flutter gen-l10n
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

6. **Build for specific platform**
   ```bash
   # Android
   flutter build apk --release
   
   # iOS
   flutter build ios --release
   ```

## 🧪 Testing

Run the test suite using:

```bash
flutter test
```

The project includes widget tests in the `test/` directory.

## 🎨 UI/UX Features

### Design System
- **Primary Color:** Green (#39A552)
- **Category Colors:** Unique color for each category
- **Typography:** Custom text styles for different UI elements
- **Rounded Corners:** Modern rounded UI elements
- **Card Design:** Elevated cards for news items

### User Experience
- Smooth animations and transitions
- Pull-to-refresh functionality
- Loading indicators
- Error handling with retry options
- Empty states
- Responsive layout
- Touch feedback

## 💡 Key Implementation Details

### Infinite Scrolling
```dart
ScrollController monitors scroll position
Loads more news when reaching bottom
Page-based pagination (10 items per page)
Automatic loading state management
```

### Image Caching
```dart
CachedNetworkImage for efficient loading
Placeholder while loading
Error widget for failed loads
Automatic memory management
```

### State Management Flow
1. User interacts with UI
2. UI calls Provider method
3. Provider makes API call via ApiManager
4. Provider updates state and notifies listeners
5. UI rebuilds with new data
6. Settings persisted using SharedPreferences

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS

## 🔮 Future Improvements

- [ ] Add dark theme support
- [ ] Implement bookmark/favorite articles feature
- [ ] Add offline mode with local caching
- [ ] Include push notifications for breaking news
- [ ] Add article sharing functionality (social media integration)
- [ ] Implement user authentication
- [ ] Add personalized news feed based on preferences
- [ ] Include comment/discussion section for articles
- [ ] Add text-to-speech for articles
- [ ] Implement news categorization with tags
- [ ] Add trending news section
- [ ] Include video news support
- [ ] Add weather widget integration
- [ ] Implement news widgets for home screen
- [ ] Add night reading mode
- [ ] Include accessibility features (font size adjustment)
- [ ] Add news source filtering preferences
- [ ] Implement article history tracking
- [ ] Add statistics and analytics dashboard
- [ ] Include multiple API source support

## 🔐 API Key Security

**Important:** Never commit your API key to public repositories. Consider:

- Using environment variables
- Adding API key to `.gitignore`
- Using Flutter's `--dart-define` for secure key storage
- Implementing backend proxy for production apps
- Using Flutter Dotenv package for environment configuration

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Contribution Guidelines

- Follow the existing code structure and architecture
- Write meaningful commit messages
- Add comments for complex logic
- Update documentation for new features
- Ensure all tests pass before submitting PR

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Developer

**Mohamed Hamad**

- GitHub: [@Mohmdhamad](https://github.com/Mohmdhamad)
- Email: mo7maaa7maaa@gmail.com

## 🙏 Acknowledgments

- [NewsAPI](https://newsapi.org/) for providing the news data
- Flutter team for the amazing framework
- Provider package maintainers
- The Flutter community for continuous support
- All open-source contributors

## 📝 Notes

- Free NewsAPI tier allows 100 requests per day
- Some articles may have limited preview content
- Images may not be available for all articles
- API responses depend on source availability
- Pagination improves performance for large datasets
- Language preference persists across app sessions

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [NewsAPI Documentation](https://newsapi.org/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [Flutter Localization Guide](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)

---

⭐ **Star this repo if you find it helpful!**

💬 **Feel free to reach out for questions or suggestions!**

🐛 **Found a bug? Please open an issue!**

📱 **Download the app and start reading news today!**