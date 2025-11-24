//
//  CartsView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI

struct CartsView: View {
    
    @ObservedObject var nm: NetworkManager
    @StateObject private var vm: CartViewModel

    init(nm: NetworkManager) {
        self.nm = nm
        _vm = StateObject(wrappedValue: CartViewModel(context: PersistenceController.shared.bgContext, nm: nm))
    }
    
    var body: some View {
        Text("Cart is Empty")
    }
}

#Preview {
    CartsView(nm: NetworkManager())
}
