import UIKit

/*
 Error Codes in general
 1xx (Informational): The request was received, continuing process
 2xx (Successful): The request was successfully received, understood, and accepted
 3xx (Redirection): Further action needs to be taken in order to complete the request
 4xx (Client Error): The request contains bad syntax or cannot be fulfilled
 5xx (Server Error): The server failed to fulfill an apparently valid request
 Reference
 /// https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
 /// https://www.cheatography.com/kstep/cheat-sheets/http-status-codes
 */

enum ErrorCode: Int {

    //MARK:Error Codes
    
    //200:Success
    case allOk
    
    //300-399
    case redirection
    
    //401:Client is unauthorized. Login.
    case unauthorized
    //400:Business error due to requesting data.
    case badRequest
    
    //(500-599) Error on the server.
    case serverError
    
    //Everything else.
    case unknown
    
    init(errorCode:Int?) {
        
        if let errCode = errorCode {
            switch errCode {
            case 200...299:
                self = .allOk
            case 401:
                self = .unauthorized
            case 400,402...499:
                self = .badRequest
            case 500...599:
                self = .serverError
            default:
                self = .unknown
            }
        } else {
            //If errorCode is not set, mark error as unknown.
            self = .unknown
        }
    }
}
