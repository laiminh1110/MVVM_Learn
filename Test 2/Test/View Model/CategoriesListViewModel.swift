//
//  CategoriesListViewModel.swift
//  Test
//
//  Created by Minh on 21/11/2022.
//

import Foundation


final class CategoriesListViewModel{
    var error:ObserableObject<Error?> = ObserableObject(nil)
    var categoriesList:ObserableObject<CategoriesListModel?> = ObserableObject(nil)
    
    func getListCategories(token:String)  {
        
        let headers:HTTPHeaders  = [
            "Content-Type":"application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        URLSessionRequest.shared.fetchData("http://streaming.nexlesoft.com:4000/api/categories?pageSize=100&pageNumber=0",
                                           method: .get,
                                           headers: headers,
                                           body: nil) { (result: Result<CategoriesListModel, Error>) in
            switch result {
            case .success(let toDos):
                // A list of categories!
                self.categoriesList.value = toDos
            case .failure(let error):
                // A failure, please handle
                self.error.value = error
            }
        }
    }
}
