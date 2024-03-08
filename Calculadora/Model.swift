//
//  Model.swift
//  Calculadora
//
//  Created by Álvaro Gascón on 1/2/24.
//

import Foundation
import SwiftUI


struct KeybaoardButton: Hashable {
    let title: String
    let textColor: Color
    let backgroundColor: Color
    let isDoubleWidth: Bool
    let type: ButtonType
}

enum ButtonType: Hashable {
    case number(Int)
    case operation(OperationType)
    case result
    case reset
}

enum OperationType {
    case sum
    case subtract
    case multiplication
    case division
}





