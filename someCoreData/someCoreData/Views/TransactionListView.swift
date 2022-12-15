//
//  TransactionListView.swift
//  someCoreData
//
//  Created by  illia on 15/12/2022.
//

import SwiftUI

struct TransactionListView: View {
    let transactions: [Transaction]
    let onDelete: (Transaction) -> Void
    var body: some View {
        List {
            ForEach(transactions) { t in
                HStack {
                    Text(t.title ?? "")
                    Spacer()
                    Text(t.amount as NSNumber, formatter: NumberFormatter.currency)
                }.padding(.horizontal)
            }.onDelete { index in
                guard let index = index.first else { return }
                onDelete(transactions[index])
            }
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(transactions: [], onDelete: { _ in })
    }
}
