//
//  BugReportView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 25/11/25.
//

import SwiftUI

struct BugReportView: View {
    @State private var bugReportTitle: String = ""
    @State private var bugReportDescription: String = ""

    var body: some View {
        VStack{
            HStack{
                Text("Bug Report ")
                    .font(Font.title2.bold())
                    .foregroundColor(Color(.systemBlue))
                    
                Image(systemName: "pencil.and.list.clipboard")
                    .font(.title2)
            }
            .padding()
          
                Form{
                    Text("Title")
                       
                    TextField("",text: $bugReportTitle, prompt: Text("Enter a title"))
                        .padding(.bottom, 40)
                
                    
                    Text("Description")
                    
                ZStack(alignment: .topLeading){
                        if bugReportDescription.isEmpty{
                            Text("Enter a description")
                                .foregroundColor(AppColors.textSecondary)
                                .padding(.top, 10)
                                .padding(.leading, 5)
                            
                            
                        }
                        
                        TextEditor(text: $bugReportDescription)
                            .background(Color.clear)
                            .scrollContentBackground(.hidden)
                            .padding(.top, 10)
                            .padding(.leading, 5)
                    }
                    .frame(height: 150)
                    .overlay{
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(AppColors.textSecondary.opacity(0.3), lineWidth: 1)
                    }
                }
            Button("Submit"){
                
            }
            .foregroundColor(Color.blue)
            .cornerRadius(10)
            .padding(20)
        }
    }
}

#Preview {
    BugReportView()
}
