import PackageDescription

let package = Package(
    name: "StartAppsKitXml",
    dependencies: [
        .Package(url: "https://github.com/StartAppsPe/StartAppsKitLoadAction.git", versions: Version(1,0,0)..<Version(1, .max, .max)),
        .Package(url: "https://github.com/StartAppsPe/StartAppsKitLogger.git", versions: Version(1,0,0)..<Version(1, .max, .max)),
        .Package(url: "https://github.com/tadija/AEXML.git", versions: Version(4,0,0)..<Version(4, .max, .max))
    ]
)
