//
//  EstablishmentServiceTests.swift
//  FieldFinder-AppTests
//
//  Created by Andy Heredia on 27/5/25.
//

import XCTest

@testable import FieldFinder_App
final class EstablishmentServiceTests: XCTestCase {
    
    var sut: EstablishmentService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        let stubbedSession = URLSession(configuration: config)
        
        sut = EstablishmentService(session: stubbedSession)
    }
    
    override func tearDownWithError() throws {
        
        URLProtocolStub.stubResponseData = nil
        URLProtocolStub.stubStatusCode = 200
        URLProtocolStub.error = nil
        
        sut = nil
        try super.tearDownWithError()
    }
    
    func testCreateEstablishment_ReturnsEstablishmentID_WhenRequestIsValid() async throws {
        // Arrange
        let data = try MockData.loadJSONData(name: "IDResponse")
        URLProtocolStub.stubResponseData = data
        URLProtocolStub.stubStatusCode = 200
      
        let request = EstablishmentRequest(
            name: "Bocha",
            info: "Cancha sintética de fútbol 7 con iluminación nocturna",
            address: "123 Main St",
            country: "Ecuador",
            city: "Quito",
            zipCode: "170123",
            parqueadero: true,
            vestidores: true,
            bar: true,
            banos: true,
            duchas: false,
            latitude: -0.2299,
            longitude: -78.5249,
            phone: "0998041792"
        )
        // Act
        let establishment = try await sut.createEstablishment(request)
        // Assert
        XCTAssertNotNil(establishment, "Expected a valid Establishment ID to be returned.")
        XCTAssertEqual(establishment, "1", "Expected Establishment ID to match the mocked response.")
    }
    
    func testCreateEstablishment_ThrowsErrorParsingData_WhenResponseIsEmpty() async throws {
        // Arrange
        URLProtocolStub.stubResponseData = Data()
        
        let request = EstablishmentRequest(
            name: "Bocha",
            info: "Cancha sintética de fútbol 7 con iluminación nocturna",
            address: "123 Main St",
            country: "Ecuador",
            city: "Quito",
            zipCode: "170123",
            parqueadero: true,
            vestidores: true,
            bar: true,
            banos: true,
            duchas: false,
            latitude: -0.2299,
            longitude: -78.5249,
            phone: "0998041792"
        )
        // Act & Assert
        do {
            _ = try await sut.createEstablishment(request)
            XCTFail()
        } catch let error as FFError {
            XCTAssertEqual(error, .errorParsingData)
        } catch {
            XCTFail("Unexpected error type thrown: \(error)")
        }
    }
    
    func testCreateEstablishment_ThrowsErrorFromApi_WhenStatusCodeIs400() async throws {
        // Arrange
        URLProtocolStub.stubResponseData = Data()
        URLProtocolStub.stubStatusCode = 400
        
        let request = EstablishmentRequest(
            name: "Bocha",
            info: "Cancha sintética de fútbol 7 con iluminación nocturna",
            address: "123 Main St",
            country: "Ecuador",
            city: "Quito",
            zipCode: "170123",
            parqueadero: true,
            vestidores: true,
            bar: true,
            banos: true,
            duchas: false,
            latitude: -0.2299,
            longitude: -78.5249,
            phone: "0998041792"
        )
        // Act & Assert
        do {
            _ = try await sut.createEstablishment(request)
            XCTFail("Expected createEstablishment to throw FFError.errorFromApi with 400 status code")
        } catch let error as FFError {
            XCTAssertEqual(error, .errorFromApi(statusCode: 400))
        } catch {
            XCTFail("Unexpected error type thrown: \(error)")
        }
    }
    
    
    
    
}
