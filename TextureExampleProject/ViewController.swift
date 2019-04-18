//
//  ViewController.swift
//  TextureExampleProject
//
//  Created by kumar reddy on 18/04/19.
//  Copyright © 2019 kumar reddy. All rights reserved.
//

import UIKit
import AsyncDisplayKit


class ViewController: ASViewController<ASDisplayNode> {
    
    //    var tableNode: ASCollectionNode!
    var tableNode: ASTableNode!
    var selectedIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    var restaurantData: [RestaurantModel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode = ASTableNode(style: UITableView.Style.plain)
        self.view.addSubview(tableNode.view)
        self.view.backgroundColor = UIColor.red
        buildDataSource()
        tableNode.dataSource = self
        tableNode.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableNode.view.frame = self.view.frame
        
    }
    
}

extension ViewController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return restaurantData.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let model = restaurantData[indexPath.row]
        return {
            let cell = ASRestaurantNode(model: model)
            return cell
        }
    }
}

extension ViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        if let node = tableNode.nodeForRow(at: indexPath) as? ASRestaurantNode {
            node.updateModel(model: RestaurantModel(name: "Eat Fit", address: "HSR", commonOffer: "10% on all orders", restuarntOffer: "15 % on Healthy food", bankOffer: "100 cashback on PayTm"))
        }
    }
}

extension ViewController {
    func buildDataSource() {
        restaurantData = [RestaurantModel]()
        restaurantData.append(RestaurantModel(name: "Paradise Biryani", address: "Koramangala 1st Block", commonOffer: "10% on all orders above Rs.300. 10% on all orders above Rs.300. 10% on all orders above Rs.300", restuarntOffer: nil, bankOffer: nil))
        restaurantData.append(RestaurantModel(name: "Krutunga Restaurant", address: "Koramangala 5th Block", commonOffer: "20% on all orders above Rs.99", restuarntOffer: nil, bankOffer: "Extra 5% off on all HDFC cards"))
        restaurantData.append(RestaurantModel(name: "Eat Fit", address: "HSR", commonOffer: "20% on all orders", restuarntOffer: "15% on Milk Shakes", bankOffer: "Extra 100 cashback when you pay with PayTm"))
        restaurantData.append(RestaurantModel(name: "Biryani House", address: "Koramangala 1st Block", commonOffer: "10% on all orders above Rs.300", restuarntOffer: nil, bankOffer: nil))
        restaurantData.append(RestaurantModel(name: "Fassos Restaurant", address: "Koramangala 5th Block", commonOffer: "20% on all orders above Rs.99", restuarntOffer: nil, bankOffer: "Extra 5% off on all HDFC cards"))
        restaurantData.append(RestaurantModel(name: "Udupi Palace", address: "HSR", commonOffer: "20% on all orders", restuarntOffer: "15% on Milk Shakes", bankOffer: "Extra 100 cashback when you pay with PayTm"))
        restaurantData.append(RestaurantModel(name: "Chai Point", address: "Koramangala 1st Block", commonOffer: "10% on all orders above Rs.300", restuarntOffer: nil, bankOffer: nil))
        restaurantData.append(RestaurantModel(name: "Shree Khana Khazana", address: "Koramangala 5th Block", commonOffer: "20% on all orders above Rs.99", restuarntOffer: nil, bankOffer: "Extra 5% off on all HDFC cards"))
        restaurantData.append(RestaurantModel(name: "Rolls on Wheels", address: "HSR", commonOffer: "20% on all orders", restuarntOffer: "15% on Milk Shakes", bankOffer: "Extra 100 cashback when you pay with PayTm"))
    }
}

