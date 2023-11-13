// BillboardComponentTestApp.swift
import SwiftUI

@main
struct BillboardComponentTestApp: App {
    init() {
        BillboardComponent.registerComponent()
        BillboardSystem.registerSystem()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection:
                .constant(.mixed), in: .mixed)
    }
}