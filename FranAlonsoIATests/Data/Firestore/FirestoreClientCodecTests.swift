//
//  FirestoreClientCodecTests.swift
//  FranAlonsoIATests
//
//  Created by Codex on 12.01.2026.
//

import XCTest
import FirebaseFirestore
@testable import FranAlonsoIA

final class FirestoreClientCodecTests: XCTestCase {
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()

    func test_clientFromData_parsesDateStrings() throws {
        let data: [String: Any] = [
            "full_name": "Test User",
            "phones": ["622131357"],
            "email": "test@example.com",
            "billing_address": [
                "street": "Av. Almargen, 82",
                "postal_code": "41930",
                "city": "Bormujos",
                "province": "Sevilla"
            ],
            "birth_date": "26/04/1970",
            "recipe": "Rubio",
            "last_color_date": "05/01/2025",
            "photo_url": "",
            "consent_url": "",
            "notes": "",
            "is_active": true
        ]

        let client = try FirestoreClientCodec.client(from: "doc-1", data: data)

        XCTAssertEqual(client.id, "doc-1")
        XCTAssertEqual(client.birthDate, formatter.date(from: "26/04/1970"))
        XCTAssertEqual(client.lastColorDate, formatter.date(from: "05/01/2025"))
        XCTAssertEqual(client.billingAddress?.postalCode, "41930")
    }

    func test_clientFromData_acceptsTimestampDates() throws {
        let date = Date(timeIntervalSince1970: 0)
        let data: [String: Any] = [
            "full_name": "Test User",
            "phones": [],
            "birth_date": Timestamp(date: date),
            "last_color_date": Timestamp(date: date)
        ]

        let client = try FirestoreClientCodec.client(from: "doc-2", data: data)

        XCTAssertEqual(client.birthDate, date)
        XCTAssertEqual(client.lastColorDate, date)
    }

    func test_clientFromData_emptyDateStringsBecomeNil() throws {
        let data: [String: Any] = [
            "full_name": "Test User",
            "birth_date": "",
            "last_color_date": "  "
        ]

        let client = try FirestoreClientCodec.client(from: "doc-3", data: data)

        XCTAssertNil(client.birthDate)
        XCTAssertNil(client.lastColorDate)
    }

    func test_clientFromData_missingFullNameThrows() {
        let data: [String: Any] = [:]

        XCTAssertThrowsError(try FirestoreClientCodec.client(from: "doc-4", data: data)) { error in
            guard case let FirestoreClientRepositoryError.invalidData(documentId, field) = error else {
                XCTFail("Unexpected error type")
                return
            }
            XCTAssertEqual(documentId, "doc-4")
            XCTAssertEqual(field, "full_name")
        }
    }

    func test_clientFromData_missingPhonesDefaultsEmpty() throws {
        let data: [String: Any] = [
            "full_name": "Test User"
        ]

        let client = try FirestoreClientCodec.client(from: "doc-5", data: data)

        XCTAssertEqual(client.phones, [])
    }

    func test_dataFromClient_writesNullBillingAddress() {
        let client = Client(
            id: "doc-6",
            fullName: "Test User",
            phones: [],
            email: nil,
            billingAddress: nil,
            birthDate: nil,
            recipe: nil,
            lastColorDate: nil,
            photoUrl: nil,
            consentUrl: nil,
            notes: nil,
            isActive: true
        )

        let data = FirestoreClientCodec.data(from: client)

        XCTAssertTrue(data["billing_address"] is NSNull)
    }

    func test_dataFromClient_formatsDatesAsDdMmYyyy() {
        let date = formatter.date(from: "01/02/2025")!
        let client = Client(
            id: "doc-7",
            fullName: "Test User",
            phones: [],
            email: nil,
            billingAddress: nil,
            birthDate: date,
            recipe: nil,
            lastColorDate: date,
            photoUrl: nil,
            consentUrl: nil,
            notes: nil,
            isActive: true
        )

        let data = FirestoreClientCodec.data(from: client)

        XCTAssertEqual(data["birth_date"] as? String, "01/02/2025")
        XCTAssertEqual(data["last_color_date"] as? String, "01/02/2025")
    }

    func test_dataFromClient_doesNotWriteIdField() {
        let client = Client(
            id: "doc-8",
            fullName: "Test User",
            phones: [],
            email: nil,
            billingAddress: nil,
            birthDate: nil,
            recipe: nil,
            lastColorDate: nil,
            photoUrl: nil,
            consentUrl: nil,
            notes: nil,
            isActive: true
        )

        let data = FirestoreClientCodec.data(from: client)

        XCTAssertNil(data["id"])
    }
}
