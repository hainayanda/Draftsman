//
//  LayoutAxisAnchor.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 23/04/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol LayoutAxisAnchor {
    func constraint(_ relation: NSLayoutConstraint.Relation, to anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(_ relation: NSLayoutConstraint.Relation, to anchor: Self) -> NSLayoutConstraint
}

extension NSLayoutXAxisAnchor: LayoutAxisAnchor {
    public func constraint(_ relation: NSLayoutConstraint.Relation, to anchor: NSLayoutXAxisAnchor, constant: CGFloat) -> NSLayoutConstraint {
        let myIdentifier = ObjectIdentifier(self).hashValue
        let anchorIdentifier = ObjectIdentifier(anchor).hashValue
        switch relation {
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, constant: constant)
                .with(draftsmanIdentifier: "\(myIdentifier)_x-lt-\(anchorIdentifier)_x")
        case .equal:
            return constraint(equalTo: anchor, constant: constant)
                .with(draftsmanIdentifier: "\(myIdentifier)_x-eq-\(anchorIdentifier)_x")
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, constant: constant)
                .with(draftsmanIdentifier: "\(myIdentifier)_x-gt-\(anchorIdentifier)_x")
        @unknown default:
            return constraint(equalTo: anchor, constant: constant)
                .with(draftsmanIdentifier: "\(myIdentifier)_x-un-\(anchorIdentifier)_x")
        }
    }
    
    public func constraint(_ relation: NSLayoutConstraint.Relation, to anchor: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        let myIdentifier = ObjectIdentifier(self).hashValue
        let anchorIdentifier = ObjectIdentifier(anchor).hashValue
        switch relation {
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor)
                .with(draftsmanIdentifier: "\(myIdentifier)_x-lt-\(anchorIdentifier)_x")
        case .equal:
            return constraint(equalTo: anchor)
                .with(draftsmanIdentifier: "\(myIdentifier)_x-eq-\(anchorIdentifier)_x")
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor)
                .with(draftsmanIdentifier: "\(myIdentifier)_x-gt-\(anchorIdentifier)_x")
        @unknown default:
            return constraint(equalTo: anchor)
                .with(draftsmanIdentifier: "\(myIdentifier)_x-un-\(anchorIdentifier)_x")
        }
    }
}

extension NSLayoutYAxisAnchor: LayoutAxisAnchor {
    public func constraint(_ relation: NSLayoutConstraint.Relation, to anchor: NSLayoutYAxisAnchor, constant: CGFloat) -> NSLayoutConstraint {
        let myIdentifier = ObjectIdentifier(self).hashValue
        let anchorIdentifier = ObjectIdentifier(anchor).hashValue
        switch relation {
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, constant: constant)
                .with(draftsmanIdentifier: "\(myIdentifier)_y-lt-\(anchorIdentifier)_y")
        case .equal:
            return constraint(equalTo: anchor, constant: constant)
                .with(draftsmanIdentifier: "\(myIdentifier)_y-eq-\(anchorIdentifier)_y")
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, constant: constant)
                .with(draftsmanIdentifier: "\(myIdentifier)_y-gt-\(anchorIdentifier)_y")
        @unknown default:
            return constraint(equalTo: anchor, constant: constant)
                .with(draftsmanIdentifier: "\(myIdentifier)_y-un-\(anchorIdentifier)_y")
        }
    }
    
    public func constraint(_ relation: NSLayoutConstraint.Relation, to anchor: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        let myIdentifier = ObjectIdentifier(self).hashValue
        let anchorIdentifier = ObjectIdentifier(anchor).hashValue
        switch relation {
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor)
                .with(draftsmanIdentifier: "\(myIdentifier)_y-lt-\(anchorIdentifier)_y")
        case .equal:
            return constraint(equalTo: anchor)
                .with(draftsmanIdentifier: "\(myIdentifier)_y-eq-\(anchorIdentifier)_y")
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor)
                .with(draftsmanIdentifier: "\(myIdentifier)_y-gt-\(anchorIdentifier)_y")
        @unknown default:
            return constraint(equalTo: anchor)
                .with(draftsmanIdentifier: "\(myIdentifier)_y-un-\(anchorIdentifier)_y")
        }
    }
}
#endif
