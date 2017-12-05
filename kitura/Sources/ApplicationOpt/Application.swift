import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health
import PerfectLib

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

extension StringProtocol {

  var _ns: NSString {
    return self._ephemeralString._bridgeToObjectiveC()
  }

  public func dataOpt(using encoding: String.Encoding) -> Data? {
    let ephemeralString = _ephemeralString
    if ephemeralString._core.isASCII {
        switch encoding {
                case .ascii: fallthrough
                case .nonLossyASCII: fallthrough
                case .utf8:
print("Opt")
                    return Data(bytes: UnsafeRawPointer(ephemeralString._core.startASCII), count: ephemeralString._core.count)
                default:
                    return _ns.data(using: encoding.rawValue)
        }
    }
    return _ns.data(using: encoding.rawValue)
  }

}

public class App {
    let router = Router()
    let cloudEnv = CloudEnv()

    let doubles:[String:Double] = ["A": 1.1, "B": 2.2, "C": 3.3, "D": 4.4, "E": 5.5, "F": 6.6, "G": 7.7, "H": 8.8, "I": 9.9, "J": 11.0]

    let structuredData:[String:Any] = ["Name": "Bob", "Age": 24, "Occupation": "Programmer", "Height": 173.4, "Address": ["221B Baker Street", "Marylebone", "London", "NW1 6XE"], "Favourite Numbers": [1, 2.3, 456.7, 89.012], "Employed": true]

    public init() throws {
    }

    func postInit() throws {

        // Endpoints
        router.get("/plaintext") {
        _, response, _ in
            try response.status(.OK).send("Hello, World!").end()
        }

        router.get("/json") {
        _, response, _ in
            let result = ["message":"Hello, World!"]
            let json = try result.jsonEncodedString().dataOpt(using: .utf8)!
            try response.status(.OK).send(data: json).end()
        }

        router.get("/jsonDoubles") {
        _, response, _ in
            let json = try self.doubles.jsonEncodedString().dataOpt(using: .utf8)!
            try response.status(.OK).send(data: json).end()
        }

        router.get("/jsonData") {
        _, response, _ in
            let json = try self.structuredData.jsonEncodedString().dataOpt(using: .utf8)!
            try response.status(.OK).send(data: json).end()
        }

        initializeHealthRoutes(app: self)

    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
}
