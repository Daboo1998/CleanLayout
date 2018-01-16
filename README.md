# Clean Layout
### The cleanest layout possible. Ever.

With clean leayout you can change this:

```swift
viewOne.topAnchor.constraint(equalTo: viewTwo.topAnchor, constant: 10).isActive = true
viewOne.widthAnchor.constraint(equalToConstant: 10).isActive = true
viewOne.heightAnchor.constraint(equalTo: viewOne.widthAnchor, multiplier: 0.71).isActive = true
viewOne.leftAnchor.constraint(greaterThanOrEqualTo: viewTwo.rightAnchor, constant: 5).isActive = true

let constraint: NSLayoutConstraint = viewOne.topAnchor.constraint(equalTo: viewTwo.topAnchor, constant: 10)
constraint.isActive = true

...

constraint.isActive = false
```

into this:

```swift
viewOne.top |- 10 -| viewTwo.top
viewOne.width |-| 10
viewOne.height |-| (viewOne.width * 0.71)
viewOne.left |- >=5 -| viewTwo.right

let constraint = (viewOne.top |- 10 -| viewTwo.top)

...

constraint.isActive = false

```
## Installation

### CocoaPods

Use the following entry in your Podfile:

```rb
pod 'CleanLayout'
```

Then run `pod install`

In any file you'd like to use CleanLayout in, don't forget to import the framework with import `CleanLayout`.

### Carthage

Make the following entry in your Cartfile:

```
github "Daboo1998/CleanLayout"
```

Then run `carthage update`.

If this is your first time using Carthage in the project, you'll need to go through some additional steps as explained [over at Carthage](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

### Manually

Open up Terminal, cd into your top-level project directory, and run the following command if your project is not initialized as a git repository:

```bash
$ git init
```

Add CleanLout as a git submodule by running the following commands:

```bash
$ git submodule add https://github.com/Daboo1998/CleanLayout.git
```

Open the new `CleanLayout` folder, and drag the `CleanLayout.xcodeproj` into the Project Navigator of your application's Xcode project.
It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.
Verify that the deployment targets of the `xcodeproj` match that of your application target in the Project Navigator.
Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
In the tab bar at the top of that window, open the "General" panel.
Click on the `+` button under the "Embedded Binaries" section.
Select the top `CleanLayout.framework`.

And that's it!

The framework is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.

## Usage

Use the below format:

##### Clean Layout format:
* [UIView].[top/bottom/centerY] |- [optional: >=/<=][constant] -| [UIView].[top/bottom/centerY]
* [UIView].[left/right/centerX] |- [optional: >=/<=][constant] -| [UIView].[left/right/centerX]
* [UIView].[width/height] |-| [constant]
* [UIView].[width/height] |-| [UIView].[width/height]
* [UIView].[width/height] |-| ([UIView].[width/height] * [multiplier])

##### Example
```swift
viewOne.top |- 10 -| viewTwo.top
viewOne.bottom |- >= 5 -| viewTwo.bottom
```

### It's only that simple! 
Wish you happy and stress free coding :-)
