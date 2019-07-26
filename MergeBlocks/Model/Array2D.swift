//
//  Array2D.swift
//  MergeBlocks
//
//  Created by Ravshan on 6/3/19.
//  Copyright © 2019 ravkart. All rights reserved.
//


struct Array2D<T> {
    let columns: Int
    let rows: Int
    private var array: [T?]
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        array = Array<T?>(repeating: nil, count: rows*columns)
    }
    
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[row * columns + column]
        }
        set {
            array[row * columns + column] = newValue
        }
    }
}

