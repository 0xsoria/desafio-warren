// swift-tools-version:5.3

/**
 This Package defines the modular architecture used by our app.

 Note: A Feature module can import Core, Root and Dependencies modules. And can't import other Feature modules or even the App module.

 App -> Features -> Core -> Root -> Dependencies

*/

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Modules",
            targets: [
                // MARK: Root modules
                "RootElements",

                // MARK: Core modules
                "CoreProviders",

                // MARK: Features modules
                "FeatureLogin",

                // MARK: App
                "App"
            ]
        )
    ],
    dependencies: [],
    targets: [
        // MARK: - Root

        /// This module contains elements that are common to multiple frameworks.
        /// Like UserDefaults components, Container ViewControllers, etc.
        .target(
            name: "RootElements",
            dependencies: [
            ]
        ),
        .testTarget(
            name: "RootElements-Tests",
            dependencies: [
                "RootElements"
            ]
        ),

        /// This module contains the all the functionality that connects to an external service.
        /// Like API calls, Endpoints, Keychain etc.
        .target(
            name: "CoreProviders",
            dependencies: [
                "RootElements"
            ]
        ),
        .testTarget(
            name: "CoreProviders-Tests",
            dependencies: [
                "CoreProviders"
            ]
        ),

        /// This modules contains the app login
        .target(
            name: "FeatureLogin",
            dependencies: [
                "CoreProviders"
            ]
        ),
        .testTarget(
            name: "FeatureLogin-Tests",
            dependencies: [
                "FeatureLogin"
            ]
        ),

        // MARK: - App
        .target(
            name: "App",
            dependencies: [
                "FeatureLogin"
            ]
        ),
        .testTarget(
            name: "App-Tests",
            dependencies: [
                "App"
            ]
        )
    ]
)
