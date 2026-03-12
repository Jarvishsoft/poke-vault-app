# Poké-Vault Mobile Application.

## 1. Project Overview

**Poké-Vault** is a comprehensive mobile application built with **Flutter** that serves as a digital encyclopedia for Pokémon. It allows users to browse, search, and view detailed information about Pokémon, including their stats, abilities, and types.

### Key Features:

- **Pokédex**: Browse a comprehensive list of Pokémon with images and basic information.
- **Detail View**: View detailed information about each Pokémon, including stats, abilities, and types.
- **Search**: Search for Pokémon by name or ID.
- **Offline Support**: Cache Pokémon data for offline access.
- **Clean Architecture**: Follows a clean architecture pattern for maintainability and scalability.
- **State Management**: Uses `GetX` for efficient state management.

## 2. Tech Stack

- **Framework**: Flutter 3.x
- **Language**: Dart 3.x
- **State Management**: GetX
- **Networking**: Dio
- **Local Storage**: Hive
- **Architecture**: Clean Architecture (Domain, Data, Presentation layers)
- **UI**: Material Design 3
- **Fonts**: Google Fonts (Montserrat)

## 3. Project Structure

The project follows a clean architecture pattern with the following layers:

```
lib/
├── app/
│   ├── bindings/          # Dependency injection bindings
│   ├── data/              # Data layer
│   │   ├── models/        # Data models
│   │   ├── repositories/  # Repository implementations
│   │   └── services/      # API services
│   ├── domain/            # Domain layer
│   │   ├── entities/      # Domain entities
│   │   ├── repositories/  # Repository interfaces
│   │   └── usecases/      # Business logic
│   ├── presentation/      # Presentation layer
│   │   ├── controllers/   # Controllers
│   │   ├── pages/         # UI pages
│   │   └── widgets/       # Reusable widgets
│   ├── routes/            # Navigation routes
│   └── utils/             # Utilities (colors, styles, etc.)
├── main.dart              # Application entry point
└── ...                    # Other project files
```

## 4. Getting Started

### Prerequisites

- Flutter SDK (3.x or higher)
- Dart SDK (3.x or higher)
- Android Studio or VS Code

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd poke_vault
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## 5. Usage

### Running in Debug Mode

```bash
flutter run
```

### Building for Release

```bash
flutter build apk --release
```

## 6. Project Structure Explained

### Domain Layer

The domain layer contains the core business logic and entities of the application. It is independent of any framework-specific code.

- **Entities**: Represent the business objects (e.g., `Pokemon`).
- **Repositories**: Abstract interfaces that define data operations.
- **Use Cases**: Encapsulate the business logic (e.g., `GetPokemonsUseCase`).

### Data Layer

The data layer is responsible for data retrieval and storage. It implements the repository interfaces defined in the domain layer.

- **Models**: Data transfer objects that map to API responses.
- **Repositories**: Concrete implementations of repository interfaces using Dio and Hive.
- **Services**: Handle API calls to the Pokémon API.

### Presentation Layer

The presentation layer handles the UI and user interactions.

- **Controllers**: Manage the state and business logic for each screen.
- **Pages**: UI screens of the application.
- **Widgets**: Reusable UI components.

## 7. API Integration

The application uses the **PokéAPI** (https://pokeapi.co/) for Pokémon data.

- **Base URL**: `https://pokeapi.co/api/v2/`
- **Endpoints**:
  - List Pokémon: `/pokemon?offset={offset}&limit={limit}`
  - Pokémon Details: `/pokemon/{name_or_id}`

## 8. Offline Support

The application uses **Hive** to cache Pokémon data for offline access. When the app is run without an internet connection, it will serve data from the local cache.

## 9. State Management

**GetX** is used for state management, providing:

- **Reactive state management**
- **Dependency injection**
- **Route management**
- **Simple and efficient state handling**

## 10. Testing

Unit tests are implemented for the domain and data layers. To run the tests:

```bash
flutter test
```

## 11. Best Practices

- **Clean Architecture**: Promotes separation of concerns and testability.
- **Dependency Injection**: Uses GetX for easy dependency management.
- **Error Handling**: Comprehensive error handling with user-friendly messages.
- **Code Formatting**: Uses `dart format` for consistent code style.

## 12. License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 13. Contact

For any questions or issues, please open an issue or contact the development team.
