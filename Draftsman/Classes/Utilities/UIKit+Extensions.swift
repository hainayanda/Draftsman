//
//  UIKit+Extensions.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 07/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

fileprivate func assignIfDifferent<V: Equatable>(into: inout V, value: V) {
    guard into != value else { return }
    into = value
}

extension UIView: Buildable { }

extension UILabel {
    public var textCompat: TextCompatible? {
        set {
            if let attributedText = newValue as? NSAttributedString {
                self.attributedText = attributedText
            } else if let text = newValue as? String {
                self.text = text
            } else {
                self.text = nil
            }
        }
        get {
            return attributedText
        }
    }
}

public protocol TextCompatible {
    var text: String { get }
    var attributedText: NSAttributedString { get }
}

extension String: TextCompatible {
    public var text: String { self }
    public var attributedText: NSAttributedString { .init(string: self) }
}
extension NSAttributedString: TextCompatible {
    public var text: String { self.string }
    public var attributedText: NSAttributedString { self }
}

extension UIImageView {
    
    public var imageCompat: ImageCompatible? {
        set {
            guard let value = newValue else {
                self.image = nil
                self.animationImages = nil
                return
            }
            if let animation = value.animation {
                assignIfDifferent(into: &animationImages, value: animation.images)
                assignIfDifferent(into: &animationDuration, value: animation.duration)
                assignIfDifferent(into: &animationRepeatCount, value: animation.repeatCount)
                if animation.animating {
                    self.startAnimating()
                } else {
                    self.stopAnimating()
                }
                self.image = nil
            } else if let image = value.image {
                self.image = image
                self.animationImages = nil
            } else if value.isAsync {
                value.getAsync { [weak self] image in
                    self?.imageCompat = image
                }
            } else {
                self.image = nil
                self.animationImages = nil
            }
        }
        get {
            if let image = self.image {
                return image
            } else if let images = self.animationImages {
                return Animation(
                    images: images,
                    duration: self.animationDuration,
                    animating: self.isAnimating,
                    repeatCount: self.animationRepeatCount
                )
            }
            return nil
        }
    }
    
    public class Animation: Equatable {
        
        public var images: [UIImage]
        public var duration: TimeInterval
        public var animating: Bool
        public var repeatCount: Int
        
        public init(images: [UIImage], duration: TimeInterval, animating: Bool = true, repeatCount: Int = 0) {
            self.images = images
            self.duration = duration
            self.animating = animating
            self.repeatCount = repeatCount
        }
        
        public static func == (lhs: UIImageView.Animation, rhs: UIImageView.Animation) -> Bool {
            lhs.images == rhs.images && lhs.duration == rhs.duration
                && lhs.animating == rhs.animating && lhs.repeatCount == rhs.repeatCount
        }
    }
}

public protocol ImageCompatible {
    var animation: UIImageView.Animation? { get }
    var image: UIImage? { get }
    var isAsync: Bool { get }
    func getAsync(_ completion: (ImageCompatible?) -> Void)
}

extension UIImage: ImageCompatible {
    public var animation: UIImageView.Animation? { nil }
    public var image: UIImage? { self }
    public var isAsync: Bool { false }
    public func getAsync(_ completion: (ImageCompatible?) -> Void) {
        completion(self)
    }
}
extension UIImageView.Animation: ImageCompatible {
    public var animation: UIImageView.Animation? { self }
    public var image: UIImage? { nil }
    public var isAsync: Bool { false }
    public func getAsync(_ completion: (ImageCompatible?) -> Void) {
        completion(self)
    }
}

extension Data: ImageCompatible {
    public var animation: UIImageView.Animation? { nil }
    public var image: UIImage? { UIImage(data: self) }
    public var isAsync: Bool { false }
    public func getAsync(_ completion: (ImageCompatible?) -> Void) {
        completion(self.image)
    }
}

extension UIButton {
    
    struct AssociatedKey {
        static var tappedClosure: String = "Draftsman_Tapped_Closure"
    }
    
    @objc class TappedClosure: NSObject {
        let closure: (UIButton) -> Void
        
        init(_ closure: @escaping (UIButton) -> Void) {
            self.closure = closure
        }
        
        @objc func invoke(with sender: UIButton) {
            closure(sender)
        }
    }
    
    public func whenDidTapped(then: @escaping (UIButton) -> Void) {
        let tappedClosure = TappedClosure(then)
        addTarget(tappedClosure, action: #selector(TappedClosure.invoke(with:)), for: .touchUpInside)
        objc_setAssociatedObject(self, &AssociatedKey.tappedClosure, tappedClosure, .OBJC_ASSOCIATION_RETAIN)
    }
    
    public func whenDidTapped<Observer: AnyObject>(observing observer: Observer, then: @escaping (Observer, UIButton) -> Void) {
        let eventClosure = TappedClosure { [weak observer] button in
            guard let observer = observer else { return }
            then(observer, button)
        }
        addTarget(eventClosure, action: #selector(TappedClosure.invoke(with:)), for: .touchUpInside)
        objc_setAssociatedObject(self, &AssociatedKey.tappedClosure, eventClosure, .OBJC_ASSOCIATION_RETAIN)
    }
    
    public func whenDidTapped<Observer: AnyObject>(observing observer: Observer, thenCall method: @escaping (Observer) -> ((UIButton) -> Void)) {
        let eventClosure = TappedClosure { [weak observer] button in
            guard let observer = observer else { return }
            method(observer)(button)
        }
        addTarget(eventClosure, action: #selector(TappedClosure.invoke(with:)), for: .touchUpInside)
        objc_setAssociatedObject(self, &AssociatedKey.tappedClosure, eventClosure, .OBJC_ASSOCIATION_RETAIN)
    }
}

extension UITextField {
    
    public var textCompat: TextCompatible? {
        set {
            if let attributedText = newValue as? NSAttributedString {
                self.attributedText = attributedText
            } else if let text = newValue as? String {
                self.text = text
            } else {
                self.text = nil
            }
        }
        get {
            return attributedText
        }
    }
    
    public var placeholderCompat: TextCompatible? {
        set {
            if let attributedText = newValue as? NSAttributedString {
                self.attributedPlaceholder = attributedText
            } else if let text = newValue as? String {
                self.placeholder = text
            } else {
                self.placeholder = nil
            }
        }
        get {
            return attributedPlaceholder
        }
    }
}

extension UITextView {
    
    public var textCompat: TextCompatible? {
        set {
            if let attributedText = newValue as? NSAttributedString {
                self.attributedText = attributedText
            } else if let text = newValue as? String {
                self.text = text
            } else {
                self.text = nil
            }
        }
        get {
            return attributedText
        }
    }
}

extension UIControl {
    
    struct AssociatedKey {
        static var touchDown: String = "Draftsman_touchDown_event"
        static var touchDownRepeat: String = "Draftsman_touchDownRepeat_event"
        static var touchDragInside: String = "Draftsman_touchDragInside_event"
        static var touchDragOutside: String = "Draftsman_touchDragOutside_event"
        static var touchDragEnter: String = "Draftsman_touchDragEnter_event"
        static var touchDragExit: String = "Draftsman_touchDragExit_event"
        static var touchUpInside: String = "Draftsman_touchUpInside_event"
        static var touchUpOutside: String = "Draftsman_touchUpOutside_event"
        static var touchCancel: String = "Draftsman_touchCancel_event"
        static var valueChanged: String = "Draftsman_valueChanged_event"
        static var primaryActionTriggered: String = "Draftsman_primaryActionTriggered_event"
        @available(iOS 14.0, *)
        static var menuActionTriggered: String = "Draftsman_menuActionTriggered_event"
        static var editingDidBegin: String = "Draftsman_editingDidBegin_event"
        static var editingChanged: String = "Draftsman_editingChanged_event"
        static var editingDidEnd: String = "Draftsman_editingDidEnd_event"
        static var editingDidEndOnExit: String = "Draftsman_editingDidEndOnExit_event"
        static var allTouchEvents: String = "Draftsman_allTouchEvents_event"
        static var allEditingEvents: String = "Draftsman_allEditingEvents_event"
        static var applicationReserved: String = "Draftsman_applicationReserved_event"
        static var systemReserved: String = "Draftsman_systemReserved_event"
        static var allEvents: String = "Draftsman_allEvents_event"
        
        static var eventKeys: [UIControl.Event: UnsafeRawPointer] {
            var keys: [UIControl.Event: UnsafeRawPointer] = [
                .touchDown: .init(&touchDown),
                .touchDownRepeat: .init(&touchDownRepeat),
                .touchDragInside: .init(&touchDragInside),
                .touchDragOutside: .init(&touchDragOutside),
                .touchDragEnter: .init(&touchDragEnter),
                .touchDragExit: .init(&touchDragExit),
                .touchUpInside: .init(&touchUpInside),
                .touchUpOutside: .init(&touchUpOutside),
                .touchCancel: .init(&touchCancel),
                .valueChanged: .init(&valueChanged),
                .primaryActionTriggered: .init(&primaryActionTriggered),
                .editingDidBegin: .init(&editingDidBegin),
                .editingChanged: .init(&editingChanged),
                .editingDidEnd: .init(&editingDidEnd),
                .editingDidEndOnExit: .init(&editingDidEndOnExit),
                .allTouchEvents: .init(&allTouchEvents),
                .allEditingEvents: .init(&allEditingEvents),
                .applicationReserved: .init(&applicationReserved),
                .systemReserved: .init(&systemReserved),
                .allEvents: .init(&allEvents)
            ]
            if #available(iOS 14.0, *) {
                keys[.menuActionTriggered] = .init(&menuActionTriggered)
            }
            return keys
        }
    }
    
    @objc class EventClosure: NSObject {
        let closure: (UIControl) -> Void
        
        init(_ closure: @escaping (UIControl) -> Void) {
            self.closure = closure
        }
        
        @objc func invoke(with sender: UIControl) {
            closure(sender)
        }
    }
    
    public func whenDidTriggered(by event: UIControl.Event, then: @escaping (UIControl) -> Void) {
        guard let eventAssociatedKey = AssociatedKey.eventKeys[event] else {
            return
        }
        let eventClosure = EventClosure(then)
        addTarget(eventClosure, action: #selector(EventClosure.invoke(with:)), for: event)
        objc_setAssociatedObject(self, eventAssociatedKey, eventClosure, .OBJC_ASSOCIATION_RETAIN)
    }
    
    public func whenDidTriggered<Observer: AnyObject>(by event: UIControl.Event, observing observer: Observer, then: @escaping (Observer, UIControl) -> Void) {
        guard let eventAssociatedKey = AssociatedKey.eventKeys[event] else {
            return
        }
        let eventClosure = EventClosure { [weak observer] control in
            guard let observer = observer else { return }
            then(observer, control)
        }
        addTarget(eventClosure, action: #selector(EventClosure.invoke(with:)), for: event)
        objc_setAssociatedObject(self, eventAssociatedKey, eventClosure, .OBJC_ASSOCIATION_RETAIN)
    }
    
    public func whenDidTriggered<Observer: AnyObject>(by event: UIControl.Event, observing observer: Observer, thenCall method: @escaping (Observer) -> ((UIControl) -> Void)) {
        guard let eventAssociatedKey = AssociatedKey.eventKeys[event] else {
            return
        }
        let eventClosure = EventClosure { [weak observer] control in
            guard let observer = observer else { return }
            method(observer)(control)
        }
        addTarget(eventClosure, action: #selector(EventClosure.invoke(with:)), for: event)
        objc_setAssociatedObject(self, eventAssociatedKey, eventClosure, .OBJC_ASSOCIATION_RETAIN)
    }
}

extension UIControl.Event: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}
#endif
