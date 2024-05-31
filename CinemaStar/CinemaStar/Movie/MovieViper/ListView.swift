// ListView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

struct ListView: View {
    @StateObject var presenter: ListPresenter

    var body: some View {
        NavigationView {
            backgroundView {
                VStack {
                    HStack {
                        headerTitle
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 15)
                    if #available(iOS 16.0, *) {
                        switch presenter.state {
                        case .loading:
                            shimmer
                        case .success:
                            filmsView
                        default:
                            EmptyView()
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                }
                .onAppear {
                    presenter.getFilms()
                }
            }
        }
    }

    private var headerTitle: some View {
        Text(Strings.title)
            .font(.custom(Strings.verdana, size: 20))
        + Text(Strings.cinemaStar)
            .font(.custom(Strings.verdanaBold, size: 18))
    }

    private var filmsView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(presenter.films ?? [], id: \.id) { film in
                    VStack {
                        CachedImageView(url: film.poster)
                                                       .scaledToFill()
                                                       .frame(width: 170, height: 200)
                                                       .cornerRadius(9)
                                                       .clipped()
                        VStack(alignment: .leading) {
                            Text(film.name)
                                .frame(height: 30)
                                .padding(.bottom, 1)
                                .foregroundColor(.white)
                            HStack {
                                Text("⭐️")
                                Text("\(String(format: "%.1f", film.rating))")
                                Spacer()
                            }
                            .foregroundColor(.white)
                        }
                        .padding(.leading, 5)
                    }
                    .onTapGesture {
                        presenter.goToDetail(id: film.id)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
    }

    private var shimmer: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(0 ..< 6, id: \.self) { item in
                    VStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 170, height: 200)
                            .shimmering()
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 170, height: 40)
                            .shimmering()
                    }
                    .padding(.bottom, 16)
                }
            }
            .padding(.horizontal, 10)
        }
    }

    private func backgroundView<Content: View>(content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 179 / 255, green: 141 / 255, blue: 87 / 255),
                        Color(red: 43 / 255, green: 81 / 255, blue: 74 / 255)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = ListPresenter()
        ListView(presenter: presenter)
    }
}
