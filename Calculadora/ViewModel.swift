//
//  ViewModel.swift
//  Calculadora
//
//  Created by Álvaro Gascón on 2/2/24.
//

import Foundation

final class ViewModel: ObservableObject {
    @Published var textFieldValue: String = "0"
    
    var textFieldSavedValue: String = "0" // Almacenar el valor anterior
    var currentOperationToExecute: OperationType? // Almacenar la operación que quiero hacer con el valor anterior y el nuevo
    var shouldRunOperation: Bool = false // Saber si debo realizar alguna operación
    
    
    func logic(key: KeybaoardButton) {
        switch key.type {
        case .number(let value):
            if shouldRunOperation {
                textFieldValue = "\(value)"
                shouldRunOperation = false // Restablecer la bandera después de ingresar un nuevo número
            } else {
                textFieldValue = textFieldValue == "0" ? "\(value)" : textFieldValue + "\(value)"
            }
        case .reset:
            textFieldValue = "0"
            textFieldSavedValue = "0"
            currentOperationToExecute = nil
            shouldRunOperation = false
        case .result:
            guard let operation = currentOperationToExecute else {
                return
            }
            
            switch operation {
            case .multiplication:
                textFieldValue = "\(Int(textFieldValue)! * Int(textFieldSavedValue)!)"
            case .sum:
                textFieldValue = "\(Int(textFieldValue)! + Int(textFieldSavedValue)!)"
            case .subtract:
                textFieldValue = "\(Int(textFieldSavedValue)! - Int(textFieldValue)!)"
            case .division:
                guard Int(textFieldValue) != 0 else {
                    // Manejar la división por cero aquí si es necesario
                    textFieldValue = "Error"
                    return
                }
                textFieldValue = "\(Int(textFieldSavedValue)! / Int(textFieldValue)!)"
            }
        case .operation(let type):
            textFieldSavedValue = textFieldValue
            currentOperationToExecute = type
            shouldRunOperation = true
        }
    }
}
