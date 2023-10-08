//
//  ChatView.swift
//  ChatGPTSwiftUI
//
//  Created by Pelin AY on 8.10.2023.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel : ChatViewModel
    var body: some View {
        VStack{
            chatSelection
            ScrollViewReader{ scrollView in //kaydirma gorunumu
                List(viewModel.messages){message in
                    messageView(for: message)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .id(message.id)
                        .onChange(of: viewModel.messages){
                            newValue in scrollToButtom(scrollView: scrollView)
                        }
                }
                .listStyle(.plain)
                .background(Color(uiColor: .systemGroupedBackground))
            }
            messageInputView
        }
        .navigationTitle(viewModel.chat?.topic ?? "New Chat")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            viewModel.fetchData()
        }
    }
    func scrollToButtom(scrollView:ScrollViewProxy){
        guard !viewModel.messages.isEmpty, let lastMessage = viewModel.messages.last else{
            return
        }
        withAnimation{
            scrollView.scrollTo(lastMessage.id)
        }
    }
    var chatSelection : some View{
        Group{
            if let model = viewModel.chat?.model?.rawValue{
                Text(model)
            }else{
                Picker(selection: $viewModel.selectedModel){
                    ForEach(ChatModel.allCases,id: \.self){
                        model in Text(model.rawValue)
                    }
                }label:{
                    Text("")
                }
                .pickerStyle(.segmented)
                .padding()
            }
            
        }
        
    }
    func messageView(for message: AppMessage) -> some View{
        HStack{
            if (message.role == .user){
                Spacer()
            }
            Text(message.text)
                .padding(.horizontal)
                .padding(.vertical,14)
                .foregroundStyle(message.role == .user ? .white : .black)
                .background(message.role == .user ? .blue : .white)
                .clipShape(RoundedRectangle(cornerRadius: 14,style: .continuous))
            if (message.role == .assistant){
                Spacer()
            }
        }
    }
    var messageInputView : some View {
        HStack{
            TextField("Send a message ...", text: $viewModel.messageText)
                .padding()
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .onSubmit {
                    sendMessage()
                }
            Button{
                sendMessage()
            }label: {
                Text("Send")
                    .padding()
                    .foregroundStyle(.white)
                    .bold()
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            }
        }
        .padding()
    }
    func sendMessage(){
        Task{
            do{
                try await viewModel.sendMessage()
            }catch{
                print(error)
            }
        }
        
    }
}

#Preview {
    ChatView(viewModel: .init(chatId: ""))
}
