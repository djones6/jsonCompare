import Vapor
import HTTP

let drop = try Droplet()
drop.log.enabled = [.error, .fatal]

let doubles:[String:Double] = ["A": 1.1, "B": 2.2, "C": 3.3, "D": 4.4, "E": 5.5, "F": 6.6, "G": 7.7, "H": 8.8, "I": 9.9, "J": 11.0]

let structuredData:[String:Any] = ["Name": "Bob", "Age": 24, "Occupation": "Programmer", "Height": 173.4, "Address": ["221B Baker Street", "Marylebone", "London", "NW1 6XE"], "Favourite Numbers": [1, 2.3, 456.7, 89.012], "Employed": true]

// TechEmpower test 6: plaintext
drop.get("plaintext") { request in
    let response = Response(status: .ok, body: "Hello, World!")
    response.headers["Content-Type"] = "text/plain"
    return response
}

// TechEmpower test 1: JSON serialization
drop.get("json") { request in
    let json = try JSON(node: ["message":"Hello, World!"])
    let response = try Response(status: .ok, json: json)
    return response
}

drop.get("jsonDoubles") { request in
    let json = try JSON(node: doubles)
    let response = try Response(status: .ok, json: json)
    return response
}

drop.get("jsonData") { request in
    let json = try JSON(node: structuredData)
    let response = try Response(status: .ok, json: json)
    return response
}

try drop.run()
