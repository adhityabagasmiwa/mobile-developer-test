# SequisPicsum - Sequis Mobile Engineer Tests

SequisPicsum is a SwiftUI-based image explorer app that leverages the [Lorem Picsum](https://picsum.photos/) API.

## 🚀 Project Overview



## 🛠 Tech Stack

- **Language**: Swift 5.10+
- **Framework**: SwiftUI
- **Networking**: [Moya](https://github.com/Moya/Moya) (Network abstraction layer on top of Alamofire)
- **Persistence**: Core Data for local storage
- **Dependency Manager**: [Swift Package Manager (SPM)](https://swift.org/package-manager/)
- **Architectural Patterns**: 
  - **Clean Architecture**: Separation of concerns between Domain, Data, and Presentation layers.
  - **MVVM**: Model-View-ViewModel.
  - **Coordinator Pattern**: Decoupled navigation logic.
  - **Dependency Injection**: Centralized dependency management via a custom `DependencyContainer`.

## 📂 Project Structure

```text
SequisPicsum/
├── App/                # App entry point and global configuration
├── Core/               # Shared infrastructure, DI, and Coordinators
│   ├── Base/           # Base of any classes
│   ├── Coordinators/   # Navigation flow logic
│   └── DI/             # Dependency Injection container
├── Data/               # Data Layer: API services, Repositories, DTOs
├── Domain/             # Domain Layer: Entities and Use Cases (Business Logic)
├── Presentation/       # UI Layer: Views and ViewModels
├── Resources/          # Localizable strings
└── Helpers/            # Utility functions and extensions
```

## 🏗 Getting Started

### Prerequisites

- macOS with Xcode `15.0` or later installed.
- Programming Language using `Swift` and `SwiftUI`.

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/adhityabagasmiwa/mobile-developer-test.git
    ```
2.  **Open the project**:
    Navigate to the project folder and open `SequisPicsum.xcodeproj`. Xcode will automatically begin fetching dependencies via Swift Package Manager.
3.  **Build and Run**:
    Wait for the package resolution to complete, then select an iOS Simulator or a physical device and press `Cmd + R`.

## 🧪 Testing & Code Quality

- **Unit Testing**: Core business logic and ViewModels are covered by unit tests in `SequisPicsumTests`.
- **Linting**: [SwiftLint](https://github.com/realm/SwiftLint) is integrated to maintain code style consistency.
- **CI**: GitHub Actions workflow for continuous integration (Building and Testing).