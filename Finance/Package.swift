// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Finance",
  platforms: [.iOS(.v14)],
  products: [
    .library(
      name: "AddPaymentMethod",
      targets: ["AddPaymentMethod"]),
    .library(
      name: "AddPaymentMethodImpl",
      targets: ["AddPaymentMethodImpl"]),
    .library(
      name: "AddPaymentMethodTestSupport",
      targets: ["AddPaymentMethodTestSupport"]),
    .library(
      name: "Topup",
      targets: ["Topup"]),
    .library(
      name: "TopupImpl",
      targets: ["TopupImpl"]),
    .library(
      name: "TopupTestSupport",
      targets: ["TopupTestSupport"]),
    .library(
      name: "FinanceHome",
      targets: ["FinanceHome"]),
    .library(
      name: "FinanceEntity",
      targets: ["FinanceEntity"]),
    .library(
      name: "FinanceRepository",
      targets: ["FinanceRepository"]),
    .library(
      name: "FinanceRepositoryTestSupport",
      targets: ["FinanceRepositoryTestSupport"]),
  ],
  dependencies: [
    .package(name: "ModernRIBs", url: "https://github.com/DevYeom/ModernRIBs", .exact("1.0.1")),
    .package(path: "../Platform")
  ],
  targets: [
    .target(
      name: "AddPaymentMethod",
      dependencies: [
        "ModernRIBs",
        "FinanceEntity",
        .product(name: "RIBsUtil", package: "Platform"),
      ]
    ),
    .target(
      name: "AddPaymentMethodImpl",
      dependencies: [
        "AddPaymentMethod",
        "ModernRIBs",
        "FinanceEntity",
        "FinanceRepository",
        .product(name: "RIBsUtil", package: "Platform"),
        .product(name: "SuperUI", package: "Platform")
      ]
    ),
    .target(
      name: "AddPaymentMethodTestSupport",
      dependencies: [
        "AddPaymentMethod",
        "ModernRIBs",
        "FinanceEntity",
        .product(name: "RIBsUtil", package: "Platform"),
        .product(name: "RIBsTestSupport", package: "Platform")
      ]
    ),
    .target(
      name: "Topup",
      dependencies: [
        "ModernRIBs"
      ]
    ),
    .target(
      name: "TopupImpl",
      dependencies: [
        "Topup",
        "ModernRIBs",
        "FinanceEntity",
        "FinanceRepository",
        "AddPaymentMethod",
        .product(name: "RIBsUtil", package: "Platform"),
        .product(name: "SuperUI", package: "Platform")
      ]
    ),
    .target(
      name: "TopupTestSupport",
      dependencies: [
        "Topup"
      ]
    ),
    .target(
      name: "FinanceHome",
      dependencies: [
        "ModernRIBs",
        "FinanceEntity",
        "FinanceRepository",
        "AddPaymentMethod",
        "Topup",
        .product(name: "RIBsUtil", package: "Platform"),
        .product(name: "SuperUI", package: "Platform")
      ]
    ),
      .target(
        name: "FinanceEntity",
        dependencies: []
      ),
    .target(
      name: "FinanceRepository",
      dependencies: [
        "FinanceEntity",
        .product(name: "Network", package: "Platform"),
        .product(name: "CombineUtil", package: "Platform")
      ]
    ),
    .target(
      name: "FinanceRepositoryTestSupport",
      dependencies: [
        "FinanceEntity",
        "FinanceRepository",
        .product(name: "CombineUtil", package: "Platform")
      ]
    ),
    .testTarget(
      name: "TopupImplTests",
      dependencies: [
        "TopupImpl",
        "FinanceRepositoryTestSupport",
        "TopupTestSupport",
        "AddPaymentMethodTestSupport",
        .product(name: "RIBsTestSupport", package: "Platform"),
        .product(name: "PlatformTestSupport", package: "Platform")
      ],
      exclude: [
        "EnterAmount/__Snapshots__",
        "CardOnFile/__Snapshots__"
      ]
    )
  ]
)
