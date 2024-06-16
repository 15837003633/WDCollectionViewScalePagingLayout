# WDCollectionViewScalePagingLayout

自定义UICollectionViewLayout，实现分页缩放滚动效果

```
    lazy var my_collectinview: UICollectionView = {
        let layout = WDCollectionViewScalePagingLayout()
        layout.interitemSpacing = 0
        layout.itemSize = CGSize(width: 255, height: 380)
        
        let collecttionview = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collecttionview.delegate = self
        collecttionview.dataSource = self
//        注册cell
        collecttionview.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
        return collecttionview
    }()
```

![Simulator Screenshot - iPhone 15 Pro - 2024-06-16 at 23 19 24](https://github.com/15837003633/WDCollectionViewScalePagingLayout/assets/6936198/3e6f3894-3230-4092-b06c-f55e4fb1f8a1)



[![CI Status](https://img.shields.io/travis/15837003633/WDCollectionViewScalePagingLayout.svg?style=flat)](https://travis-ci.org/15837003633/WDCollectionViewScalePagingLayout)
[![Version](https://img.shields.io/cocoapods/v/WDCollectionViewScalePagingLayout.svg?style=flat)](https://cocoapods.org/pods/WDCollectionViewScalePagingLayout)
[![License](https://img.shields.io/cocoapods/l/WDCollectionViewScalePagingLayout.svg?style=flat)](https://cocoapods.org/pods/WDCollectionViewScalePagingLayout)
[![Platform](https://img.shields.io/cocoapods/p/WDCollectionViewScalePagingLayout.svg?style=flat)](https://cocoapods.org/pods/WDCollectionViewScalePagingLayout)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

WDCollectionViewScalePagingLayout is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WDCollectionViewScalePagingLayout'
```

## Author

15837003633, 50165459@qq.com

## License

WDCollectionViewScalePagingLayout is available under the MIT license. See the LICENSE file for more info.

