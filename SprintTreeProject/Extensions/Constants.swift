//
//  Constants.swift
//  SprintTreeProject
//
//  Created by Richard Essemiah on 12/09/2024.
//

import Foundation
import ObjectMapper
import SwiftUI

class Constants {
    static let baseUrl = "https://api.thecatapi.com/v1/"
    static let user_id = "richard_ess"
    
    static func convertDictionaryToModels<T: Mappable>(dic: [[String: Any]]) -> [T] {
        var cats: [T] = []
        
        dic.forEach { data in
            guard let cat = T(JSON: data) else { return }
            cats.append(cat)
        }
        
        return cats
    }
}

public enum AppSecrets {
    
    public enum key: String {
        case apiKey = "API_KEY"
    }
    
    /// the parameter key have a enum type `key`
    public static subscript(_ key: key) -> String {
        get {
            let apiKey = Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? String
            return apiKey ?? ""
        }
    }
    
}

// MARK: - Strings
public extension String {
    
    /// Fetches a localized String
    ///
    /// - Returns: return localized for key
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// Fetches a localised String Arguments
    ///
    /// - Parameter arguments: parameters to be added in a string
    /// - Returns: localized string
    func localize<T>(with arguments: T...) -> String {
        return String(format: self.localize(), arguments: arguments as! [CVarArg])
    }
}

extension View {
    func showAlert(title: String, message: String, isPresented: Binding<Bool>, dismissAction: (() -> Void)? = nil) -> some View {
        self.alert(isPresented: isPresented) {
            Alert(
                title: Text(title),
                message: Text(message),
                dismissButton: .default(Text("OK"), action: {
                    // Optional dismiss action if provided
                    dismissAction?()
                })
            )
        }
    }
}
