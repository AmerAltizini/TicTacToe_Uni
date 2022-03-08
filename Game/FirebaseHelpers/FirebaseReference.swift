//
//  FirebaseReference.swift
//  Game
//
//  Created by M1 Mac 1 on 2/9/22.
//

import Foundation
import Firebase


enum FCollectionReference: String {
    case Game
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
