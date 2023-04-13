//  MainView.swift
//  Nikita Rekaev 13.04.2023

import UIKit
import ARKit
import GLTFSceneKit

final class MainView: UIView {

    // MARK: - Properties

    private let arSceneView = ARSCNView(frame: .zero)

    // MARK: - layoutSubviews

    override func layoutSubviews() {
        super.layoutSubviews()
        setViewPosition()
    }

    // MARK: - Internal methods

    func setViewSession(with session: ARSession) {
        arSceneView.session = session
    }

    func setViewDelegate(with delegate: ARSCNViewDelegate) {
        arSceneView.delegate = delegate
    }
}

// MARK: - Private methods

private extension MainView {

    func setViewPosition() {
        self.addSubview(arSceneView)
        arSceneView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            arSceneView.topAnchor.constraint(equalTo: self.topAnchor),
            arSceneView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            arSceneView.leftAnchor.constraint(equalTo: self.leftAnchor),
            arSceneView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }

}
