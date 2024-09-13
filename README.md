## Development Setup

Before you begin, you should already have the Xcode downloaded and set up correctly. You can find a guide on how to do this here: [Setting up Xcode](https://developer.apple.com/xcode/)

##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Steps to install Cocoapods (one time installation)

- Run `sudo gem install cocoapods` to install the latest version of cocoapods. To install cocoapods from HomeBrew, `brew install cocoapods`.

-  Next, run `pod setup` for setting up cocoapods master repo. You may include `--verbose` for more descriptive logs.


**NOTE:** This might take a while to setup depending on your network speed.

## Setting up the iOS Project

1. Download the _CatAPI-iOS_ project source. You can do this by cloning the repository or by downloading it as a ZIP file and extracting it. OR
```
$ git clone https://github.com/richardessemiah/CatAPI-SwiftUI
```

2. Navigate to the unzipped folder and run `pod install`.

3. Create `env-ios.xcconfig` and add your Cat `API_KEY ` 


4. Open `SprintTreeProject.xcworkspace` from the folder.


### Known bugs

- Selecting a image from home screen doesn't work well.
- Fetching the favorites and votes on profile screen works but it doesn't show.

These are because I'm not firmilar with Combine framework, which works perfectly fine with SwiftUI
