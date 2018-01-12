# Clean Layout
### The cleanest layout possible. Ever.

With clean leayout you can change this:

```swift
viewOne.topAnchor.constraint(equalTo: viewTwo.topAnchor, constant: 10).isActive = true
viewOne.widthAnchor.constraint(equalToConstant: 10).isActive = true
viewOne.heightAnchor.constraint(equalTo: viewOne.widthAnchor, multiplier: 0.71).isActive = true
```

into this:

```swift
viewOne.top |- 10 -| viewTwo.top
viewOne.width |-| 10
viewOne.height |-| (viewOne.width * 0.71)
```


##### Clean Layout format:
* [UIView].[top/bottom/centerY] |- [constant] -| [UIView].[top/bottom/centerY]
* [UIView].[left/right/centerX] |- [constant] -| [UIView].[left/right/centerX]
* [UIView].[width/height] |-| [constant]
* [UIView].[width/height] |-| [UIView].[width/height]
* [UIView].[width/height] |-| ([UIView].[width/height] * [multiplier])
