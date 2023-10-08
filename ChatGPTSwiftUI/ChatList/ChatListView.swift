//
//  ChatListView.swift
//  ChatGPTSwiftUI
//
//  Created by Pelin AY on 7.10.2023.
//

import SwiftUI

struct ChatListView: View {
    
    @StateObject var viewModel = ChatListViewModel()
    @EnvironmentObject var appState : AppState
    var body: some View {
        Group {
            switch viewModel.loadingState {
            case .loading, .none:
                Text("Loading Chats ... ")
            case .noResults:
                Text("No Chats ... ")
            case .resultFound:
                List{
                    ForEach(viewModel.chats){chat in
                        NavigationLink(value: chat.id) {
                            VStack(alignment: .leading, content: {
                                HStack{
                                    Text(chat.topic ?? "New Chat")
                                        .font(.headline)
                                    Spacer()
                                    Text(chat.model?.rawValue ?? "")
                                        .font(.caption2)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(chat.model?.tintColor ?? .white)
                                        .padding(6)
                                        .background((chat.model?.tintColor ?? .white).opacity(0.2))
                                        .clipShape(Capsule(style: .continuous))
                                }
                                Text(chat.lastMessageTimeAgo)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            })
                        }
                        .swipeActions {
                            Button(role: .destructive){
                                viewModel.deleteChat(chat: chat)
                            }label:{
                                Label("Delete", systemImage: "trash.fill")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Chats")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing){
                Button{
                    //to do
                    viewModel.showProfile()
                }label: {
                    Image(systemName: "person")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){
                Button{
                    //to do
                    //create chat
                    Task{
                        do{
                            let chatID = try await viewModel.createChat(user: appState.currentUser!.uid)
                            appState.navigationPath.append(chatID)
                        }catch{
                            print(error)
                        }
                    }
                }label: {
                    Image(systemName: "square.and.pencil")
                }
            }
            
        })
        .sheet(isPresented: $viewModel.isShowingProfileView){
            ProfileView()
        }
        .navigationDestination(for: String.self, destination: { chatId in
            ChatView(viewModel: .init(chatId : chatId))
        })
        .onAppear{
            if viewModel.loadingState == .none{
                viewModel.fetchData(user: appState.currentUser!.uid)
            }
        }
    }
}

#Preview {
    ChatListView()
}
