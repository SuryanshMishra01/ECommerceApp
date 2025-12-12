//
//  ProfileViewModel.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 24/11/25.
//


import SwiftUI
internal import Combine
internal import CoreData


class ProfileViewModel: ObservableObject {
    
    private let context: NSManagedObjectContext
    private var profile: Profile?
    
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""

    @Published var street: String = ""
    @Published var city: String = ""
    @Published var pincode: String = ""

 
    
    init(context: NSManagedObjectContext){
        self.context = context
        
    }
   
    
    func loadProfile(byUID: String){
        let result = Profile.fetchRequest()
        result.predicate = NSPredicate(format: "uid == %@", byUID)
        result.fetchLimit = 1
        do{
            
            if let existing = try context.fetch(result).first {
                print(existing)
               apply(existing)
            
            }else{
                let newProfile = Profile(context: context)
                self.profile = newProfile
                newProfile.fullName = self.fullName
                newProfile.email = self.email
                newProfile.phone = self.phone
                newProfile.street = self.street
                newProfile.city = self.city
                newProfile.pincode = self.pincode
          
                saveChanges()
            }
        }catch{
            print("Error in loading profile: \(error.localizedDescription)")
        }
    }
    
    
    func resetChanges(){
        if let profile = self.profile{
            apply(profile)
        }
    }
    
    func saveChanges(){

            guard let profile = profile else { return }

            profile.fullName = fullName
            profile.email = email
            profile.phone = phone
            profile.street = street
            profile.city = city
            profile.pincode = pincode
          

            do {
                try PersistenceController.shared.save(context: self.context)
            print("Profile saved")
            } catch {
                print("Save error:", error.localizedDescription)
            }
        
    }
    
    
    private func apply (_ profile: Profile){
        self.profile = profile
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            
            self.fullName = profile.fullName ?? ""
            self.email = profile.email ?? ""
            self.phone = profile.phone ?? ""
            self.street = profile.street ?? ""
            self.city = profile.city ?? ""
            self.pincode = profile.pincode ?? ""
            
            
        }
    }
    
        
    
}
