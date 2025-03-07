//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
@testable import AppSyncRealTimeClient
import Starscream

class StarscreamAdapterTests: AppSyncRealTimeClientTestBase {

    func testConnectDisconnect() throws {
        let starscreamAdapter = StarscreamAdapter()
        let apiKeyAuthInterceptor = APIKeyAuthInterceptor(apiKey)
        let request = AppSyncConnectionRequest(url: url)
        let signedRequest = apiKeyAuthInterceptor.interceptConnection(request, for: url)
        let expectedPerforms = expectation(description: "total performs")
        expectedPerforms.expectedFulfillmentCount = 1_000
        DispatchQueue.concurrentPerform(iterations: 1_000) { _ in
            starscreamAdapter.connect(
                url: signedRequest.url,
                protocols: ["graphql-ws"],
                delegate: nil
            )
            starscreamAdapter.disconnect()
            expectedPerforms.fulfill()
        }
        wait(for: [expectedPerforms], timeout: 1)
        XCTAssertFalse(starscreamAdapter.isConnected)
    }
}
