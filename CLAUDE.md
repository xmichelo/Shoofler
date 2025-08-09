# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Shoofler is a text expansion tool for macOS that allows users to define text snippets with triggers that expand when typed. The app runs as a menu bar application and uses accessibility APIs to monitor keyboard input for text substitution.

## Build System & Development Commands

This project uses [Tuist](https://tuist.dev) for project management and dependency resolution. Xcode project files are generated from Swift configuration files and should not be committed.

### Essential Commands

```bash
# Install dependencies (required first time or after dependency changes)
tuist install

# Generate Xcode project and open it
tuist generate

# Clean generated files
tuist clean

# Build for release with signing (if TUIST_SHOOFLER_DEV_TEAM_ID is set)
tuist build --clean --generate -C Release --build-output-path ~/Desktop/ShooflerBuild
```

### Running Tests

Tests are run through Xcode after generating the project. The test target is `ShooflerTests`.

## Architecture Overview

### Core Architecture Pattern
- **Composable Architecture (TCA)**: The app uses Point-Free's Composable Architecture for state management
- **Feature-based organization**: Each major component is organized as a Feature with State, Action, and Reducer
- **Dependency injection**: Uses TCA's dependency system for testing and modularity

### Key Features and Components

1. **AppFeature** (`Shoofler/Sources/Features/AppFeature.swift:6`): Root feature managing app lifecycle and window states
2. **EngineFeature** (`Shoofler/Sources/Features/EngineFeature.swift:4`): Coordinates input monitoring, snippet matching, and text substitution
3. **VaultFeature**: Manages snippet and group storage/retrieval
4. **InputFeature**: Handles keyboard event monitoring using accessibility APIs
5. **SubstituterFeature**: Performs text substitution by simulating keystrokes
6. **SystemMonitorFeature**: Monitors system accessibility permissions

### Data Models
- **Snippet** (`Shoofler/Sources/Snippet/Snippet.swift:5`): Core data structure with trigger, content, description, and optional group
- **Group** (`Shoofler/Sources/Group/Group.swift:4`): Organizational structure for snippets
- **SnippetList/GroupList**: Collection types with persistence and sample data

### Key Directories
- `Shoofler/Sources/Features/`: TCA feature implementations
- `Shoofler/Sources/Views/`: SwiftUI views organized by component
- `Shoofler/Sources/Logging/`: Custom logging with file output
- `Shoofler/Tests/`: Unit tests for core data models
- `shootool/`: Command-line tool for automation tasks

### Dependencies
- **ComposableArchitecture**: State management and architecture
- **CocoaLumberjack**: Logging framework
- **ArgumentParser**: For shootool command-line interface

## Important Implementation Details

### Accessibility Requirements
The app requires accessibility permissions to monitor keyboard input. The SystemMonitorFeature tracks permission status and automatically installs/removes event monitors based on permission changes.

### Menu Bar Application
- Configured as `LSUIElement: true` - runs without dock icon by default
- Uses MenuBarExtra for system tray presence
- Dynamically shows/hides dock icon when main window is open

### Text Substitution Flow
1. InputFeature monitors global keyboard events
2. Maintains an accumulator of recent keystrokes
3. VaultFeature checks accumulator against snippet triggers
4. SubstituterFeature performs substitution by erasing trigger text and typing replacement

### Settings and Persistence
- Settings managed through SettingsFeature with automatic persistence
- Supports themes (light/dark/system)
- Configurable startup behavior and window preferences

## Project Structure Notes

- Project configuration in `Project.swift` using Tuist's ProjectDescription
- Dependencies managed in `Tuist/Package.swift`
- Entitlements files for both debug and release builds
- Blog and website source in `www/` directory (separate Hugo-based site)