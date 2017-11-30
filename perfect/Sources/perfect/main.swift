/*
 * Copyright IBM Corporation 2016
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import Foundation

// Create HTTP server.
let server = HTTPServer()

// Register your own routes and handlers
var routes = Routes()

let doubles:[String:Double] = ["A": 1.1, "B": 2.2, "C": 3.3, "D": 4.4, "E": 5.5, "F": 6.6, "G": 7.7, "H": 8.8, "I": 9.9, "J": 11.0]

let structuredData:[String:Any] = ["Name": "Bob", "Age": 24, "Occupation": "Programmer", "Height": 173.4, "Address": ["221B Baker Street", "Marylebone", "London", "NW1 6XE"], "Favourite Numbers": [1, 2.3, 456.7, 89.012], "Employed": true]

// TechEmpower test #6: Plaintext
routes.add(method: .get, uri: "/plaintext", handler: {
    request, response in
        response.setHeader(.contentType, value: "text/plain")
        response.appendBody(string: "Hello, World!")
        response.completed()
    }
)

// TechEmpower test #1: JSON 
routes.add(method: .get, uri: "/json", handler: {
    request, response in
        do { 
            try response.setBody(json: ["message":"Hello, World!"])
        } catch let error {
            Log.error(message: "Could not encode JSON: \(error)")
            response.status = .internalServerError
        }
        response.completed()
})

routes.add(method: .get, uri: "/jsonDoubles", handler: {
    request, response in
        do { 
            try response.setBody(json: doubles)
        } catch let error {
            Log.error(message: "Could not encode JSON: \(error)")
            response.status = .internalServerError
        }
        response.completed()
})

routes.add(method: .get, uri: "/jsonData", handler: {
    request, response in
        do { 
            try response.setBody(json: structuredData)
        } catch let error {
            Log.error(message: "Could not encode JSON: \(error)")
            response.status = .internalServerError
        }
        response.completed()
})

// Add the routes to the server.
server.addRoutes(routes)
server.serverPort = 8080

// Set a document root.
// This is optional. If you do not want to serve static content then do not set this.
// Setting the document root will automatically add a static file handler for the route /**
server.documentRoot = "./webroot"

do {
	// Launch the HTTP server.
	try server.start()
} catch PerfectError.networkError(let err, let msg) {
	print("Network error thrown: \(err) \(msg)")
}
