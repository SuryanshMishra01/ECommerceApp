//
//  ProfileViewModel.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 24/11/25.
//


import SwiftUI
internal import Combine
internal import CoreData

class UserProfileViewModel: ObservableObject {

    private let repository = UserProfileRepository()

    @Published var profile: UserProfileModel?

    func createProfile(
        uid: String,
        email: String,
        firstName: String,
        lastName: String
    ) {

        let model = UserProfileModel(
            id: uid,
            firstName: firstName,
            lastName: lastName,
            email: email,
            addresses: []
        )

        repository.persistProfile(model)
        loadProfile(uid: uid)

        profile = model
    }

    func loadProfile(uid: String) {

        profile = repository.fetchProfile(by: uid)
    }

    func saveChanges() {

        guard let profile else { return }

        repository.updateProfile(profile)
    }
}
