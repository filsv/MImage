# MImage

A SwiftUI view that provides morphing blur transitions between SF Symbol variants. Works on iOS 15+, macOS 11+, and watchOS 8+.

## Features

- **Blur Transition**: Smoothly transitions between symbol variants with a configurable blur in/out effect.
- **Environment-Based Duration**: Set the duration once in the environment for consistent animations.
- **Canvas Clipping**: Uses SwiftUI's `Canvas` to alpha-threshold the symbol shape.

## Installation

1. **Swift Package Manager** (Recommended)  
   In Xcode, go to `File → Add Packages...` and use the repository URL:
   https://github.com/filsv/MImage.git
   Then select the "MImage" library for your app target.

2. **Add as a Swift Package** in your `Package.swift`:
```swift
.package(url: "https://github.com/YourUsername/MImage.git", from: "1.0.0"),
```

## Usage
1. **Import the module:**
```swift
import MImage
```

2. **Use MImage in your SwiftUI code:**
```swift
struct ContentView: View {
    var body: some View {
        MImage(systemName: "heart", variant: .fill)
            .symbolDuration(2.0)  // 2-second transitions
            .frame(width: 100, height: 100)
    }
}
```

3. **Morphing: Change variant to e.g. .none, .fill, or .circle.**
    The blur animation triggers automatically.

## Example App

See the Examples/MImageExampleApp folder for a small SwiftUI demo project that showcases how to tap or swipe through different symbols/variants.

## Requirements

• iOS 15+, macOS 11+, watchOS 8+.
• Swift 5.5+.

## Contributing

Feel free to open issues or pull requests!

## License

This library is released under the MIT License. See LICENSE for details.
