//  ImmersiveView.swift

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        RealityView { content, attachments in
            if let entity = attachments.entity(for: "Board") {
                entity.components[BillboardComponent.self] = BillboardComponent()
                entity.position = SIMD3<Float>(0, 1, -2)
                content.add(entity)

                // Add an ImageBasedLight for the immersive content here
                // Put skybox here
            }
        } attachments: {
            Attachment(id: "Board") {
                Text("Billboard")
                    .font(.system(size: 100))
                    .padding(64)
                    .background(.green)
            }
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}