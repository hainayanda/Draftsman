//
//  Enumerations.swift
//  Draftsman
//
//  Created by Nayanda Haberty (ID) on 27/08/20.
//

import Foundation
#if canImport(UIKit)
import UIKit

public enum LayoutRelation<Related> {
    case moreThanTo(Related)
    case lessThanTo(Related)
    case equalTo(Related)
    case moreThan
    case lessThan
    case equal
}

public enum InterRelation<Related> {
    case moreThanTo(Related)
    case lessThanTo(Related)
    case equalTo(Related)
    
    public var related: Related {
        switch self {
        case .moreThanTo(let related), .lessThanTo(let related), .equalTo(let related):
            return related
        }
    }
}

public enum MiddlePosition {
    case horizontally(LayoutRelation<InsetsConvertible>)
    case vertically(LayoutRelation<InsetsConvertible>)
}

public enum AnonymousRelation {
    case parent
    case safeArea
    case myself
    case mySafeArea
    case previous
    case previousSafeArea
    case keyboard
    case keyboardSafeArea
    
    public var isView: Bool {
        return !isSafeArea && !isKeyboard
    }
    
    public var isSafeArea: Bool {
        switch self {
        case .mySafeArea, .safeArea, .previousSafeArea:
            return true
        default:
            return false
        }
    }
    
    public var isKeyboard: Bool {
        switch self {
        case .keyboard, .keyboardSafeArea:
            return true
        default:
            return false
        }
    }
}

public enum PlanningOption {
    case append
    case renew
    case startFresh
    case startClean
    
    public var shouldRemoveOldPlannedConstraints: Bool {
        switch self {
        case .startFresh, .startClean:
            return true
        default:
            return false
        }
    }
    
    public var shouldCleanAllConstraints: Bool {
        switch self {
        case .startClean:
            return true
        default:
            return false
        }
    }
    
    public var shouldRenew: Bool {
        switch self {
        case .renew:
            return true
        default:
            return false
        }
    }
}

public enum CellLayoutingPhase: CaseIterable {
    case firstLoad
    case setNeedsLayout
    case reused
    case none
}

public enum CellPlanningBehavior {
    case planOnce
    case planOn(CellLayoutingPhase)
    case planOnEach([CellLayoutingPhase])
    case planIfPossible
    
    var whitelistedPhases: [CellLayoutingPhase] {
        switch self {
        case .planOnce:
            return [.firstLoad]
        case .planOn(let phase):
            return [phase]
        case .planOnEach(let phases):
            return phases
        case .planIfPossible:
            return CellLayoutingPhase.allCases
        }
    }
}

public enum LayoutEdge {
    case top
    case bottom
    case left
    case right
}

public enum RelatedPosition {
    case topOf(UIView)
    case bottomOf(UIView)
    case leftOf(UIView)
    case rightOf(UIView)
    case topOfAndParallelWith(UIView)
    case bottomOfAndParallelWith(UIView)
    case leftOfAndParallelWith(UIView)
    case rightOfAndParallelWith(UIView)
}

public enum LayoutStackedStrategy {
    case emptying
    case append
    case replaceDifferences
}

enum NumberSign {
    case positive
    case negative
    
    func convert(_ number: CGFloat) -> CGFloat {
        switch self {
        case .positive:
            return number
        default:
            return -number
        }
    }
}
#endif
