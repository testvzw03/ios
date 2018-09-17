import UIKit

protocol ResponseDeserializer {
    func parse(_ data: Data?) -> (ResponseProtocol?, NSError?)
}
