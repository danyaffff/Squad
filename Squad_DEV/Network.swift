//
//  Network.swift
//  Squad_DEV
//
//  Created by Даниил Храповицкий on 23.05.2021.
//

import FirebaseAuth
import FirebaseFirestore
import SwiftyJSON

final class Network {
    static let firestore = Firestore.firestore()
    
    class func safe(_ data: [String: Any]) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Safe error")
            return
        }
        
        firestore
            .collection("users")
            .document(uid)
            .setData(data, merge: true)
    }
    
    class func fetchUser(_ completion: ((JSON) -> Void)?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        firestore
            .collection("users")
            .document(uid)
            .getDocument { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    guard let data = snapshot!.data() else {
                        print("no data")
                        return
                    }
                    let json = JSON(data)
                    completion?(json)
                }
            }
    }
}
