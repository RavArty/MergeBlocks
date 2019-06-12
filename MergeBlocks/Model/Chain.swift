//
//  Chain.swift
//  MergeBlocks
//
//  Created by Ravshan on 6/11/19.
//  Copyright © 2019 ravkart. All rights reserved.
//

class Chain: Hashable, CustomStringConvertible {
    var boxes: [Box] = []
    
    enum ChainType: CustomStringConvertible {
        case none
        case horizontalAll
        case verticalAll
        case horizontal2
        case vertical
        case vertical3
        case threehorizon
        case thorizon
        case tLeft
        case tRight
        case tUpsideDown
        case rightL
        case leftL
        case upsideDownRightL
        case upsideDownLeftL
        case quadro
        
        var description: String {
            switch self {
            case .none: return Constants.Shapes.ShapeType.none.rawValue
            case .horizontalAll: return Constants.Shapes.ShapeType.horizontalAll.rawValue
            case .verticalAll: return Constants.Shapes.ShapeType.verticalAll.rawValue
            case .horizontal2: return Constants.Shapes.ShapeType.horizontal2.rawValue
            case .vertical: return Constants.Shapes.ShapeType.vertical.rawValue
            case .vertical3: return Constants.Shapes.ShapeType.vertical3.rawValue
            case .threehorizon: return Constants.Shapes.ShapeType.threehorizon.rawValue
            case .thorizon: return Constants.Shapes.ShapeType.Thorizontal.rawValue
            case .tLeft: return Constants.Shapes.ShapeType.TLeft.rawValue
            case .tRight: return Constants.Shapes.ShapeType.TRight.rawValue
            case .tUpsideDown: return Constants.Shapes.ShapeType.TUpsideDown.rawValue
            case .rightL: return Constants.Shapes.ShapeType.rightL.rawValue
            case .leftL: return Constants.Shapes.ShapeType.leftL.rawValue
            case .upsideDownLeftL: return Constants.Shapes.ShapeType.upsideDownLeftL.rawValue
            case .upsideDownRightL: return Constants.Shapes.ShapeType.upsideDownRightL.rawValue
            case .quadro: return Constants.Shapes.ShapeType.Quadro.rawValue
                
            }
        }
    }
    //   var chainType: Constants.Shapes.ChainType
    var chainType: ChainType
    
    init(chainType: ChainType) {
        self.chainType = chainType
    }
    
    func add(box: Box) {
        boxes.append(box)
    }
    
    func firstBox() -> Box {
        return boxes[0]
    }
    func secondBox() -> Box{
        return boxes[1]
    }
    func thirdBox() -> Box{
        return boxes[2]
    }
    func fourth() -> Box{
        return boxes[3]
    }
    
    func lastBox() -> Box {
        return boxes[boxes.count - 1]
    }
    
    var length: Int {
        return boxes.count
    }
    
    var description: String {
        return "type:\(chainType) boxes:\(boxes)"
    }
    
    func hash(into hasher: inout Hasher) {}
    
    static func ==(lhs: Chain, rhs: Chain) -> Bool {
        return lhs.boxes == rhs.boxes
    }
}

