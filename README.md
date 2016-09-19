# RBHUD

[![Version](https://img.shields.io/badge/version-0.0.3-green.svg?style=flat)](http://cocoapods.org/pods/RBHUD)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://cocoapods.org/pods/RBHUD)
[![Platform](http://img.shields.io/badge/iOS-8.3%2B-blue.svg?style=flat)]()
[![Language](https://img.shields.io/badge/Swift-3-orange.svg?style=flat)]() 

HUD written in **Swift** - Ready to use, no muss, no fuss...

![RBHUD written in Swift](https://github.com/robertBojor/RBHUD/blob/master/hud_gif.gif)

## How To
### Install it using CocoaPods

```
use_frameworks!
pod "RBHUD", :git => "https://github.com/robertBojor/RBHUD.git", :tag => "0.0.3"
```

After running `pod update`, and opening the workspace file, you will need add the framework in the **Linked Frameworks and Libraries** and also under the **Build Phases > Link Binary With Libraries**. Once correctly linked, just build once to make sure it works, and you did everything correctly.

All you'll need now is to `import RBHUD` in the classes where you want to use it - That's it!

### Install it manually
Download the archived repo, unzip it on your drive somewhere and just drag the RBHUD.swift file into your project and start using it - That's it!

### Use it in your project
- Declare a variable in your ViewController
```
let hud = RBHUD.sharedInstance
```
- Configure the HUD using any of the 15 available options. Ommitting any of the configuration variables will make the HUD load the defaults ( the actual values seen below )
```
self.hud.backdropOpacity = 0.8    // The opacity of the background
self.hud.backdropUsesBlur = true    // Option for the background if it should use a blur effect or not
self.hud.backdropBlurStyle = UIBlurEffectStyle.dark   // The blur style, if it's using a blue effect
self.hud.backdropColor = UIColor(red:0.23, green:0.26, blue:0.29, alpha:1)    // The background color of the overlay, if not using a blur effect

self.hud.progressViewLineWidth = 1.0    // The progress indicator line width
self.hud.progressViewSize = 64.0   // The progress indicator's size on the screen
self.hud.progressViewPadding = 10.0   // The top and bottom padding between the progress indicator and any other elements on the screen
self.hud.progressViewStrokeColor = UIColor.white   // The color of the progress view stroke line
self.hud.progressViewFillColor = UIColor.clear   // The fill color of the progress view

self.hud.successViewLineWidth = 1.0     // The line width for the success mark
self.hud.successViewStrokeColor = UIColor.green      // The line color for the success mark

self.hud.errorViewLineWidth = 1.0       // The line width for the error mark
self.hud.errorViewStrokeColor = UIColor.red      // The line color for the error mark


self.hud.labelAnimationDistance = 50.0    // The distance the text labels have to travel when appearing
self.hud.labelFontName = "HelveticaNeue-Light"    // The font name for the text labels
self.hud.labelTitleFontSize = 20.0    // The font size for the title label
self.hud.labelTitleTextColor = UIColor.white   // The text color of the title label

self.hud.labelSubtitleFontSize = 13.0   // The font size for the subtitle label
self.hud.labelSubtitleTextColor = UIColor.white    // The text color for the subtitle label
```

- Call the show method
```
self.hud.showLoader(inView:UIView!, withTitle:String?, withSubTitle:String?, withProgress:Bool)
```
The `showLoader` method has 4 parameters, 2 of which are optional:

- `inView:UIView` is the view in which you want the HUD to be shown in, usually `self.view`
- `withTitle:String?` is the text string that will be shown as a title when the loader is presented. When sending this as `nil`, the HUD will not present a title text
- `withSubTitle:String?` is the text string that will be shown as a subtitle when the loader is presented. When sending this as `nil`, the HUD will not present a subtitle text
- `withProgress:Bool` If you want the HUD to present an undeterminate progress indicator, set this to `true`, otherwise set this to `false`

If at any step in your code, you need to update the HUD's look, like for example change the title text and add a progress indicator, you can do so by calling the `showLoader` method again using the new parameters, and the HUD will update itself with the new data while still being presented.

- Call the show with a success mark method
```
self.hud.showWithSuccess(self.view, withTitle: "Success", withSubTitle: "The task ended up successfully!")
```
The `showWithSuccess` method has 3 parameters, 2 of which are optional:

- `inView:UIView` is the view in which you want the HUD to be shown in, usually `self.view`
- `withTitle:String?` is the text string that will be shown as a title when the loader is presented. When sending this as `nil`, the HUD will not present a title text
- `withSubTitle:String?` is the text string that will be shown as a subtitle when the loader is presented. When sending this as `nil`, the HUD will not present a subtitle text

- Call the show with an error mark method
```
self.hud.showWithError(self.view, withTitle: "Oops", withSubTitle: "En error occured!")
```
The `showWithError` method has 3 parameters, 2 of which are optional:

- `inView:UIView` is the view in which you want the HUD to be shown in, usually `self.view`
- `withTitle:String?` is the text string that will be shown as a title when the loader is presented. When sending this as `nil`, the HUD will not present a title text
- `withSubTitle:String?` is the text string that will be shown as a subtitle when the loader is presented. When sending this as `nil`, the HUD will not present a subtitle text

Both `showWithError` and `showWithSuccess` methods are going to close the HUD in a few seconds, so there's no need to call the hide method.

- Call the hide method when you're done with your the long action
```
self.hud.hideLoader()
```

## Usage examples

The standard way of using the HUD will resemble the code below...
```
self.hud.showLoader(self.view, withTitle:"Testing", withSubTitle:nil, withProgress:true)
DispatchQueue.global().async {
    // Your longer task code goes here...
    DispatchQueue.main.async {
        self.hud.hideLoader()
    }
}
```

If at any step in your code, you need to update the HUD's look, like for example change the title text and add a progress indicator, you can do so by calling the `showLoader` method again using the new parameters, and the HUD will update itself with the new data while still being presented. For example:
```
func someMethod()
{
    self.hud.showLoader(self.view, withTitle:"Testing", withSubTitle: nil, withProgress:true)
    
    DispatchQueue.global().async {
        // Your longer task code goes here...
        if self.thisVar == 0 {
            self.hud.showLoader(self.view, withTitle:"New title", withSubTitle:"and subtitle", withProgress:false)
            self.someOtherMethod()
        }
        DispatchQueue.main.async {
            self.hud.hideLoader()
        }
    }
}

func someOtherMethod()
{
    // Your logic here...
    DispatchQueue.main.async {
        self.hud.hideLoader()
    }
}
```

The Xcode project attached to the repo also contains exmaples of calling and hiding the HUD.

## ToDo

- Add an option for the overlay to partially cover the screen, rounded corners included

## Author

Robert Bojor, robert.bojor@gmail.com

## License

RBHUD is available under the MIT license. See the LICENSE file for more info.
