//
//  SignUpViewModel.swift
//  Test
//
//  Created by Minh on 29/11/2022.
//

import Foundation

final class SignUpViewModel{
    var error:ObserableObject<String?> = ObserableObject(nil)
    var signUpModel:ObserableObject<SignUpModel?> = ObserableObject(nil)
    func signUp(email:String, password:String){
        let body: [String: Any] = [
            "firstName":"Trung",
            "lastName":"Huynh",
            "email": email,
            "password":password
        ]
        
        let headers:HTTPHeaders  = [
            "Content-Type":"application/json",
        ]
                
        URLSessionRequest.shared.fetchData("http://streaming.nexlesoft.com:4000/api/auth/signup", method: .post, headers: headers, body: body) { (result: Result<SignUpModel, Error>) in
            switch result {
            case .success(let toDos):
                print(toDos)
                // A list of todos!
                self.signUpModel.value = toDos
            case .failure(_):
                // A failure, please handle
                self.error.value = "failllllll"
            }
        }
    }
}
