//  MainConstants.swift
//  Nikita Rekaev 13.04.2023

import Foundation
import SceneKit

struct MainConstants {
    let imageURLString = "https://user74522.clients-cdnnow.ru/static/uploads/mrk6440mark.png"
    let modelURLString = "https://user74522.clients-cdnnow.ru/static/uploads/mrk6564obj.glb"
    let glbNodeScale = SCNVector3(x: 0.05, y: 0.05, z: 0.05)
    let glbNodeEulerAngles: Float = -.pi / 2
    let glbNodeRotationAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0,
                                                                       y: 0,
                                                                       z: CGFloat(1 * Double.pi),
                                                                       duration: 5))
}
