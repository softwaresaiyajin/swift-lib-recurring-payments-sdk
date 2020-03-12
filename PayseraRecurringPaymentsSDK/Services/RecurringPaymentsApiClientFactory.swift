import Foundation
import Alamofire
import PayseraCommonSDK

public class RecurringPaymentsApiClientFactory {
    public static func createApiClient(
        credentials: PSApiJWTCredentials,
        tokenRefresher: PSTokenRefresherProtocol? = nil,
        logger: PSLoggerProtocol? = nil
    ) -> RecurringPaymentsApiClient {
        let session = Session(interceptor: PSRequestAdapter(credentials: credentials))
        
        return RecurringPaymentsApiClient(
            session: session,
            credentials: credentials,
            tokenRefresher: tokenRefresher,
            logger: logger
        )
    }
}
