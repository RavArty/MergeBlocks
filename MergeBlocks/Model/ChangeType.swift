//
//  ChangeType.swift
//  MergeBlocks
//
//  Created by Ravshan on 6/12/19.
//  Copyright © 2019 ravkart. All rights reserved.
//

import Foundation

//MARK: Changes color of box to the next one
class ChangeType{
    func changeType(_ box: Box) -> BoxType{
        
        if box.boxType.rawValue != Constants.ColorAmount.quantity{
            return BoxType(rawValue: box.boxType.rawValue + 1)!
        }else{
            return BoxType(rawValue: 1)!
        }
    }
}

