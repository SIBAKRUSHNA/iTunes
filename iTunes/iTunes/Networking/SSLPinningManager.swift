//
//  SSLPinningManager.swift
//  iTunes
//
//  Created by Siba Krushna on 13/11/24.
//

import Foundation

// MARK: - SSLPinningManager Class
class SSLPinningManager: NSObject, URLSessionDelegate {
    // The pinned public key hash to compare with the server's public key.
    private let pinnedPublicKeyHash = "f6fab3e050d5ba1a7b3a71a67a434b8dc3cbc4732df52421021ad7e4f29682b4"
    // URLSession delegate method to handle SSL/TLS server trust validation
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // Check if the authentication method is server trust
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
           let serverTrust = challenge.protectionSpace.serverTrust,
           let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0), // Get the server certificate
           let publicKey = extractPublicKey(from: serverCertificate), // Extract the public key from the certificate
           let publicKeyHash = publicKey.sha256String(), // Hash the public key to compare with the pinned hash
           publicKeyHash == pinnedPublicKeyHash { // Compare the hashed public key with the pinned one
            // If the hashes match, trust the server and proceed with the connection
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
        } else {
            // If the public key doesn't match or the certificate extraction fails
            print("Public Key Mismatch or unable to extract certificate.")
            completionHandler(.cancelAuthenticationChallenge, nil) // Reject the connection
        }
    }
    // Helper function to extract the public key from a certificate
    private func extractPublicKey(from certificate: SecCertificate) -> SecKey? {
        var publicKey: SecKey?
        // Create a policy for basic X.509 certificate validation
        let policy = SecPolicyCreateBasicX509()
        var trust: SecTrust?
        // Create a trust object with the certificate and the policy
        let status = SecTrustCreateWithCertificates(certificate, policy, &trust)
        // If trust creation succeeds, copy the public key from the trust object
        if status == errSecSuccess, let trust = trust {
            publicKey = SecTrustCopyKey(trust)
        }
        return publicKey // Return the extracted public key
    }
}

