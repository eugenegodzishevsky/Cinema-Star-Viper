// DetailsView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

struct DetailsView: View {
    @StateObject var presenter: DetailsPresenter
    var body: some View {
        backgroundView {
            VStack {
                switch presenter.state {
                case .loading:
                    shimmers
                case .success:
                    details
                default:
                    EmptyView()
                }
            }
            .onAppear {
                presenter.getDetails(id: presenter.id ?? 0)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: tabBarItemLeft)
        .navigationBarItems(trailing: tabBarItemRight)
    }

    private var details: some View {
        ScrollView(showsIndicators: false) {
            headerView
            aboutView
            actorsView
            countryView
            similarView
        }
        .padding(.top, 10)
    }

    private var tabBarItemLeft: some View {
        HStack {
            Button {
                presenter.detailsRouter?.goBack()
            } label: {
                Image("backArrow")
            }
        }
    }

    private var tabBarItemRight: some View {
        Button {
            presenter.isFavourite.toggle()
        } label: {
            Image(presenter.isFavourite ? "favourites2" : "favourite")
        }
    }

    private var headerView: some View {
        VStack {
            HStack {
                CachedImageView(url: presenter.details?.poster ?? "")
                    .scaledToFill()
                    .frame(width: 170, height: 200)
                    .cornerRadius(9)
                    .clipped()
                
                VStack {
                    Text(presenter.details?.nameOfFilm ?? "")
                        .foregroundColor(.white)
                    HStack {
                        Text("⭐️")
                        Text("\(String(format: "%.1f", presenter.details?.rankOfFilm ?? ""))")
                            .foregroundColor(.white)
                    }
                }
                Spacer()
            }
            Button("Смотреть") {
                presenter.isShowAlert.toggle()
            }
            .frame(width: 358, height: 48)
            .foregroundColor(.white)
            .background(Color(red: 43 / 255, green: 81 / 255, blue: 74 / 255))
            .cornerRadius(12)
            .padding(.vertical, 10)
            .alert("Упс!", isPresented: $presenter.isShowAlert) {} message: {
                Text("Функционал в разработке:(")
            }
        }
        .padding(.horizontal)
    }

    private var aboutView: some View {
        VStack {
            HStack(alignment: .bottom) {
                Text(presenter.details?.description ?? "")
                    .frame(width: 330, height: 100)
                    .font(.system(size: 16))
                Spacer()
                Button {
                    presenter.isfullInformationAboutFilm.toggle()
                } label: {
                    Image(presenter.isfullInformationAboutFilm ? "arrow2" : "arrow")
                }
                .padding(.top, -15)
            }
            .padding(.leading, -5)
            HStack {
                Text(
                    "\(presenter.details?.year ?? 0) / \(presenter.details?.countres ?? "") / \(presenter.convertTypeOfFilm())"
                        .replacingOccurrences(of: ",", with: "")
                )
                .foregroundColor(Color(red: 1 / 255, green: 1 / 255, blue: 0 / 255))
                .opacity(0.41)
                .font(.system(size: 16))
                .padding(.top, 10)
                Spacer()
            }
        }
        .padding(.horizontal)
    }

    private var actorsView: some View {
        VStack(alignment: .leading) {
            Text("Актеры и съемочная группа ")
                .foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(presenter.details?.persons ?? [], id: \.name) { actors in
                        VStack {
                            CachedImageView(url: actors.photo)
                                .frame(width: 46, height: 72)
                            Text(actors.name ?? "")
                                .font(.system(size: 8))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }
                        .frame(width: 55)
                    }
                }
            }
        }
        .padding(.leading)
        .padding(.top, 10)
    }

    private var countryView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Язык")
                    .foregroundColor(.white)
                Spacer().frame(height: 3)
                Text(presenter.details?.spokenLanguages ?? "")
                    .foregroundColor(Color(red: 1 / 255, green: 1 / 255, blue: 0 / 255))
                    .opacity(0.41)
                    .font(.system(size: 16))
                    .padding(.top, 1)
            }
            Spacer()
        }
        .padding(.horizontal)
    }

    private var similarView: some View {
        VStack(alignment: .leading) {
            Text("Смотрите также")
                .foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(presenter.details?.simularMovies ?? [], id: \.name) { film in
                        VStack(alignment: .leading) {
                            CachedImageView(url: film.poster.url)
                                .scaledToFill()
                                .frame(width: 170, height: 200)
                                .cornerRadius(9)
                                .clipped()
                            Text(film.name)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.top, 10)
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

    private var shimmers: some View {
        VStack(alignment: .leading) {
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 170, height: 200)
                    .padding(.trailing, 5)
                    .shimmering()
                VStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 202, height: 20)
                        .shimmering()
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 202, height: 20)
                        .padding(.top, 5)
                        .shimmering()
                }
                Spacer()
            }
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 358, height: 48)
                .padding(.vertical, 10)
                .shimmering()
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 330, height: 100)
                .padding(.vertical, 10)
                .shimmering()
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 202, height: 20)
                .shimmering()
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 202, height: 20)
                .padding(.top, 5)
                .shimmering()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0 ..< 6, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 97)
                            .padding(.top, 5)
                            .shimmering()
                    }
                }
            }
            VStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 202, height: 20)
                    .padding(.top, 5)
                    .shimmering()
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 202, height: 20)
                    .shimmering()
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 202, height: 20)
                    .padding(.top, 3)
                    .shimmering()
            }
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 170, height: 200)
                .padding(.top, 3)
                .shimmering()
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 202, height: 20)
                .padding(.top, 3)
                .shimmering()
        }
        .padding(.leading)
        .padding(.top, 200)
    }
}
