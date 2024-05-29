// DetailsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный экран приложения
final class DetailsViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let alertTitleText = "Упс!"
        static let alertDescription = "Функционал в разработке :("
        static let alertOKButtonText = "OK"
        static let alertErrorTitleText = "Ошибка"
        static let alertErrorDescription = "Попробуйте зайти позже"
        static let alertNoDataDescription = "Не найдены фильмы"
    }

    // MARK: - Visual Components

    private let gradientLayer = CAGradientLayer()

    private let saveButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private let tableView = UITableView()

    // MARK: - Public Properties

    var viewModel: DetailsViewModelProtocol? {
        didSet {
            viewModel?.updateTableView = tableView.reloadData
            viewModel?.moviesRequest()
        }
    }

    // MARK: - Private Properties

    private let tableSections: [CellType] = [.movieName, .about, .actors, .recommendations]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addGradientLayer()
        configureTableView()
        setLikeButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Private Methods

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAlertAction = UIAlertAction(title: Constants.alertOKButtonText, style: .cancel)
        alert.addAction(okAlertAction)
        present(alert, animated: true)
    }

    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        saveButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        navigationItem.backAction = UIAction(handler: { [weak self] _ in
            self?.viewModel?.openMainScreen()
        })
        view.layer.addSublayer(gradientLayer)
        view.addSubview(tableView)
    }

    private func configureTableView() {
        tableView.register(MovieDescriptionCell.self, forCellReuseIdentifier: MovieDescriptionCell.identifier)
        tableView.register(MovieNameShimmerCell.self, forCellReuseIdentifier: MovieNameShimmerCell.identifier)
        tableView.register(DetailsCell.self, forCellReuseIdentifier: DetailsCell.identifier)
        tableView.register(DetailsShimmerCell.self, forCellReuseIdentifier: DetailsShimmerCell.identifier)
        tableView.register(ActorsCell.self, forCellReuseIdentifier: ActorsCell.identifier)
        tableView.register(ActorsShimmerCell.self, forCellReuseIdentifier: ActorsShimmerCell.identifier)
        tableView.register(SimilarMoviesCell.self, forCellReuseIdentifier: SimilarMoviesCell.identifier)
        tableView.register(SimilarMoviesShimmerCell.self, forCellReuseIdentifier: SimilarMoviesShimmerCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(33)
            make.bottom.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
        }
    }

    private func addGradientLayer() {
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.gradientUp.cgColor, UIColor.gradientDown.cgColor]
    }

    private func setLikeButton() {
        let image = viewModel?.checkLikeButtonState()
        saveButton.setImage(image, for: .normal)
    }

    @objc private func likeButtonTapped() {
        viewModel?.heartTapped()
        saveButton.setImage(viewModel?.returnHeartImage(), for: .normal)
    }
}

// MARK: - Добавление типов ячеек

extension DetailsViewController {
    /// Типы ячеек
    private enum CellType {
        /// Имя, обложка, рейтинг фильма
        case movieName
        /// О фильме
        case about
        /// Актеры
        case actors
        /// Рекомендации
        case recommendations
    }
}

// MARK: - DetailViewController + UITableViewDataSource

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel?.state {
        case let .data(movieDetails) where movieDetails.similarMovies.isEmpty:
            return tableSections.count - 1
        default:
            return tableSections.count
        }
    }
}

// MARK: - DetailViewController + UITableViewDelegate

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel?.state {
        case let .data(movieDetails):
            tableView.isScrollEnabled = true
            tableView.allowsSelection = false
            saveButton.isHidden = false
            return setDataCell(indexPath: indexPath, movieDetails: movieDetails)
        case .error:
            showAlert(title: Constants.alertErrorTitleText, message: Constants.alertErrorDescription)
            fallthrough
        default:
            tableView.isScrollEnabled = false
            tableView.allowsSelection = false
            saveButton.isHidden = true
            return setShimmerCell(indexPath: indexPath)
        }
    }

    private func setDataCell(indexPath: IndexPath, movieDetails: MovieDetails) -> UITableViewCell {
        switch tableSections[indexPath.row] {
        case .movieName:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieDescriptionCell.identifier,
                for: indexPath
            ) as? MovieDescriptionCell
            else { return UITableViewCell() }
            cell.setupLabel(movieDetails: movieDetails) { [weak self] in
                self?.showAlert(title: Constants.alertTitleText, message: Constants.alertDescription)
            }
            guard let url = movieDetails.imageURL else { return UITableViewCell() }
            viewModel?.fetchMovieImage(url: url) { imageData in
                cell.setupImage(imageData: imageData)
            }
            return cell
        case .about:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DetailsCell.identifier,
                for: indexPath
            ) as? DetailsCell
            else { return UITableViewCell() }
            cell.setupLabel(movieDetails: movieDetails)
            return cell
        case .actors:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ActorsCell.identifier,
                for: indexPath
            ) as? ActorsCell
            else { return UITableViewCell() }
            cell.setInfo(movieDetails: movieDetails)
            cell.fetchImage = viewModel?.fetchMovieImage
            return cell
        case .recommendations:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SimilarMoviesCell.identifier,
                for: indexPath
            ) as? SimilarMoviesCell
            else { return UITableViewCell() }
            cell.setInfo(movies: movieDetails.similarMovies)
            cell.fetchImage = viewModel?.fetchMovieImage
            return cell
        }
    }

    private func setShimmerCell(indexPath: IndexPath) -> UITableViewCell {
        switch tableSections[indexPath.row] {
        case .movieName:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieNameShimmerCell.identifier,
                for: indexPath
            ) as? MovieNameShimmerCell
            else { return UITableViewCell() }
            return cell
        case .about:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DetailsShimmerCell.identifier,
                for: indexPath
            ) as? DetailsShimmerCell
            else { return UITableViewCell() }
            return cell
        case .actors:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ActorsShimmerCell.identifier,
                for: indexPath
            ) as? ActorsShimmerCell
            else { return UITableViewCell() }
            return cell
        case .recommendations:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SimilarMoviesShimmerCell.identifier,
                for: indexPath
            ) as? SimilarMoviesShimmerCell
            else { return UITableViewCell() }
            return cell
        }
    }
}
