//
//  ViewController.swift
//  WDCollectionViewScalePagingLayout
//
//  Created by 15837003633 on 06/16/2024.
//  Copyright (c) 2024 15837003633. All rights reserved.
//

import UIKit
import WDCollectionViewScalePagingLayout

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(self.my_collectinview)
    }
    
    lazy var my_collectinview: UICollectionView = {
//        let layout = CustomCollectionFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.itemSize = CGSizeMake(100, 300)
//        layout.headerReferenceSize = CGSizeMake(200, 20)
//        layout.sectionInset = .init(top: 50, left: 50, bottom: 50, right: 50)
        
        let layout = WDCollectionViewScalePagingLayout()
        layout.interitemSpacing = 0
        layout.itemSize = CGSize(width: 255, height: 380)
        
        let collecttionview = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collecttionview.delegate = self
        collecttionview.dataSource = self
//        注册cell
        collecttionview.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
//       注册补充视图（这里是header）
//        collecttionview.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CustomHeaderView")
        
        return collecttionview
    }()


}


extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    /*
//    配置补充视图的数据源，也就是foot和header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var headView = UICollectionReusableView()
        if kind == UICollectionView.elementKindSectionHeader {
            headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CustomHeaderView", for: indexPath)
        }
        return headView
    }
     */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
//    配置item的数据源
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.name_label.text = "\(indexPath.row)"
        return cell
    }
    
    
}

