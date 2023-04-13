//  MainViewController.swift
//  Nikita Rekaev 13.04.2023

import UIKit
import ARKit
import GLTFSceneKit

final class MainViewController: UIViewController {

    // MARK: - Properties

    private let selfView: MainView
    private let constants: MainConstants

    private lazy var glbNode: SCNNode = makeGLBNode()

    // MARK: - Init

    init(selfView: MainView, constants: MainConstants) {
        self.selfView = selfView
        self.constants = constants
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        self.view = selfView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.setViewDelegate(with: self)
        selfView.setViewSession(with: getSession())
    }

}

extension MainViewController: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let anchor = anchor as? ARImageAnchor else { return }
        guard anchor.isTracked == true else { return }

        glbNode.position = SCNVector3(x: glbNode.position.x,
                                      y: glbNode.position.y,
                                      z: glbNode.position.z + 0.05)
        node.addChildNode(glbNode)
    }

}

// MARK: - Private methods

private extension MainViewController {

    func getSession() -> ARSession {
        let configuration = ARImageTrackingConfiguration()
        let session = ARSession()

        ImageLoader.shared.downloadImage(urlString: constants.imageURLString) { image in
            guard let cgImage = image?.cgImage else { return }
            let referenceImage = ARReferenceImage(cgImage, orientation: .up, physicalWidth: 0.1)
            configuration.trackingImages = Set([referenceImage])
            session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        }

        return session
    }

    func makeGLBNode() -> SCNNode {
        guard let url = URL(string: constants.modelURLString) else {
            print("Invalid URL")
            return SCNNode()
        }

        do {
            let sceneSource = GLTFSceneSource(url: url)
            let scene = try sceneSource.scene()
            return configureGLBNode(scene.rootNode)
        } catch {
            print("\(error.localizedDescription)")
            return SCNNode()
        }
    }

    func configureGLBNode(_ glbNode: SCNNode) -> SCNNode {
        glbNode.scale = constants.glbNodeScale
        glbNode.eulerAngles.z = constants.glbNodeEulerAngles
        glbNode.eulerAngles.x = constants.glbNodeEulerAngles
        glbNode.runAction(constants.glbNodeRotationAction)
        return glbNode
    }

}
