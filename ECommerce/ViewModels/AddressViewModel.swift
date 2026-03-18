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
        
    }
    
    func saveAddress(_ address: AddressModel){
        repository.addAddress(address)
        loadAllAddress()
    }
    
    
    func setDefault(_ address: AddressModel) {
        defaultAddress = address
    }
    
    func deleteAddress(id: UUID){
        repository.deleteAddress(id: id)
        loadAllAddress()
    }
}
