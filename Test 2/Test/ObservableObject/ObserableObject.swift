//
//  ObserableObject.swift
//  MVVM Learn
//
//  Created by Lai Minh on 26/11/2022.
//

import Foundation
import UIKit


/**
 How  will ViewModel comunicate?
 + Protocol Delegate
 + Closures
 + Property Observers (BOX)
 + Funcion Reactive Programing, Combine
 */

// Property Observers(Box)
final class ObserableObject<T>{
    //
    var value:T{
        didSet{
            listener?(value)
        }
    }
    
    private var listener:((T) -> Void)?
    
    init(_ value:T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T) -> Void ){
        listener(value)
        self.listener = listener
    }
}
