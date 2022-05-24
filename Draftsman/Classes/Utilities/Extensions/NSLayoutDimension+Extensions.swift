//
//  NSLayoutDimension+Extensions.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/05/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension NSLayoutDimension {
    public func constraint(_ relation: NSLayoutConstraint.Relation, with dimension: CGFloat) -> NSLayoutConstraint {
        let myIdentifier = ObjectIdentifier(self).hashValue
        switch relation {
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualToConstant: dimension)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-lt")
        case .equal:
            return constraint(equalToConstant: dimension)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-eq")
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualToConstant: dimension)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-gt")
        @unknown default:
            return constraint(equalToConstant: dimension)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-un")
        }
    }
    
    public func constraint(_ relation: NSLayoutConstraint.Relation, to anchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        let myIdentifier = ObjectIdentifier(self).hashValue
        let anchorIdentifier = ObjectIdentifier(anchor).hashValue
        switch relation {
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-lt-\(anchorIdentifier)_d")
        case .equal:
            return constraint(equalTo: anchor, multiplier: multiplier, constant: constant)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-eq-\(anchorIdentifier)_d")
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-gt-\(anchorIdentifier)_d")
        @unknown default:
            return constraint(equalTo: anchor, multiplier: multiplier, constant: constant)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-un-\(anchorIdentifier)_d")
        }
    }
    
    public func constraint(_ relation: NSLayoutConstraint.Relation, to anchor: NSLayoutDimension, multiplier: CGFloat) -> NSLayoutConstraint {
        let myIdentifier = ObjectIdentifier(self).hashValue
        let anchorIdentifier = ObjectIdentifier(anchor).hashValue
        switch relation {
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, multiplier: multiplier)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-lt-\(anchorIdentifier)_d")
        case .equal:
            return constraint(equalTo: anchor, multiplier: multiplier)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-eq-\(anchorIdentifier)_d")
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-gt-\(anchorIdentifier)_d")
        @unknown default:
            return constraint(equalTo: anchor, multiplier: multiplier)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-un-\(anchorIdentifier)_d")
        }
    }
    
    public func constraint(_ relation: NSLayoutConstraint.Relation, to anchor: NSLayoutDimension, constant: CGFloat) -> NSLayoutConstraint {
        let myIdentifier = ObjectIdentifier(self).hashValue
        let anchorIdentifier = ObjectIdentifier(anchor).hashValue
        switch relation {
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, constant: constant)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-lt-\(anchorIdentifier)_d")
        case .equal:
            return constraint(equalTo: anchor, constant: constant)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-eq-\(anchorIdentifier)_d")
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, constant: constant)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-gt-\(anchorIdentifier)_d")
        @unknown default:
            return constraint(equalTo: anchor, constant: constant)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-un-\(anchorIdentifier)_d")
        }
    }
    
    public func constraint(_ relation: NSLayoutConstraint.Relation, to anchor: NSLayoutDimension) -> NSLayoutConstraint {
        let myIdentifier = ObjectIdentifier(self).hashValue
        let anchorIdentifier = ObjectIdentifier(anchor).hashValue
        switch relation {
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-lt-\(anchorIdentifier)_d")
        case .equal:
            return constraint(equalTo: anchor)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-eq-\(anchorIdentifier)_d")
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-gt-\(anchorIdentifier)_d")
        @unknown default:
            return constraint(equalTo: anchor)
                .with(draftsmanIdentifier: "\(myIdentifier)_d-un-\(anchorIdentifier)_d")
        }
    }
}
#endif
