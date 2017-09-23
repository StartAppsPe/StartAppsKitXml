import PackageDescription

let package = Package(
    name: "StartAppsKitXml",
    dependencies: [
        .Package(url: "https://github.com/StartAppsPe/StartAppsKitLoadAction.git", majorVersion: 2),
        .Package(url: "https://github.com/StartAppsPe/StartAppsKitLogger.git", majorVersion: 2),
        .Package(url: "https://github.com/tadija/AEXML.git", majorVersion: 4),
    ]
)
