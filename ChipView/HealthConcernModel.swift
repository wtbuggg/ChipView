//
//  HealthConcernModel.swift
//  ChipView
//
//  Created by Htet LynnHtun on 29/12/2023.
//

import Foundation

class HealthConcernModel {
    private let _concerns = ["Sleep", "Immunity", "Stress", "Joint Support", "Digestion", "Mood", "Energy", "Hair, Skin, Nails", "Weight Loss", "Fitness", "Special Medical Condition"]
    
    private(set) var selectedConcerns = [String]()
    private let kMaxConcern = 5
    private let nc = NotificationCenter.default
    
    var concerns: [(String, Bool)] {
        _concerns.map { concern in
            let isSelected = selectedConcerns.contains([concern])
            return (concern, isSelected)
        }
    }
    
    func select(_ concern: String) {
        if let selectedIndex = selectedConcerns.firstIndex(of: concern) {
            selectedConcerns.remove(at: selectedIndex)
        } else if selectedConcerns.count < kMaxConcern {
            selectedConcerns.append(concern)
        }
        nc.post(name: .concernsSelected, object: nil)
        nc.post(name: .concernsUpdated, object: nil)
    }
    
    func move(_ concern: String, to destination: Int) {
        guard let currentIndex = selectedConcerns.firstIndex(of: concern) else {
            return
        }
        selectedConcerns.remove(at: currentIndex)
        selectedConcerns.insert(concern, at: destination)
        nc.post(name: .concernsUpdated, object: nil)
    }
}

extension Notification.Name {
    static let concernsUpdated = Notification.Name("concerns updated")
    static let concernsSelected = Notification.Name("concerns selected")
}
