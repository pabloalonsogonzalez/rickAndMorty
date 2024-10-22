//
//  TabBarView.swift
//  Gutify
//
//  Created by Pablo Alonso Gonzalez.
//

import SwiftUI

struct TabItemData {
    let image: String
    let title: String
}

enum Tab: Int, CaseIterable {
    case home
    case episodes
    case profile
    
    var tabItem: TabItemData {
        switch self {
        case .home:
            TabItemData(image: "person.3.sequence.fill",
                        title: String(localized: "TabItemHome"))
        case .episodes:
            TabItemData(image: "tv.fill",
                        title: String(localized: "TabItemEpisodes"))
        case .profile:
            TabItemData(image: "person.crop.circle.fill",
                        title: String(localized: "TabItemProfile"))
        }
    }
    
    var route: Route {
        switch self {
        case .home:
                .home
        case .episodes:
                .episodes
        case .profile:
                .profile
        }
    }
}

struct TabBarView: View {
    
    var tabs: [Tab] {
        Tab.allCases
    }
    @State var selectedIndex: Int = 0
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    var body: some View {
        TabView(selection: $selectedIndex,
                content:  {
            ForEach(tabs.indices, id: \.self) { index in
                NavigationStack {
                    tabs[index].route.view
                }
                .tabItem {
                    Text(tabs[index].tabItem.title)
                    Image(systemName: tabs[index].tabItem.image)
                        .renderingMode(.template)
                }
                .tag(index)
            }
        })
        .tint(Color(.accent))
        
    }
}

#Preview {
    TabBarView()
}
