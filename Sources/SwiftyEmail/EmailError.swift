//
//  EmailError.swift
//  
//
//  Created by Marcos Morais on 25/08/22.
//

import Foundation

public enum EmailError: LocalizedError {
    case unavailableApps
    case unknownError

    public var errorDescription: String? {
        switch self {
        case .unavailableApps:
            return NSLocalizedString("The user does not have any e-mail app available.", comment: "")
        case .unknownError:
            return NSLocalizedString("An unknown error occurred.", comment: "")
        }
    }
}

extension EmailError: Identifiable {
    public var id: String? {
        errorDescription
    }
}
