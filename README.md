# LeagueMobileChallenge

APP for the challenge

Technical specifications of the app Architecture: The MVVM or Model-View-ViewModel architecture was used, even though it is a simple app with a screen, this architecture was chosen thinking that new features could be added, and when it was done, it would be easier, because the app is respecting the majority of SOLID principles. 

UI: I used a mixture of view code and swiftUI views, I prefer write views using view code than storyboard or xibs, it helps handle in a better way, merge conflicts, and swiftUI is there because that is the new way to build views, it is easier and it reflects a lot of nowadays projects where there is mix of view code and swiftui views.

Language: Swift 5 was used.

Version support: The app supports iOS 13.

Dependency manager Cocoapods was used.

Pods: Only Alamofire and Kingfisher were used, the rest was done natively, making the app lighter and faster to build

Points that could be improved: 
Add a coodinator layer as the base code is using view code, it would be better to use some kind of Coodinator object to handle de navigation in the app.
Add a Depency injection handler object to make easier to create controllers and consequently flows.
Add Snapshot tests
Add more unit testing, to handle error cases.
Add some CI/CD tool (fastlane, jenkins/bitrise for example)

Instructions for testing the app: Just open the LeagueMobileChallenge.xcworkspace and build it and run.uctions for testing the app: Just open the LeagueMobileChallenge.xcworkspace and build it and run.