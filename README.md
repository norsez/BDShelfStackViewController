# BDShelfStackViewController

[![CI Status](https://img.shields.io/travis/norsez/BDShelfStackViewController.svg?style=flat)](https://travis-ci.org/norsez/BDShelfStackViewController)
[![Version](https://img.shields.io/cocoapods/v/BDShelfStackViewController.svg?style=flat)](https://cocoapods.org/pods/BDShelfStackViewController)
[![License](https://img.shields.io/cocoapods/l/BDShelfStackViewController.svg?style=flat)](https://cocoapods.org/pods/BDShelfStackViewController)
[![Platform](https://img.shields.io/cocoapods/p/BDShelfStackViewController.svg?style=flat)](https://cocoapods.org/pods/BDShelfStackViewController)

## What is it for?
Tables within tables – the easy way. Veritcally scrollables mixed with horizontally scrollables on one page. Built for quick prototyping or releasing apps that needs product or content browsing, e.g. shopping or showcase apps. 

### Demo app

[![Screen Capture](https://github.com/norsez/BDShelfStackViewController/blob/master/gifdemo.gif?raw=true)](https://youtu.be/2QUPNYsP1xo)

## How to use

`BDShelfStackViewController` only works programmatically with this release. (No Interface Builder Support). Here's how it works. 

`BDShelfStackViewController` is built based on `BDSSVData` defining each row - vertically or horizontally scrollable.  `BDSSVData` is based on `BDSSVRow`s which are delegates  for each row's displayed items.

### What is Shelf Stack? 
For the lack of a common term, we call a table of tables a shelf stack 🤷🏼‍♂️

```swift
import BDShelfStackViewController //import the library
…
class YourViewController: UIViewController {
…
    //A good place to create BDShelfStackViewController is in viewDidLoad
    override func viewDidLoad() {
        //The typical way to use BDShelfStackViewController
        //1. create a BDSSVData made of [BDSSVRow]
        //2. create BDShelfStackViewController with that BDSSVData
        //3. add the BDShelfStackViewController as a child ViewController to your main ViewController. Boom!
        let rows: [BDSSVRow] = [
            self.createDemoRow1(),
            self.createDemoRow2()
            ]
        //create data from the rows
        let data = BDSSVData(withRows: rows)
        //create shelf stack from the data above
        self.demoCtrl = BDShelfStackViewController(nibName:nil, bundle: nil)
        //assign data to and populate the shelf stacks.
        self.demoCtrl.createShelfStack(with: self.data)
        self.view.addSubview(self.demoCtrl)
        self.demoCtrol.view.frame = self.view.bounds
        //add the BDSSVShelfStackViewController as the main view's child viewcontroller
        self.addChildViewController(self.demoCtrl!)
    }
    
    //an example method to create a row
    private func createDemoRow1() {
        //BDSSVRow can be either horizontally or vertically scrollable

        var r = BDSSVRow(withType: .horizontal, 
                    itemCount: 30, 
                    rowHeight: 100)
        //define the size of each item 
        r.itemSize = CGSize(width: 120, height: 100)
        
        //define a block to return a UIView representing each item
        r.viewAtIndex = {
            index in
            let v = CellA(frame: CGRect(x: 0, y: 0, width: 120, height: 100))
            let item = DemoEngine.shared.nextItem
            v.imageView.image = item?.thumbnail
            v.titleLabel.attributedText = "\(item?.name ?? "")".attrText(with: 12)
            v.subtitleLabel.text = item?.artist ?? ""
            return v
        }
        
        //define the action when tapping each item
        r.didTapItem = { index in … }
        
        //there are a few more block variables used to customize each item's behavior and appearance in BDSSVRow
        return r
    }
    
    func reloadSecondStack() {
       //force reload a stack at index 1
       self.demoCtrl.reloadRow(at: 1, flash: true)
    }
}
    
    //That's it! Check out the sample project for a more detailed sample implementation
    
```

Try `README.playground` (Xcode 10 is required) for an interactive tutorial on how to use `BDShelfStackViewController` .

## What's new in 0.0.5
- add `README.playground` 

## What's new in 0.0.4
- remove `init(withData:)`. Now use `createShelfStack(with:)` to initialize the view of shelf stack
- add method to reload the stack at the specified index - `reloadRow(at:,flash:)`
- add `replaceRow(at:,with:)` for replacing a `BDSSVRow` in case you need to completely change both the behavior and the look of a stack row. Each call of this method will expensively recreate the entire shelf stack view.
- add AutoupdatedMixedViewController in Example project to demostrate the use of `reloadRow(at:,flash:)`



## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

BDShelfStackViewController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BDShelfStackViewController'
```

## Author

norsez, norsez@gmail.com

## License

BDShelfStackViewController is available under the MIT license. See the LICENSE file for more info.
