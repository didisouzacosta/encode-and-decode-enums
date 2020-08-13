//
//  AuthenticationTypeTests.swift
//  EncodeAndDecodeEnumTests
//
//  Created by Adriano Souza Costa on 12/08/20.
//  Copyright © 2020 Experiments. All rights reserved.
//

import XCTest
import Nimble

@testable import EncodeAndDecodeEnum

class AuthenticationTypeTests: XCTestCase {

    private let decoder = JSONDecoder()
    
    func testEnsureEmailAuthenticationTypeEncode() throws {
        let type = AuthenticationType.email(
            email: "test@test.com.br",
            password: "1234567"
        )
        
        let result = try encode(type: type)
        
        expect(result) == """
        {"email":["test@test.com.br","1234567"]}
        """
    }
    
    func testEnsureFacebookAuthenticationTypeEncode() throws {
        let type = AuthenticationType.facebook(
            accessToken: "192387shdfjksd12@@!"
        )
        
        let result = try encode(type: type)
        
        expect(result) == """
        {"facebook":"192387shdfjksd12@@!"}
        """
    }
    
    func testEnsureAppleAuthenticationTypeEncode() throws {
        let type = AuthenticationType.apple(
            token: "jobs192387shdfjksd12@@!"
        )
        
        let result = try encode(type: type)
        
        expect(result) == """
        {"apple":"jobs192387shdfjksd12@@!"}
        """
    }
    
    func testEnsureGooleAuthenticationTypeEncode() throws {
        let type = AuthenticationType.google(
            token: "ok192387shdfjksd12@@!"
        )
        
        let result = try encode(type: type)
        
        expect(result) == """
        {"google":"ok192387shdfjksd12@@!"}
        """
    }
    
    func testEnsureEmailAuthenticationTypeDecode() throws {
        let data = """
        {"email":["test@test.com.br","1234567"]}
        """.data(using: .utf8)!
        
        let type: AuthenticationType = try decode(data: data)
        
        switch type {
            case .email(let email, let password):
                expect(email) == "test@test.com.br"
                expect(password) == "1234567"
            default:
                fail()
        }
    }
    
    func testEnsureFacebookAuthenticationTypeDecode() throws {
        let data = """
        {"facebook":"192387shdfjksd12@@!"}
        """.data(using: .utf8)!
        
        let type: AuthenticationType = try decode(data: data)
        
        switch type {
            case .facebook(let accessToken):
                expect(accessToken) == "192387shdfjksd12@@!"
            default:
                fail()
        }
    }

    func testEnsureAppleAuthenticationTypeDecode() throws {
        let data = """
        {"apple":"192387shdfjksd12@@!aaa"}
        """.data(using: .utf8)!
        
        let type: AuthenticationType = try decode(data: data)
        
        switch type {
            case .apple(let token):
                expect(token) == "192387shdfjksd12@@!aaa"
            default:
                fail()
        }
    }

    func testEnsureGooleAuthenticationTypeDecode() throws {
        let data = """
        {"google":"192387shdfjksd12@@!ok"}
        """.data(using: .utf8)!
        
        let type: AuthenticationType = try decode(data: data)
        
        switch type {
            case .google(let token):
                expect(token) == "192387shdfjksd12@@!ok"
            default:
                fail()
        }
    }

}

fileprivate extension AuthenticationTypeTests {
    
    func encode(type: AuthenticationType) throws -> String? {
        let encoder = JSONEncoder()
        let data = try encoder.encode(type)
        return String(data: data, encoding: .utf8)
    }
    
    func decode<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
}
