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
    
    let requestUsersSpy = CallSpy<[User], Void>()
    
    func requestUsers(_ completion: @escaping ([User]) -> ()) -> Cancellable {
        let users = [User(name: "Ivan", image: UserImageData(urlData: UserImage(url: "https://pp.userapi.com/c302715/v302715160/6a5c/MY7blQcR-bc.jpg")))]
        self.requestUsersSpy.call(users)
        completion(users)
        return ServiceTask(FacebookApi())
    }
}

class SocialServiceImplSpec: QuickSpec {
    var users: [User] = []
    override func spec() {
        let mockRequest = SocialServiceImplMock()
        let request = SocialServiceImpl(FacebookApi())
       
        describe("CancellableProperty") {
            it("it should not cancel when set") {
                request.cancellable = mockRequest.requestUsers { users in
                    self.users = users
                    print(mockRequest.requestUsersSpy)
                    expect(mockRequest.requestUsersSpy).to(beCalled(with: self.users))
                }
            }   
        }
    }
}


