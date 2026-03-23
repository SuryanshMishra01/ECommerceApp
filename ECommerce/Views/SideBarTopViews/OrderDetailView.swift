import SwiftUI

struct OrderDetailView: View {

    let order: OrderModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            // MARK: Header
            HStack {
                Text("Order Details")
                    .font(.title2.bold())

                Spacer()

                Button("Close") {
                    dismiss()
                }
                .keyboardShortcut(.cancelAction)
            }

            Divider()

            // MARK: Order Info
            VStack(alignment: .leading, spacing: 10) {

                Text("Order ID: \(order.id.uuidString)")
                Text("Date: \(order.timestamp.formatted(date: .abbreviated, time: .shortened))")
                Text("Total Items: \(order.quantity)")
                Text("Total Price: $\(order.totalPrice, specifier: "%.2f")")
            }
            .font(.body)

            Divider()

            // MARK: Products
            Text("Products")
                .font(.headline)

            ScrollView {
                VStack(alignment: .leading, spacing: 10) {

                    ForEach(order.products) { product in

                        HStack {

                            Text(product.title)
                                .font(.body)

                            Spacer()

                            Text("$\(product.price, specifier: "%.2f")")
                                .foregroundStyle(AppColors.textSecondary)
                        }

                        Divider()
                    }
                }
            }

            Spacer()
        }
        .padding(20)
    }
}
