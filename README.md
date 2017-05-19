# UbiquitousSync

Sync NSUserDefaults across multiple iOS or macOS devices via iCloud.

## Installation

Drag "Share module/UbiquitousSync.swift" into your Xcode project.

## Usage

In the initial processing (AppDelegate, etc.), call 
`UbiquitousSync.startWithPrefix (iCloud_Prefix)`. 

NSUserDefaults item with "iCloud_Prefix" will be synchronized.

if necessary...

- `startWithPrefix(iCloud_Prefix, restore:true/false)` In the initial processing, to load items from iCloud .
- `removeiCloudItems4Debug(iCloud_Prefix, cloud:true/false, local:true/false)` If true, reset iCloud or local items. For debug. 

## Demo Project
### Make

1. $cd UbiquitousSyncDemo
2. $pod install
3. tap “UbiquitousSyncDemo.xcworkspace”
4. TARGET -> UbiquitousSyncIOS -> “General tab”
 - Identify -> Build Identifier : "com.**YourCompany**.UbiquitousSyncIOS”   　change to your company identifier.
 - Singing -> Team : "**None**"    set your development team.
5. TARGET -> UbiquitousSyncIOS -> “Capabilities tab”
 - Turn on iCloud switch.
 - iCloud -> Services : ✔︎ Key-values storage
 - Containers : ✔︎ your iCloud container name (e.g. **iCloud.com.YourCompany.UbiquitousSyncStore**)
6. UbiquitousSyncIOS.entitlements
 - iCloud Key-Value Store : "$(TeamIdentifierPrefix)**$(CFBundleIdentifier)**”  　change to your iCloud container name (e.g. **com.YourCompany.UbiquitousSyncStore**).
7. Build and Run TARGET.
8. Change TARGET -> UbiquitousSyncMac and same OP item 4-7.
9. Settings AppID and iCloud container (Apple Developer site : Certificates, Identifiers & Profiles). Refer to [PrefsInCloud](https://developer.apple.com/library/content/samplecode/PrefsInCloud/Introduction/Intro.html "PrefsInCloud"). 

### Note
- Demo PJ was developed in Xcode 8.3.2.
- iOS 10.3,1 and macOS Sierra 10.12.4 were confirmed.
- This demo will not work in the iOS simulator.

## Credits

Inspired by Mugunth Kumar's [MKiCloudSync](https://github.com/MugunthKumar/MKiCloudSync "MKiCloudSync") (ObjC). Basic idea is due to MKiCloudSync.

## License

Distributed under the MIT License.

## Author

If you wish to contact me, email at: agepro60@gmail.com


