//
//  CategoriesListViewModel.swift
//  Test
//
//  Created by Minh on 21/11/2022.
//

import Foundation
protocol CategoriesListVMDelegate:AnyObject{
    func didReceiveCategoriesDate(cate:CategoriesListModel)
}

final class CategoriesListViewModel{
    //Protocol Delegate
    weak var delegate:CategoriesListVMDelegate?
    //Closures
    var didReceiveDateCategories: ((CategoriesListModel) -> Void)?
    var error:ObserableObject<Error?> = ObserableObject(nil)
    var categoriesListModel:ObserableObject<CategoriesListModel?> = ObserableObject(nil)
    
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
                // self.didReceiveDateCategories?(toDos)
                self.categoriesListModel.value = toDos
                // self.delegate?.didReceiveCategoriesDate(cate: toDos)
            case .failure(let error):
                // A failure, please handle
                self.error.value = error
            }
        }
    }
}
