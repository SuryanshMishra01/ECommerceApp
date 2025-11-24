//
//  ProfileViewModel.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 24/11/25.
//


import SwiftUI
internal import Combine
import CoreData


class ProfileViewModel: ObservableObject {
    
    private let context: NSManagedObjectContext
    private var profile: Profile?
    
    @Published var fullName: String = "Suryansh Mishra"
    @Published var email: String = "suryansh@example.com"
    @Published var phone: String = "+91 1234567890"

    @Published var street: String = "123, ABC Road"
    @Published var city: String = "Noida"
    @Published var pincode: String = "201305"

    @Published var notifications: Bool = true
    @Published var darkMode: Bool = false
    
    init(context: NSManagedObjectContext){
        self.context = context
        loadProfile()
    }
   
    
    func loadProfile(){
        let result = Profile.fetchRequest()
        do{
            
            if let existing = try context.fetch(result).first {
                print(existing)
                self.profile = existing
                self.fullName = existing.fullName ?? ""
                self.email = existing.email ?? ""
                self.phone = existing.phone ?? ""
                self.street = existing.street ?? ""
                self.city = existing.city ?? ""
                self.pincode = existing.pincode ?? ""
            }else{
                let newProfile = Profile(context: context)
                self.profile = newProfile
                newProfile.fullName = self.fullName
                newProfile.email = self.email
                newProfile.phone = self.phone
                newProfile.street = self.street
                newProfile.city = self.city
                newProfile.pincode = self.pincode
                newProfile.notifications = self.notifications
                newProfile.darkMode = self.darkMode
            
                saveChanges()
            }
        }catch{
            print("Error in loading profile: \(error.localizedDescription)")
        }
    }
    
    
    func resetChanges(){
        loadProfile()
    }
    
    func saveChanges(){

            guard let profile = profile else { return }

            profile.fullName = fullName
            profile.email = email
            profile.phone = phone
            profile.street = street
            profile.city = city
            profile.pincode = pincode
            profile.notifications = notifications
            profile.darkMode = darkMode

            do {
                try PersistenceController.shared.save(context: self.context)
            print("Profile saved")
            } catch {
                print("Save error:", error.localizedDescription)
            }
        
    }
    
        
    
}
