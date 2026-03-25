//
//  AddressViewModel.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 17/03/26.
//

import Foundation
internal import Combine

class AddressViewModel: ObservableObject {
    
    @Published var defaultAddress: AddressModel? = nil
    @Published var addressList: [AddressModel] = []
    private let repository = AddressRepository()
   
 
    func loadAllAddress(){
        addressList = repository.fetchAllAddress()
        if defaultAddress == nil{
            for address in addressList {
                if address.isDefault {
                    self.defaultAddress = address
                }
            }
        }
        
    }
    
    func saveAddress(_ address: AddressModel){
        repository.addAddress(address)
        loadAllAddress()
    }
    
    
    func setDefault(_ address: AddressModel) {
        defaultAddress = address
        repository.setDefault(address)
    }
    
    func deleteAddress(id: UUID){
        repository.deleteAddress(id: id)
        loadAllAddress()
    }
}
