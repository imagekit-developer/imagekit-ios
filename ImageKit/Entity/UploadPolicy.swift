//
//  UploadPolicy.swift
//  ImageKitIO
//
//  Created by Animesh Verma on 18/09/23.
//

import Foundation

public class UploadPolicy {
    private static let DEFAULT_MAX_ERROR_RETRIES = 5
    private static let DEFAULT_BACKOFF_MILLIS = 1000
    private static let DEFAULT_BACKOFF_POLICY = BackoffPolicy.LINEAR
    
    let networkType: NetworkType
    let requiresCharging: Bool
    let maxErrorRetries: Int
    let backoffMillis: Int
    let backoffPolicy: BackoffPolicy
    
    private init(networkType: NetworkType, requiresCharging: Bool, maxErrorRetries: Int, backoffMillis: Int, backoffPolicy: BackoffPolicy) {
        self.networkType = networkType
        self.requiresCharging = requiresCharging
        self.maxErrorRetries = maxErrorRetries
        self.backoffMillis = backoffMillis
        self.backoffPolicy = backoffPolicy
    }
    
    public enum NetworkType {
        case ANY
        case UNMETERED
    }
    
    public enum BackoffPolicy {
        case LINEAR
        case EXPONENTIAL
    }
    
    public class Builder {
        private var networkType = NetworkType.ANY
        private var requiresCharging = false
        private var maxRetries = DEFAULT_MAX_ERROR_RETRIES
        private var backoffMillis = DEFAULT_BACKOFF_MILLIS
        private var backoffPolicy = DEFAULT_BACKOFF_POLICY
        
        public init() {}
        
        public func requireNetworkType(_ networkPolicy: NetworkType) -> Builder {
            self.networkType = networkPolicy
            return self
        }
        
        public func requiresBatteryCharging(_ requiresCharging: Bool) -> Builder {
            self.requiresCharging = requiresCharging
            return self
        }
        
        public func maxRetries(_ maxRetries: Int) -> Builder {
            guard maxRetries >= 0 else {
                print("maxRetries cannot be a negative integer")
                return self
            }
            self.maxRetries = maxRetries
            return self
        }
        
        public func backoffCriteria(backoffMillis: Int, backoffPolicy: BackoffPolicy) -> Builder {
            guard backoffMillis >= 0 else {
                print("backoffMillis cannot be a negative integer")
                return self
            }
            self.backoffMillis = backoffMillis
            self.backoffPolicy = backoffPolicy
            return self
        }
        
        public func build() -> UploadPolicy {
            return UploadPolicy(
                networkType: networkType,
                requiresCharging: requiresCharging,
                maxErrorRetries: maxRetries,
                backoffMillis: backoffMillis,
                backoffPolicy: backoffPolicy
            )
        }
    }
    
    public static func defaultPolicy() -> UploadPolicy {
        return Builder()
            .requireNetworkType(NetworkType.ANY)
            .requiresBatteryCharging(false)
            .maxRetries(DEFAULT_MAX_ERROR_RETRIES)
            .backoffCriteria(
                backoffMillis: DEFAULT_BACKOFF_MILLIS,
                backoffPolicy: DEFAULT_BACKOFF_POLICY
            )
            .build()
    }
}
