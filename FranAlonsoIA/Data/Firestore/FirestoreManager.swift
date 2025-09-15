//
//  FirestoreManager.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 17.07.2025.
//

import FirebaseFirestore

enum FirestoreRefManager {
    private static let db = Firestore.firestore()

    static var root: DocumentReference {
        db.collection(FSEnvironment.current.rawValue).document("collections")
    }

    static var clients: CollectionReference {
        root.collection(FSCollection.clients.name)
    }

    static var services: CollectionReference {
        root.collection(FSCollection.services.name)
    }

    static var appointments: CollectionReference {
        root.collection(FSCollection.appointments.name)
    }

    static var products: CollectionReference {
        root.collection(FSCollection.products.name)
    }

    static var sales: CollectionReference {
        root.collection(FSCollection.sales.name)
    }

    static var config: DocumentReference {
        db.document("\(FSEnvironment.current.rawValue)/config/global")
    }
}
