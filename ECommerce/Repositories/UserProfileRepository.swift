//
//  ProfileRepository.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 11/03/26.
//


import Foundation
internal import CoreData

class UserProfileRepository {

    private let context = PersistenceController.shared.context

    func persistProfile(_ model: UserProfileModel) {

        _ = UserProfileEntity.fromModel(model, context: context)

        save()
    }

    func fetchProfile(by uid: String) -> UserProfileModel? {

        let request: NSFetchRequest<UserProfileEntity> = UserProfileEntity.fetchRequest()

        request.predicate = NSPredicate(format: "userid == %@", uid)

        do {
            let result = try context.fetch(request)
            return result.first?.toModel()
        } catch {
            print("Failed to fetch profile:", error)
            return nil
        }
    }

    func updateProfile(_ model: UserProfileModel) {

        let request: NSFetchRequest<UserProfileEntity> = UserProfileEntity.fetchRequest()
        request.predicate = NSPredicate(format: "userid == %@", model.id)

        if let entity = try? context.fetch(request).first {

            entity.firstName = model.firstName
            entity.lastName = model.lastName
            entity.email = model.email

            save()
        }
    }

    func save() {
        if context.hasChanges {
            try? context.save()
        }
    }
}
       
