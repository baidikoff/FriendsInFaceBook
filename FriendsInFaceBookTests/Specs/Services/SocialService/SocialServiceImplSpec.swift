//
//  SocialServiceImplSpec.swift
//  FriendsInFaceBookTests
//
//  Created by Viktoria on 1/30/18.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Quick
import Nimble

@testable import FriendsInFaceBook

class SocialServiceImplMock: SocialService {
    // MARK: -
    // MARK: Properties
    
    var isAlreadyLoggedIn: Bool = true
    
    // MARK: -
    // MARK: Public
    
    let requestUsersSpy = CallSpy<User, Void>()
    
    func requestUsers(_ completion: @escaping ([User]) -> ()) -> ServiceTask {
        let users = [User(name: "Ivan", image: UserImageData(urlData: UserImage(url: "https://pp.userapi.com/c302715/v302715160/6a5c/MY7blQcR-bc.jpg")))]
        self.requestUsersSpy.call(users[0])
        completion(users)
        return ServiceTask(request: FacebookApi())
    }
}

class SocialServiceImplSpec: QuickSpec {
    override func spec() {
        let mockRequest = SocialServiceImplMock()
        
        describe("CancellableProperty") {
            it("it should not cancel when set") {
                expect(mockRequest.requestUsersSpy.callCount).to(notBeCalled())
            }
            
            it("it should not cancel when set") {
                let users = [User(name: "Ivan", image: UserImageData(urlData: UserImage(url: "https://pp.userapi.com/c302715/v302715160/6a5c/MY7blQcR-bc.jpg")))]
                mockRequest.requestUsers { _ in
                    expect(mockRequest.requestUsersSpy.arguments[0]).to(beCalled(argument: users[0]))
                }
            }   
        }
    }
}


