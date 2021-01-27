import Foundation
import Network

enum ConnectionType{
    case wifi
    case ethernet
    case cellular
    case unknown
}

class NetworkMonitor {
    static let instance = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
  
    public private(set) var connectionType: ConnectionType = .unknown
    
   
    
    private init(){
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring(){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
        }
    }
    
    public func stopMonitoring(){
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath){
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        }else if path.usesInterfaceType(.cellular){
            connectionType = .cellular
        }else if path.usesInterfaceType(.wiredEthernet){
            connectionType = .ethernet
        }
    }
}
