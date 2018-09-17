import UIKit

struct TestResponse : ResponseProtocol {

    var statusCode: Int!
    var statusMessage: String!

    var a:Int? = 0
    var b:Int? = 0
    var c:String? = ""

    enum CodingKeys: String, CodingKey {
        case a = "a"
        case b = "b"
        case c = "c"
    }

    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let commons:(code:Int, message:String) = try self.readCommonProperties(from: decoder)
        statusCode = commons.code
        statusMessage = commons.message

        self.a =  try container.decodeIfPresent(Int.self, forKey: .a)
        
        self.b = try container.decodeIfPresent(Int.self, forKey: .b)

        self.c = try container.decodeIfPresent(String.self, forKey: .c)
    }
}
