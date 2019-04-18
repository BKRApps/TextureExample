//
//  ASRestaurantNode.swift
//  TextureExampleProject
//
//  Created by kumar reddy on 18/04/19.
//  Copyright © 2019 kumar reddy. All rights reserved.
//

import Foundation
import AsyncDisplayKit

final class ASRestaurantNode: ASCellNode {
    private let nameNode: ASTextNode
    private let addressNode: ASTextNode
    private var commonOfferNode: ASTextNode?
    private var restuarntOfferNode: ASTextNode?
    private var bankOfferNode: ASTextNode?

    var restaurantModel: RestaurantModel!
    
    // called on background thread
    init(model: RestaurantModel) {
        self.restaurantModel = model
        nameNode = ASTextNode()
        addressNode = ASTextNode()
        super.init()
        configureNodes()
        automaticallyManagesSubnodes = true
    }
    
    // called on main thread
    override func didLoad() {
        // everything is attributed text
        configureNodesText()
    }
    
    // called on background thread, render the layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // setting up the stack
        let verticalStackLayout = ASStackLayoutSpec()
        verticalStackLayout.direction = .vertical
        verticalStackLayout.justifyContent = .center
        
        // try here with .end, .center , .start
        verticalStackLayout.alignItems = .center
        
        //adding childs, view logic
        var childs = [ASLayoutElement]()
        childs.append(nameNode)
        childs.append(addressNode)
        if commonOfferNode != nil {
            childs.append(commonOfferNode!)
        }
        if restuarntOfferNode != nil {
            childs.append(restuarntOfferNode!)
        }
        if bankOfferNode != nil {
            childs.append(bankOfferNode!)
        }
        
        // add child array to stack
        verticalStackLayout.children = childs
        let insetLayout = ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16), child: verticalStackLayout)
        return insetLayout
    }
    
    func updateModel(model: RestaurantModel) {
        self.restaurantModel = model
        configureNodes()
        configureNodesText()
        //setNeedsLayout()
    }
}

extension ASRestaurantNode {
    func configureNodes() {
        restaurantModel.commonOffer?.isEmpty == nil ? (commonOfferNode = nil) : (commonOfferNode = ASTextNode())
        restaurantModel.restuarntOffer?.isEmpty == nil ? (restuarntOfferNode = nil) : (restuarntOfferNode = ASTextNode())
        restaurantModel.bankOffer?.isEmpty == nil ? (bankOfferNode = nil) : (bankOfferNode = ASTextNode())
    }
    
    func configureNodesText() {
        SwTextNodeAttributedTextBuilder(text: restaurantModel.name, textNode: nameNode)
            .set(font: UIFont.boldSystemFont(ofSize: 16), textColor: UIColor.black)
            .build()
        SwTextNodeAttributedTextBuilder(text: restaurantModel.address, textNode: addressNode)
            .set(font: UIFont.systemFont(ofSize: 14.0), textColor: UIColor.lightGray)
            .build()
        if commonOfferNode != nil, let text = restaurantModel.commonOffer {
            SwTextNodeAttributedTextBuilder(text: text, textNode: commonOfferNode!)
                .set(font: UIFont.boldSystemFont(ofSize: 13), textColor: UIColor.orange)
                .build()
        }
        if restuarntOfferNode != nil, let text = restaurantModel.restuarntOffer {
            SwTextNodeAttributedTextBuilder(text: text, textNode: restuarntOfferNode!)
                .set(font: UIFont.boldSystemFont(ofSize: 13), textColor: UIColor.purple)
                .build()
        }
        if bankOfferNode != nil, let text = restaurantModel.bankOffer {
            SwTextNodeAttributedTextBuilder(text: text, textNode: bankOfferNode!)
                .set(font: UIFont.boldSystemFont(ofSize: 13), textColor: UIColor.red)
                .build()
        }
    }
}
