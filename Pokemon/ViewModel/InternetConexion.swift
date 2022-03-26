//
//  InternetConexion.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 26/03/22.
//

import Foundation
import Network

final class InternetConexion: ObservableObject {
    @Published var isFailConexion = false
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isFailConexion = path.status != .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
