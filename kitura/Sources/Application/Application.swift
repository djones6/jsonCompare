import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

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
            try response.status(.OK).send(json: result).end()
        }

        router.get("/jsonDoubles") {
        _, response, _ in
            try response.status(.OK).send(json: self.doubles).end()
        }

        router.get("/jsonData") {
        _, response, _ in
            try response.status(.OK).send(json: self.structuredData).end()
        }

        initializeHealthRoutes(app: self)

    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
}
