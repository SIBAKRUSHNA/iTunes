//
//  SecKey+Extension.swift
//  iTunes
//
//  Created by Siba Krushna on 13/11/24.
//

import Foundation

// MARK: - SecKey Extension
extension SecKey {
    func sha256String() -> String? {
        guard let data = SecKeyCopyExternalRepresentation(self, nil) else {
            return nil
        }
        
        let keyData = data as Data
        let hash = keyData.sha256()
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
