//
//  FirestoreUserRepository.swift
//  Adocent
//
//  Created by 김찬형 on 2022/11/24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class FirestoreUserRepository: ObservableObject {
    private let path: String = "firestoreUsers"
    private let store = Firestore.firestore()
    
    @Published var firestoreUsers: [FirestoreUser] = []
    @Published var user = FirestoreUser()
    
    init() {
        get()
    }
    
    func get() {
        store.collection(path)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting firestoreUsers: \(error.localizedDescription)")
                    return
                }
                
                self.firestoreUsers = querySnapshot?.documents.compactMap { document in
                    try? document.data(as : FirestoreUser.self)
                } ?? []
            }
    }
    
    func add(_ firestoreUser: FirestoreUser) {
        do {
            try store.collection(path).addDocument(from: firestoreUser)
        } catch {
            fatalError("Unable to add firestoreUser: \(error.localizedDescription).")
        }
    }
    
    func update(_ firestoreUser: FirestoreUser) {
        guard let id = firestoreUser.id else { return }
        
        do {
            try store.collection(path).document(id).setData(from: firestoreUser)
        } catch {
            fatalError("Unable to update firestoreUser: \(error.localizedDescription)")
        }
    }
    
    func remove(_ firestoreUser: FirestoreUser) {
        guard let id = firestoreUser.id else { return }
        
        store.collection(path).document(id).delete { error in
            if let error = error {
                print("Unable to remove firestoreUser: \(error.localizedDescription)")
            }
        }
    }
}
