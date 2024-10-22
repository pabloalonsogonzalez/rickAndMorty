//
//  LocationMapper.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

final class LocationMapper: BaseMapper<LocationDTO, Location> {
    
    override class func transform(_ dataModel: LocationDTO) throws -> Location {
        Location(id: dataModel.id,
                 name: dataModel.name,
                 type: dataModel.type,
                 dimension: dataModel.dimension,
                 residentsUrls: dataModel.residentsUrls,
                 url: dataModel.url,
                 created: try dataModel.created.toDate())
    }
    
}
