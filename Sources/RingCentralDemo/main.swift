import RingCentral
import Foundation
import Alamofire

let dict = ProcessInfo.processInfo.environment
let options = RingCentralOptions(
    clientId: dict["RINGCENTRAL_CLIENT_ID"]!, 
    clientSecret: dict["RINGCENTRAL_CLIENT_SECRET"]!, 
    server: dict["RINGCENTRAL_SERVER_URL"]!
)
let rc = RingCentral(options: options)
rc.authorize(
    username: dict["RINGCENTRAL_USERNAME"]!, 
    ext: dict["RINGCENTRAL_EXTENSION"], 
    password: dict["RINGCENTRAL_PASSWORD"]!) {
        let parameters: Parameters = [
            "from": [
                "phoneNumber": dict["RINGCENTRAL_USERNAME"]!
            ],
            "to": [
                [
                    "phoneNumber": dict["RINGCENTRAL_RECEIVER"]!
                ]
            ],
            "text": "Hello world",
        ]
        // send sms
        rc.request("/restapi/v1.0/account/~/extension/~/sms", method: .post, parameters: parameters).responseJSON { response in
            debugPrint(response)
        }
}

RunLoop.main.run()
