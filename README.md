# Newspace 🚀

**Your daily source for space news.**

Newspace is a Flutter application built to make exploring space-related news a little easier. It brings together articles about space exploration, science, technology, and other developments in the space industry in one place.

Whether you're interested in the latest space discoveries or just want to keep up with what's happening beyond Earth, Newspace makes it easier to find something worth reading.

## Features

- **Featured Article** — A highlighted article to help you discover important news.
- **Latest News** — Browse the latest articles in one place.
- **Categories** — Explore news based on different topics.
- **Search** — Find articles using keywords.
- **Bookmarks** — Save articles you want to read later.
- **Light & Dark Mode** — Choose the appearance that feels more comfortable.
- **Pull to Refresh** — Get the latest articles without restarting the app.

## Built With

Here are some of the tools and technologies used to build Newspace:

| Technology | Usage |
|---|---|
| Flutter | Building the application |
| Dart | Main programming language |
| Riverpod | State management |
| Spaceflight News API (SNAPI) | Fetching space-related news |
| HTTP | Handling API requests |
| SharedPreferences / Local Storage | Saving local preferences and bookmarks |
| Material 3 | Application UI and theming |

## API

Newspace uses the [Spaceflight News API](https://api.spaceflightnewsapi.net/) to fetch articles from different space news sources.

The API provides information such as article titles, summaries, publication dates, sources, and images.

**Main endpoint:**

```http
GET https://api.spaceflightnewsapi.net/v4/articles/
```

Example parameters:

```text
limit=30
offset=0
ordering=-published_at
```

No API key is required for the public SNAPI endpoint used by this project.

## Getting Started

Want to run Warta locally? Here's how.

### Requirements

Make sure you have the following installed:

- Flutter SDK
- Dart SDK
- Android Studio or VS Code
- Git

### Installation

**1. Clone the repository**

```bash
git clone <YOUR_REPOSITORY_URL>
```

**2. Open the project directory**

```bash
cd warta-app
```

**3. Install the dependencies**

```bash
flutter pub get
```

**4. Run the application**

```bash
flutter run
```

That's it! The application should now be running on your connected device or emulator.

## Project Structure

Warta uses a layered structure to keep the code organized and easier to maintain.

```text
lib/
├── core/
│   ├── constants/
│   ├── router/
│   └── utils/
│
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
│
├── providers/
│
├── ui/
│   ├── screens/
│   └── widgets/
│
├── app.dart
└── main.dart
```

A quick overview of what each folder does:

- `core/` — Shared constants, routing, and utility functions.
- `data/` — Article models, API services, and repositories.
- `providers/` — State management and dependency injection.
- `ui/` — Application screens and reusable widgets.

## Development

To check the project for potential issues:

```bash
flutter analyze
```

To run the available tests:

```bash
flutter test
```

## Contributing

Have an idea or found something that could be improved? Contributions are welcome!

1. Fork this repository.
2. Create a new branch.
3. Make your changes.
4. Commit and push your changes.
5. Open a Pull Request.

## License

No license has been specified for this project yet.

---

Made with Flutter 💙

**Newspace — Stay curious about space.**