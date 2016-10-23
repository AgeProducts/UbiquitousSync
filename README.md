# UbiquitousSync

Sync NSUserDefaults across multiple iOS or macOS devices via iCloud.

## Installation

Drag "Share module/UbiquitousSync.swift" into your Xcode project.

## Usage

In the initial processing (AppDelegate, etc.), call 
```UbiquitousSync.startWithPrefix (iCloud_Prefix)```. 

NSUserDefaults item with "iCloud_Prefix" will be synchronized.

if necessary...

- ```startWithPrefix(iCloud_Prefix, restore:true/false)``` In the initial processing, to load items from iCloud .
- ```removeiCloudItems4Debug(iCloud_Prefix, cloud:true/false, local:true/false)``` If true, reset iCloud or local items. For debug. 

## Demo project
###Install
1. Settings AppID and iCloud container (Apple Developer site : Certificates, Identifiers & Profiles). Refer to [PrefsInCloud](https://developer.apple.com/library/content/samplecode/PrefsInCloud/Introduction/Intro.html "PrefsInCloud").
2. $cd UbiquitousSyncDemo
3. $pod install
4. tap “UbiquitousSyncDemo.xcworkspace”
5. TARGET -> UbiquitousSyncIOS -> “General tab”
 - Identify -> Build Identifier : \"**com.YourCompany**.UbiquitousSyncIOS”   　change to your company identifier.
 - Singing -> Team : \"**None**"    set your development team.
6. TARGET -> UbiquitousSyncIOS -> “Capabilities tab”
 - iCloud -> Services : ✔︎ Key-values storage and iCloud Documents
 - Containers : ✔︎ your iCloud container name (e.g. iCloud.com.yourcompany.UbiquitousSyncDemo)
7. UbiquitousSyncIOS.entitlements
 - iCloud Key-Value Store : \"$(TeamIdentifierPrefix) **$(CFBundleIdentifier)**”  　change to your iCloud container name.
8. Build and Run TARGET.
9. Change TARGET -> UbiquitousSyncMac and same OP item 5-8.

### Note
- Demo PJ was developed in Xcode8.1 bate3.
- iOS 9.3.5, iOS 10.1 and macOS Sierra 10.12.1 beta 3 (Build:16B2338c) were confirmed. All is a real machine.
- macOS 10.12 (Build:16A323) does not work with. Please be careful!
- In the iOS simulator, work single direction (simulator -> real).


## Credits

Inspired by Mugunth Kumar's [MKiCloudSync](https://github.com/MugunthKumar/MKiCloudSync "MKiCloudSync") (ObjC). Basic idea is due to MKiCloudSync.

## License

Distributed under the MIT License.

## Author

If you wish to contact me, email at: agepro60@gmail.com


