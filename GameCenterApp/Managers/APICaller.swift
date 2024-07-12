//
//  APICaller.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 25.02.2024.
//

import Foundation
import FirebaseFirestore

class APICaller {
    static let shared = APICaller()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    //MARK: - Advertisements - GET -
    
    func getAdvertisements(completion: @escaping (Result<[Advertisement], GCError>) -> Void) {
        db.collection(FirestoreCollections.Advertisements).getDocuments { querySnapshot, error in
            guard let querySnapshot, error == nil else {
                completion(.failure(GCError.getError))
                return
            }
            
            if querySnapshot.documents.count == 0 {
                completion(.success([]))
                return
            }
            
            var advertisements = [Advertisement]()
            
            do {
                try querySnapshot.documents.forEach {
                    let advertisement = try $0.data(as: Advertisement.self)
                    self.getRelatedObjects(advertisement: advertisement) { advertisement in
                        guard let advertisement else {
                            completion(.failure(.relatedObjectGetError))
                            return
                        }
                        
                        advertisements.append(advertisement)
                        
                        if advertisements.count == querySnapshot.documents.count {
                            completion(.success(advertisements))
                        }
                    }
                }
            } catch { completion(.failure(GCError.jsonError)) }
        }
    }
    
    func getAdvertisements(userId: String, completion: @escaping (Result<[Advertisement], GCError>) -> Void) {
        db.collection(FirestoreCollections.Advertisements).whereField("userId", isEqualTo: userId).getDocuments { querySnapshot, error in
            guard let querySnapshot, error == nil else {
                completion(.failure(.getError))
                return
            }
            
            if querySnapshot.documents.count == 0 {
                completion(.success([]))
                return
            }
            
            var advertisements = [Advertisement]()
            
            querySnapshot.documents.forEach {
                do {
                    let advertisement = try $0.data(as: Advertisement.self)
                    self.getRelatedObjects(advertisement: advertisement) { advertisement in
                        guard let advertisement else {
                            completion(.failure(.relatedObjectGetError))
                            return
                        }
                        
                        advertisements.append(advertisement)
                        
                        if advertisements.count == querySnapshot.documents.count {
                            completion(.success(advertisements))
                        }
                    }
                } catch { completion(.failure(.jsonError)) }
            }
            
        }
    }
    
    //MARK: - Advertisements - ADD/UPDATE/DELETE -
    
    func add(advertisement: Advertisement, completion: @escaping (GCError?) -> Void) {
        let dictionary = makeFirestoreDictionary(with: advertisement)
        db.collection(FirestoreCollections.Advertisements).document(advertisement.id).setData(dictionary) { error in
            guard error == nil else {
                completion(.addError)
                return
            }
            completion(nil)
        }
    }
    
    func update(advertisement: Advertisement, completion: @escaping (GCError?) -> Void) {
        let dictionary = makeFirestoreDictionary(with: advertisement)
        db.collection(FirestoreCollections.Advertisements).document(advertisement.id).setData(dictionary) { error in
            guard error == nil else {
                completion(.updateError)
                return
            }
            completion(nil)
        }
    }
    
    func delete(advertisementId: String, completion: @escaping (GCError?) -> Void) {
        db.collection(FirestoreCollections.Advertisements).document(advertisementId).delete { error in
            guard error == nil else {
                completion(.deleteError)
                return
            }
            completion(nil)
        }
    }
    
    //MARK: - Games - GET -
    
    func getGames(completion: @escaping (Result<[Game], GCError>) -> Void) {
        db.collection(FirestoreCollections.Games).getDocuments { querySnapshot, error in
            guard let querySnapshot, error == nil else {
                completion(.failure(.getError))
                return
            }
            do {
                var games = [Game]()
                try querySnapshot.documents.forEach { games.append(try $0.data(as: Game.self)) }
                completion(.success(games))
            } catch {
                completion(.failure(.jsonError))
            }
        }
    }
    
    func getGame(id: String, completion: @escaping (Result<Game, GCError>) -> Void) {
        db.collection(FirestoreCollections.Games).document(id).getDocument(as: Game.self) { getResult in
            switch getResult {
            case .success(let game):
                completion(.success(game))
                
            case .failure(_):
                completion(.failure(GCError.getError))
            }
        }
    }
    
    //MARK: - Games - ADD/UPDATE/DELETE -
    
    func add(game: Game, completion: @escaping (GCError?) -> Void) {
        let dictionary = makeFirestoreDictionary(with: game)
        db.collection(FirestoreCollections.Users).document(game.id).setData(dictionary) { error in
            guard error == nil else {
                completion(.addError)
                return
            }
            completion(nil)
        }
    }
    
    func update(game: Game, completion: @escaping (GCError?) -> Void) {
        let dictionary = makeFirestoreDictionary(with: game)
        db.collection(FirestoreCollections.Users).document(game.id).setData(dictionary) { error in
            guard error == nil else {
                completion(.updateError)
                return
            }
            completion(nil)
        }
    }
    
    func delete(gameId: String, completion: @escaping (GCError?) -> Void) {
        db.collection(FirestoreCollections.Games).document(gameId).delete { error in
            guard error == nil else {
                completion(.deleteError)
                return
            }
            completion(nil)
        }
    }
    
    //MARK: - Users - GET -
    
    func getUser(id: String, completion: @escaping (Result<GCUser, GCError>) -> Void) {
        db.collection(FirestoreCollections.Users).document(id).getDocument(as: GCUser.self) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
                
            case .failure(_):
                completion(.failure(.getError))
            }
        }
    }
    
    
    //MARK: - Users - ADD/UPDATE/DELETE -
    
    func add(user: GCUser, completion: @escaping (GCError?) -> Void) {
        let dictionary = makeFirestoreDictionary(with: user)
        db.collection(FirestoreCollections.Users).document(user.id).setData(dictionary) { error in
            guard error == nil else {
                completion(.addError)
                return
            }
            completion(nil)
        }
    }
    
    func update(user: GCUser, completion: @escaping (GCError?) -> Void) {
        let dictionary = makeFirestoreDictionary(with: user)
        db.collection(FirestoreCollections.Users).document(user.id).setData(dictionary) { error in
            guard error == nil else {
                completion(.updateError)
                return
            }
            completion(nil)
        }
    }
    
    func delete(userId: String, completion: @escaping (GCError?) -> Void) {
        db.collection(FirestoreCollections.Users).document(userId).delete { error in
            guard error == nil else {
                completion(.deleteError)
                return
            }
            completion(nil)
        }
    }
    
    //MARK: - Chats - GET -
    
    func getChats(userId: String, completion: @escaping (Result<[Chat], GCError>) -> Void) {
        db.collection(FirestoreCollections.Chats)
            .whereFilter(
                .orFilter([
                    .whereField("user1Id", isEqualTo: userId),
                    .whereField("user2Id", isEqualTo: userId)
                ])
            )
            .getDocuments { querySnapshot, error in
                guard let querySnapshot, error == nil else {
                    completion(.failure(.getError))
                    return
                }
                
                if querySnapshot.documents.count == 0 {
                    completion(.success([]))
                    return
                }
                
                do {
                    var chats = [Chat]()
                    
                    try querySnapshot.documents.forEach {
                        let chat = try $0.data(as: Chat.self)
                        self.getRelatedObjects(chat: chat) { chat in
                            guard let chat else {
                                completion(.failure(.relatedObjectGetError))
                                return
                            }
                            chats.append(chat)
                            if chats.count == querySnapshot.documents.count {
                                completion(.success(chats))
                            }
                        }
                    }
                } catch { completion(.failure(.jsonError)) }
            }
    }
    
    func getChat(user1Id: String, user2Id: String, advertisementId: String, completion: @escaping (Result<Chat, GCError>) -> Void) {
        db
            .collection(FirestoreCollections.Chats)
            .whereFilter(
                .andFilter([
                    .orFilter([.whereField("user1Id", isEqualTo: user1Id), .whereField("user2Id", isEqualTo: user2Id)]),
                    .orFilter([.whereField("user2Id", isEqualTo: user1Id), .whereField("user2Id", isEqualTo: user2Id)])
                ])
            )
            .whereField("advertisementId", isEqualTo: advertisementId)
            .getDocuments { querySnapshot, error in
                guard let querySnapshot, error == nil else {
                    completion(.failure(.getError))
                    return
                }
                
                do {
                    let chat = try querySnapshot.documents.first!.data(as: Chat.self)
                    
                    self.getRelatedObjects(chat: chat) { chat in
                        guard let chat else {
                            completion(.failure(.relatedObjectGetError))
                            return
                        }
                        
                        completion(.success(chat))
                    }
                } catch { completion(.failure(.jsonError)) }
                
            }
    }
    
    func getChat(chatId: String, completion: @escaping (Result<Chat, GCError>) -> Void) {
        db.collection(FirestoreCollections.Chats).document(chatId).getDocument(as: Chat.self) { result in
            switch result {
            case .success(let chat):
                self.getRelatedObjects(chat: chat) { chat in
                    guard let chat else {
                        completion(.failure(.relatedObjectGetError))
                        return
                    }
                    completion(.success(chat))
                }
                
            case .failure(_): completion(.failure(.getError))
            }
        }
    }
    
    //MARK: - Chats - ADD/UPDATE/DELETE -
    
    func add(chat: Chat, completion: @escaping (GCError?) -> Void) {
        let dictionary = makeFirestoreDictionary(with: chat)
        db.collection(FirestoreCollections.Chats).document(chat.id).setData(dictionary) { error in
            guard error == nil else {
                completion(.addError)
                return
            }
            completion(nil)
        }
    }
    
    func update(chat: Chat, completion: @escaping (GCError?) -> Void) {
        let dictionary = makeFirestoreDictionary(with: chat)
        db.collection(FirestoreCollections.Chats).document(chat.id).setData(dictionary) { error in
            guard error == nil else {
                completion(.updateError)
                return
            }
            completion(nil)
        }
    }
    
    func delete(chatId: String, completion: @escaping (GCError?) -> Void) {
        db.collection(FirestoreCollections.Chats).document(chatId).delete { error in
            guard error == nil else {
                completion(.deleteError)
                return
            }
            completion(nil)
        }
    }
    
    //MARK: - Messages - GET -
    
    func getMessages(ids: [String], completion: @escaping (Result<[Message], GCError>) -> Void) {
        if ids.count == 0 {
            completion(.success([]))
            return
        }
        
        var messages = [Message]()
        
        for id in ids {
            db.collection(FirestoreCollections.Messages).document(id).getDocument(as: Message.self) { result in
                switch result {
                case .success(let message):
                    messages.append(message)
                    if messages.count == ids.count { completion(.success(messages)) }
                    
                case .failure(_):
                    completion(.failure(.getError))
                }
            }
        }
    }
    
    func getMessage(id: String, completion: @escaping (Result<Message, GCError>) -> Void) {
        db.collection(FirestoreCollections.Messages).document(id).getDocument(as: Message.self) { result in
            switch result {
            case .success(let message): completion(.success(message))
            case .failure(_): completion(.failure(.getError))
            }
        }
    }
    
    //MARK: - Messages - ADD/UPDATE/DELETE
    
    func add(message: Message, completion: @escaping (GCError?) -> Void) {
        let dictionary = makeFirestoreDictionary(with: message)
        db.collection(FirestoreCollections.Messages).document(message.id).setData(dictionary) { error in
            guard error == nil else {
                completion(.addError)
                return
            }
            completion(nil)
        }
    }
    
    func update(message: Message, completion: @escaping (GCError?) -> Void) {
        let dictionary = makeFirestoreDictionary(with: message)
        db.collection(FirestoreCollections.Messages).document(message.id).setData(dictionary) { error in
            guard error == nil else {
                completion(.addError)
                return
            }
            completion(nil)
        }
    }
    
    func delete(messageId: String, completion: @escaping (GCError?) -> Void) {
        db.collection(FirestoreCollections.Messages).document(messageId).delete { error in
            guard error == nil else {
                completion(.deleteError)
                return
            }
            completion(nil)
        }
    }
    
    //MARK: - Make Firestore Dictionary -
    
    private func makeFirestoreDictionary(with advertisement: Advertisement) -> [String: Any] {
        return [
            "id": advertisement.id,
            "title": advertisement.title,
            "gameId": advertisement.gameId,
            "userId": advertisement.userId,
            "description": advertisement.description,
            "imageURL": advertisement.imageURL,
            "maximumDeliveryTime": advertisement.maximumDeliveryTime,
            "price": advertisement.price,
            "viewCount": advertisement.viewCount,
            "createdAt": advertisement.createdAt,
            "isActive": advertisement.isActive
        ]
    }
    
    private func makeFirestoreDictionary(with game: Game) -> [String: Any] {
        return [
            "id": game.id,
            "name": game.name,
            "imageURL": game.imageURL,
            "isPopular": game.isPopular
        ]
    }
    
    private func makeFirestoreDictionary(with user: GCUser) -> [String: Any] {
        return [
            "id": user.id,
            "email": user.email,
            "username": user.username,
            "fullname": user.fullname,
            "imageURL": user.imageURL,
            "phoneNumber": user.phoneNumber,
            "balance": user.balance,
            "successedOrder": user.successedOrder,
            "canceledOrder": user.canceledOrder,
            "isPhoneNumberVerified": user.isPhoneNumberVerified,
            "isEmailVerified": user.isEmailVerified,
            "isIdentityVerified": user.isIdentityVerified
        ]
    }
    
    private func makeFirestoreDictionary(with chat: Chat) -> [String: Any] {
        return [
            "id": chat.id,
            "user1Id": chat.user1Id,
            "user2Id": chat.user2Id,
            "advertisementId": chat.advertisementId,
            "messageIds": chat.messageIds
        ]
    }
    
    private func makeFirestoreDictionary(with message: Message) -> [String: Any] {
        return [
            "id": message.id,
            "userId": message.userId,
            "message": message.message,
            "date": message.date,
            "isReaded": message.isReaded,
            "isEdited": message.isEdited,
            "isDeleted": message.isDeleted
        ]
    }
    
    //MARK: - RelatedObject Setting -
    
    private func getRelatedObjects(advertisement: Advertisement, completion: @escaping (Advertisement?) -> Void) {
        var adv = advertisement
        //Game reference
        self.getGame(id: adv.gameId) { gameResult in
            switch gameResult {
            case .success(let game):
                adv.game = game
                
                //User reference
                self.getUser(id: adv.userId) { userResult in
                    switch userResult {
                    case .success(let user):
                        adv.user = user
                        completion(adv)
                        
                    case .failure(_): completion(nil)
                    }
                }
                
            case .failure(_): completion(nil)
            }
        }
    }
    
    private func getRelatedObjects(chat: Chat, completion: @escaping (Chat?) -> Void) {
        var cht = chat
        
        //Messages reference
        self.getMessages(ids: cht.messageIds) { messagesResult in
            switch messagesResult {
            case .success(let messages):
                cht.messages = messages
                //User1 reference
                self.getUser(id: cht.user1Id) { user1Result in
                    switch user1Result {
                    case .success(let user):
                        cht.user1 = user
                        //User2 reference
                        self.getUser(id: cht.user2Id) { user2Result in
                            switch user2Result {
                            case .success(let user):
                                cht.user2 = user
                                completion(cht)
                                
                            case .failure(_):
                                completion(nil)
                            }
                        }
                        
                    case .failure(_):
                        completion(nil)
                    }
                }
                
            case .failure(_):
                completion(nil)
            }
        }
        
    }
}
