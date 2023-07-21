//
//  LayoutDraftSubscriber.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 21/7/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Combine

public extension LayoutDraft {
    var subcriber: LayoutDraftSubscriber<View> {
        .init(layoutDraft: self)
    }
}

@dynamicMemberLookup
final public class LayoutDraftSubscriber<View: UIView> {
    
    let draft: LayoutDraft<View>
    var cancellables: Set<AnyCancellable> = .init()
    var underlyingView: View { draft.underlyingView }
    
    init(layoutDraft: LayoutDraft<View>) {
        self.draft = layoutDraft
    }
    
    public subscript<Property>(dynamicMember keyPath: ReferenceWritableKeyPath<View, Property>) -> Assigner<Property> {
        Assigner(subscribeable: self, keyPath: keyPath)
    }
    
    public func storeAll(in cancellables: inout Set<AnyCancellable>) -> LayoutDraft<View> {
        for cancellable in self.cancellables {
            cancellables.insert(cancellable)
        }
        return draft
    }
}

extension LayoutDraftSubscriber {
    
    @dynamicCallable
    public struct Assigner<Property> {
        let subscribeable: LayoutDraftSubscriber
        let keyPath: ReferenceWritableKeyPath<View, Property>
        
        public func dynamicallyCall<P: Publisher>(withKeywordArguments args: KeyValuePairs<String, P>) -> LayoutDraftSubscriber where P.Output == Property, P.Failure == Never {
            for pair in args {
                pair.value
                    .assign(to: keyPath, on: subscribeable.underlyingView)
                    .store(in: &subscribeable.cancellables)
            }
            return subscribeable
        }
    }
}
#endif
