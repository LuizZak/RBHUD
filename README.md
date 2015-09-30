# RBHUD

[![CI Status](http://img.shields.io/travis/Robert Bojor/RBHUD.svg?style=flat)](https://travis-ci.org/Robert Bojor/RBHUD)
[![Version](https://img.shields.io/cocoapods/v/RBHUD.svg?style=flat)](http://cocoapods.org/pods/RBHUD)
[![License](https://img.shields.io/cocoapods/l/RBHUD.svg?style=flat)](http://cocoapods.org/pods/RBHUD)
[![Platform](https://img.shields.io/cocoapods/p/RBHUD.svg?style=flat)](http://cocoapods.org/pods/RBHUD)

HUD written in **Swift** - Ready to use, no muss, no fuss...

## How To
Drag the RBHUD.swift file into your project and start using it - That's it!

- Declare a variable in your ViewController
```
let hud = RBHUD.sharedInstance
```
- Configure the HUD using any of the 15 available options. Ommitting any of the configuration variables will make the HUD load the defaults ( the actual values seen below )
```
self.hud.backdropOpacity = 0.8    // The opacity of the background
self.hud.backdropUsesBlur = true    // Option for the background if it should use a blur effect or not
self.hud.backdropBlurStyle = UIBlurEffectStyle.Dark   // The blur style, if it's using a blue effect
self.hud.backdropColor = UIColor(red:0.23, green:0.26, blue:0.29, alpha:1)    // The background color of the overlay, if not using a blur effect

self.hud.progressViewLineWidth = 1.0    // The progress indicator line width
self.hud.progressViewSize = 64.0   // The progress indicator's size on the screen
self.hud.progressViewPadding = 10.0   // The top and bottom padding between the progress indicator and any other elements on the screen
self.hud.progressViewStrokeColor = UIColor.whiteColor()   // The color of the progress view stroke line
self.hud.progressViewFillColor = UIColor.clearColor()   // The fill color of the progress view

self.hud.labelAnimationDistance = 50.0    // The distance the text labels have to travel when appearing
self.hud.labelFontName = "HelveticaNeue-Light"    // The font name for the text labels
self.hud.labelTitleFontSize = 20.0    // The font size for the title label
self.hud.labelTitleTextColor = UIColor.whiteColor()   // The text color of the title label

self.hud.labelSubtitleFontSize = 13.0   // The font size for the subtitle label
self.hud.labelSubtitleTextColor = UIColor.whiteColor()    // The text color for the subtitle label
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

- Call the hide method when you're done with your the long action
```
self.hud.hideLoader()
```

## Usage examples

The standard way of using the HUD will resemble the code below...
```
self.hud.showLoader(self.view, withTitle:"Testing", withSubTitle:nil, withProgress:true)
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
    // Your longer task code goes here...
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
        self.hud.hideLoader()
    })
})
```

If at any step in your code, you need to update the HUD's look, like for example change the title text and add a progress indicator, you can do so by calling the `showLoader` method again using the new parameters, and the HUD will update itself with the new data while still being presented. For example:
```
func someMethod()
{
    self.hud.showLoader(self.view, withTitle:"Testing", withSubTitle:nil, withProgress:true)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
        // Your longer task code goes here...
        if self.thisVar == 0 {
            self.hud.showLoader(self.view, withTitle:"New title", withSubTitle:"and subtitle", withProgress:false)
            self.someOtherMethod()
        }
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.hud.hideLoader()
        })
    })
}

func someOtherMethod()
{
    // Your logic here...
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
        self.hud.hideLoader()
    })
}
```

The Xcode project attached to the repo also contains exmaples of calling and hiding the HUD.

## ToDo

- Add an option for the overlay to partially cover the screen, rounded corners included
- Add a `showWithSuccess` method that will display a checkmark
- Add a `showWithError` method that will display an error message and an error mark

## Author

Robert Bojor, robert.bojor@gmail.com

## License

RBHUD is available under the MIT license. See the LICENSE file for more info.
