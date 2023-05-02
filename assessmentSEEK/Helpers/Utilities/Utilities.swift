//
//  Utilities.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 29/04/2023.
//

import Foundation
import SwiftUI

enum ViewState {
    case idle
    case loading
    case loaded
}

func getLocation(location: Int) -> String {
    switch location {
    case 1:
        return "Malaysia"
    default:
        return "Somewhere"
    }
}

func getIndustry(industry: Int) -> String {
    switch industry {
    case 1:
        return "IT"
    default:
        return "IT"
    }
}

func getSalaryRange(salaryRange: SalaryRange, location: Int) -> String {
    let currency = getCurrency(location: location)

    return "\(currency) \(salaryRange.min.withCommas()) - \(currency) \(salaryRange.max.withCommas())"
}

func getCurrency(location: Int) -> String {
    switch location {
    case 1:
        return "RM"
    default:
        return "RM"
    }
}

func isLoading(state: ViewState) -> Bool {
    return state == .idle || state == .loading
}

func logOut() {
    UserDefaults.standard.set(nil, forKey: "jwt")
}

struct Navigation {
    static func popToRootView() {
        findNavigationController(viewController: UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.rootViewController)?.popToRootViewController(animated: true)
    }

    static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else { return nil }

        if let navigationController = viewController as? UINavigationController { return navigationController }

        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }

        return nil
    }
}
