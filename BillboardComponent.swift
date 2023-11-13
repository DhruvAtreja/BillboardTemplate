//  BillboardComponent.swift

import ARKit
import RealityKit
import SwiftUI

public struct BillboardComponent: Component, Codable {
    public init() {}
}

public struct BillboardSystem: System {
    static let query = EntityQuery(where: .has(BillboardComponent.self))
    private let arkitSession = ARKitSession()
    private let worldTrackingProvider = WorldTrackingProvider()

    public init(scene: RealityKit.Scene) {
        setUpSession()
    }

    func setUpSession() {
        Task {
            do {
                try await arkitSession.run([worldTrackingProvider])
            } catch {
                print("Error: \(error)")
            }
        }
    }

    public func update(context: SceneUpdateContext) {
        let entities = context.scene.performQuery(Self.query).map({ $0 })
        guard !entities.isEmpty,
           let deviceAnchor = worldTrackingProvider.queryDeviceAnchor(atTimestamp:
                                                CACurrentMediaTime()) else { return }
        let cameraTransform = Transform(matrix: deviceAnchor.originFromAnchorTransform)

        for entity in entities {
            let translation = entity.transform.translation
            entity.look(at: cameraTransform.translation,
                        from: entity.position(relativeTo: nil),
                        relativeTo: nil,
                        forward: .positiveZ)
            entity.transform.translation = translation
        }
    }
}