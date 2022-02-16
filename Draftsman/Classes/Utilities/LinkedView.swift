//
//  ViewOutlet.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 16/02/22.
//

import Foundation

@propertyWrapper
public class LinkedView<View: UIView> {
    internal var _wrappedValue: View?
    public var wrappedValue: View {
        get {
            guard let view = _wrappedValue else {
                let newView = View()
                _wrappedValue = newView
                return newView
            }
            return view
        }
        set {
            _wrappedValue = newValue
        }
    }
    
    public var projectedValue: LinkedView<View> { self }
    
    public init() { }
}
