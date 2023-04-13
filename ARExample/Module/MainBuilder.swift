//  MainBuilder.swift
//  Nikita Rekaev 13.04.2023

import UIKit

final class MainBuilder {

    // MARK: - Properties

    private let constants = MainConstants()

    // MARK: - Internal methods

    func buildMainModule() -> UIViewController {
        let view = MainView()
        let viewController = MainViewController(selfView: view, constants: constants)

        return viewController
    }
}
