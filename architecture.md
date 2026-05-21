# Piano App Architecture

This diagram reflects the current Flutter app structure in this repository.

## High-Level Architecture

```mermaid
flowchart TD
    A[main.dart] --> B[initDependencyInjection]
    A --> C[StorageProvider.loadToken]
    A --> D[dotenv / environment.dart]
    A --> E[GetMaterialApp]

    E --> F[AppPages / GetX Routes]
    F --> G[Feature Modules]

    subgraph Feature Modules
        G1[Views]
        G2[Bindings]
        G3[Controllers]
    end

    G1 --> G3
    G2 --> G3
    G2 --> H[GetIt Service Locator]

    H --> I[AuthRepository]
    H --> J[ProductRepository]
    H --> K[ApiClient]
    H --> L[UserProvider]
    H --> M[StorageService]
    H --> N[SocketService]

    I --> O[AuthRepositoryImpl]
    J --> P[ProductRepositoryImpl]

    O --> K
    O --> L
    P --> K
    P --> L

    K --> Q[Dio]
    Q --> R[AuthInterceptor]
    Q --> S[LoggingInterceptor]
    R --> C1[StorageProvider]
    R --> L
    R --> T[Refresh Token API]

    K --> U[REST Backend]

    G3 --> V[Resource / Rx State]
    G3 --> C1
    G3 --> W[Static App Providers]

    W --> W1[FavoriteProvider]
    W --> W2[BrandProvider]
    W --> W3[CategoryProvider]
    W --> W4[SubCategoryProvider]

    M --> X[SharedPreferences]
    C1 --> M

    U --> Y[JSON Models]
    Y --> O
    Y --> P
```

## Feature Request Flow

```mermaid
sequenceDiagram
    participant User
    participant View
    participant Controller
    participant Repo as Repository
    participant Api as ApiClient
    participant Dio
    participant Auth as AuthInterceptor
    participant Backend

    User->>View: Tap / submit action
    View->>Controller: Call controller method
    Controller->>Repo: Invoke domain repository contract
    Repo->>Api: get/post/patch/delete
    Api->>Dio: Execute HTTP request
    Dio->>Auth: Attach token / refresh if needed
    Auth->>Backend: Refresh token request if expired
    Dio->>Backend: Main API request
    Backend-->>Dio: JSON response / error
    Dio-->>Api: Response
    Api-->>Repo: Either<Failure, Model>
    Repo-->>Controller: Parsed result
    Controller-->>View: Update `Resource` / Rx state
    View-->>User: Render loading, data, or error
```

## Current Structural Notes

- App startup is centralized in `main.dart`, which initializes DI, loads cached auth tokens, loads `.env`, restores locale, and restores theme mode.
- Navigation uses `GetMaterialApp` and `AppPages`, with each feature registered as a `GetPage`.
- Each feature generally follows `binding -> controller -> repository`.
- Dependency injection is split across `GetIt` for services/repositories and `GetX` bindings for controllers.
- `ApiClient` is the shared HTTP layer and wraps Dio with common headers, timeout handling, failure mapping, and offline routing.
- `AuthInterceptor` handles bearer token injection, token refresh, and forced logout when the backend reports token/session failure.
- Persistence is abstracted through `StorageService`, currently backed by `SharedPreferences`.

## Main Layers

- `lib/app/core`: app-wide DI, theme, translations, and utilities
- `lib/app/data`: API client, interceptors, request DTOs, repository implementations, response/model parsing
- `lib/app/domain`: repository contracts, failures, resource wrappers, storage/user abstractions
- `lib/app/modules`: feature UI and presentation logic using GetX
- `lib/app/routes`: route definitions and page registration
- `lib/app/environment`: environment variables consumed by the network layer
