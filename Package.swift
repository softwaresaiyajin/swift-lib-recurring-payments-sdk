// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "PayseraRecurringPaymentsSDK",
    platforms: [.macOS(.v10_12), .iOS(.v10), .tvOS(.v9), .watchOS(.v2)],
    products: [
        .library(name: "PayseraRecurringPaymentsSDK", targets: ["PayseraRecurringPaymentsSDK"]),
    ],
    dependencies: [
        .package(name: "PayseraCommonSDK", url: "https://github.com/paysera/swift-lib-common-sdk", from: "3.0.1"),
        .package(name: "PayseraAccountsSDK", url: "https://github.com/softwaresaiyajin/swift-lib-accounts-sdk", .branch("APPIOS-2549"))
    ],
    targets: [
        .target(
            name: "PayseraRecurringPaymentsSDK",
            dependencies: ["PayseraCommonSDK", "PayseraAccountsSDK"]
        ),
        .testTarget(
            name: "PayseraRecurringPaymentsSDKTests",
            dependencies: ["PayseraRecurringPaymentsSDK"]
        ),
    ]
)
