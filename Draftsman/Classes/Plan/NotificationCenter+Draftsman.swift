//
//  NotificationCenter+Draftsman.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/02/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

var draftsmanNotificationCenter: NotificationCenter = .init()

public extension UIView {
    
    func whenViewDidPlanned(run closure: @escaping (UIView) -> Void) {
        let plannedClosure = PlannedClosure(closure)
        NotificationCenter.draftsman.addObserver(
            plannedClosure,
            selector: #selector(PlannedClosure.invoke(with:)),
            name: Draftsman.plannedNotificationName,
            object: self
        )
        objc_setAssociatedObject(self, &AssociatedKey.plannedClosure, plannedClosure, .OBJC_ASSOCIATION_RETAIN)
    }
    
    internal func notifyViewDidPlanned() {
        NotificationCenter.draftsman.post(name: Draftsman.plannedNotificationName, object: self)
    }
    
    internal struct Draftsman {
        static var plannedNotificationName: Notification.Name = .init("draftsman_viewPlannedNotification")
    }
    
    internal struct AssociatedKey {
        static var plannedClosure: String = "Draftsman_Tapped_Closure"
    }
    
    @objc internal class PlannedClosure: NSObject {
        let closure: (UIView) -> Void
        
        init(_ closure: @escaping (UIView) -> Void) {
            self.closure = closure
        }
        
        @objc func invoke(with sender: NSNotification) {
            guard let view = sender.object as? UIView else { return }
            closure(view)
        }
    }
}

extension NotificationCenter {
    static var draftsman: NotificationCenter { draftsmanNotificationCenter }
}

public extension UIViewController {
    func whenViewDidPlanned(run closure: @escaping (UIView) -> Void) {
        let plannedClosure = UIView.PlannedClosure(closure)
        NotificationCenter.draftsman.addObserver(
            plannedClosure,
            selector: #selector(UIView.PlannedClosure.invoke(with:)),
            name: UIView.Draftsman.plannedNotificationName,
            object: self
        )
        objc_setAssociatedObject(self, &UIView.AssociatedKey.plannedClosure, plannedClosure, .OBJC_ASSOCIATION_RETAIN)
    }
    
    internal func notifyViewDidPlanned() {
        NotificationCenter.draftsman.post(name: UIView.Draftsman.plannedNotificationName, object: self)
    }
}
#endif
