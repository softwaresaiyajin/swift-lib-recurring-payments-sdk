import Foundation
import Alamofire
import PayseraCommonSDK

public class RecurringPaymentsApiClientFactory {
    public static func createApiClient(
        credentials: PSApiJWTCredentials,
        tokenRefresher: PSTokenRefresherProtocol? = nil,
        logger: PSLoggerProtocol? = nil
    ) -> RecurringPaymentsApiClient {
        let interceptor = PSRequestAdapter(credentials: credentials)
        let trustedSession = PSTrustedSession(
            interceptor: interceptor,
            hosts: ["recurring-payments.paysera.com"]
        )
        
        return RecurringPaymentsApiClient(
            session: trustedSession,
            credentials: credentials,
            tokenRefresher: tokenRefresher,
            logger: logger
        )
    }
}
