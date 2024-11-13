//
//  Data+Extension.swift
//  iTunes
//
//  Created by Siba Krushna on 13/11/24.
//

import Foundation
import CommonCrypto

// MARK: - Data Extension
extension Data {
    func sha256() -> [UInt8] {
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        _ = self.withUnsafeBytes { bytes in
            CC_SHA256(bytes.baseAddress, CC_LONG(self.count), &hash)
        }
        return hash
    }
}
