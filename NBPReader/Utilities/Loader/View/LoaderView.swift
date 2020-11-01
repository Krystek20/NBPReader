import UIKit
import Combine

final class LoaderView: UIView {

    // MARK: - Views

    private let indicatorView = Subviews.indicatorView

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        setupSelf()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Setup

    private func setupSelf() {
        backgroundColor = UIColor.white.withAlphaComponent(0.6)
        isUserInteractionEnabled = false
        alpha = .zero
    }

    private func setupLayout() {
        addSubview(indicatorView)
        indicatorView.setConstraints([
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Public
    
    func startLoading() {
        UIView.animate(
            withDuration: 0.3,
            animations: { [weak self] in
                self?.alpha = 1.0
            }
        )
        indicatorView.startAnimating()
        indicatorView.isHidden = false
    }

    func stopLoading() {
        UIView.animate(
            withDuration: 0.3,
            animations: { [weak self] in
                self?.alpha = .zero
            },
            completion: { [weak self] isSuccess in
                guard isSuccess else { return }
                self?.indicatorView.stopAnimating()
            }
        )
    }
}

private enum Subviews {
    static var indicatorView: UIActivityIndicatorView {
        UIActivityIndicatorView()
    }
}
