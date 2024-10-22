//
//  PaginatedResultMapper.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

final class PaginatedResultMapper<T: Codable, S> {
    
    private let resultsMapFunction: ([T]) throws -> ([S])
    
    init (_ resultsMapFunction: @escaping (([T]) throws -> ([S]))) {
        self.resultsMapFunction = resultsMapFunction
    }
    
    func transform(_ dataModel: PaginatedResultDTO<T>) throws -> PaginatedResult<S> {
        PaginatedResult(paginationInfo: try PaginationInfoMapper.transform(dataModel.info),
                        results: try resultsMapFunction(dataModel.results))
    }
}

final class PaginationInfoMapper: BaseMapper<PaginationInfoDTO, PaginationInfo> {
    
    override class func transform(_ dataModel: PaginationInfoDTO) throws -> PaginationInfo {
        PaginationInfo(count: dataModel.count,
                       pages: dataModel.pages,
                       nextUrl: dataModel.nextUrl,
                       prevUrl: dataModel.prevUrl)
    }
    
}
