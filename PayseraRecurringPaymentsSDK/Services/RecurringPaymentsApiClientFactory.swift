import Foundation
import Alamofire
import PayseraCommonSDK

public class RecurringPaymentsApiClientFactory {
    public static func createApiClient(
        credentials: PSApiJWTCredentials,
        tokenRefresher: PSTokenRefresherProtocol? = nil,
        logger: PSLoggerProtocol? = nil
    ) -> RecurringPaymentsApiClient {
        let sessionManager = SessionManager()
        sessionManager.adapter = PSRequestAdapter(credentials: credentials)
        
        return RecurringPaymentsApiClient(
            sessionManager: sessionManager,
            credentials: credentials,
            tokenRefresher: tokenRefresher,
            logger: logger
        )
    }
}
