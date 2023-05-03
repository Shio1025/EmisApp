# ``NetworkLayer``

For Service Calls

## Overview

Example of Using NetworkManager ->
let endPoint = EndPoint<Some Custom Decodable Model>(url: url,
                                                    method: method)

networkService.makeRequest(endPoint)
    .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
            //error
        case .finished:
            //success
        }
    }, receiveValue: { response in
        //do something 
    })
    .store(in: &cancellables)

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
