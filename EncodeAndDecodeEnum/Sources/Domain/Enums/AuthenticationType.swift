//
//  AuthenticationType.swift
//  EncodeAndDecodeEnum
//
//  Created by Adriano Souza Costa on 12/08/20.
//  Copyright © 2020 Experiments. All rights reserved.
//

import Foundation

enum AuthenticationType {
    case email(email: String, password: String)
    case facebook(accessToken: String)
    case apple(token: String)
    case google(token: String)
}

extension AuthenticationType {
    enum CodingKeys: CodingKey {
        case email, facebook, apple, google
    }
}

extension AuthenticationType: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .email(let email, let password):
            var nestedContainer = container.nestedUnkeyedContainer(forKey: .email)
            try nestedContainer.encode(email)
            try nestedContainer.encode(password)
        case .facebook(let accessToken):
            try container.encode(accessToken, forKey: .facebook)
        case .apple(let token):
            try container.encode(token, forKey: .apple)
        case .google(let token):
            try container.encode(token, forKey: .google)
        }
    }
}

extension AuthenticationType: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let firstKey = container.allKeys.first

        switch firstKey {
        case .email:
            var nestedContainer = try container.nestedUnkeyedContainer(forKey: .email)
            let email = try nestedContainer.decode(String.self)
            let password = try nestedContainer.decode(String.self)
            self = .email(email: email, password: password)
        case .facebook:
            let accessToken = try container.decode(
                String.self,
                forKey: .facebook
            )
            self = .facebook(accessToken: accessToken)
        case .apple:
            let token = try container.decode(
                String.self,
                forKey: .apple
            )
            self = .apple(token: token)
        case .google:
            let token = try container.decode(
                String.self,
                forKey: .google
            )
            self = .google(token: token)
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unabled to decode enum."
                )
            )
        }
    }
}
