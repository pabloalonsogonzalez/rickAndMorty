//
//  ProfileView.swift
//  Gutify
//
//  Created by Pablo Alonso Gonzalez.
//

import SwiftUI
import Combine

struct ProfileView: View {
    
    @ObservedObject var input: ProfileViewModel.Input
    @ObservedObject var output: ProfileViewModel.Output
    
    private let cancelBag = CancelBag()
    
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        BaseView(output: output) {
                VStack {
                    List {
                        Section {
                            HStack {
                                Image(.author)
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                    .clipShape(Circle())
                                VStack(alignment: .leading) {
                                    Text("AuthorName")
                                        .font(.headline)
                                    Text("AuthorTitle")
                                        .font(.caption)
                                }
                            }
                        }
                        Section("AboutMeHeader") {
                            Label("AuthorMail", systemImage: "envelope.fill")
                            Label("AuthorPhone", systemImage: "phone.fill")
                            Label("AuthorLocation", systemImage: "location.fill")
                        }
                        Section("SocialNetworksHeader") {
                            TappableCell(title: String(localized: "LinkedInItem"),
                                         foregroundColor: Color(.accent),
                                         systemImage: "person.crop.circle.fill") {
                                guard let linkedinUrl = URL(string: RickAndMortyConstants.linkedinUrl) else { return }
                                openURL(linkedinUrl)
                            }
                        }
                    }
                }
            output.addNavigations
        }
        .navigationTitle("TabItemProfile")
    }
    
    init(viewModel: ProfileViewModel) {
        let input = ProfileViewModel.Input()
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
}

struct TappableCell: View {
    var title: String
    var foregroundColor: Color?
    var systemImage: String
    var tapGesture: () -> ()
    var body: some View {
        HStack {
            Label(title, systemImage: systemImage)
                .foregroundStyle(foregroundColor ?? .black)
            Spacer()
        }
        // make whole item tappable
        .contentShape(Rectangle())
        .onTapGesture(perform: tapGesture)
    }
}

#Preview {
    DefaultProfileAssembler.resolve()
}
