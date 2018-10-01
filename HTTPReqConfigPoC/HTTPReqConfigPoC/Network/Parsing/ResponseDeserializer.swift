import UIKit

protocol ResponseDeserializer {
    func parse(_ data: Data?) throws -> ResponseProtocol?
}
