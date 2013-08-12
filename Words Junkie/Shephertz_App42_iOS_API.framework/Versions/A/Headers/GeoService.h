//
//  GeoService.h
//  App42_iOS_SERVICE_APIs
//
//  Created by shephertz technologies on 17/02/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeoResponseBuilder.h"
#import "App42Service.h"

@class Geo;
/**
 *
 * Geo Spatial Service on cloud provides the storage, retrieval, querying and
 * updation of geo data. One can store the geo data by unique handler on the
 * cloud and can apply search, update and query on it. Geo spatial query
 * includes finding nearby/In circle target point from given point using geo
 * points stored on the cloud.
 *
 * @see Geo
 */
@interface GeoService : App42Service
{
    
}

-(id)init __attribute__((unavailable));
-(id)initWithAPIKey:(NSString *)apiKey  secretKey:(NSString *)secretKey;
/**
 * Stores the geopints with unique handler on the cloud. Geo point data
 * contains lat, long and marker of the point.
 *
 * @param geoStorageName
 *            - Unique handler for storage name
 * @param geoPointsList
 *            - List of Geo Points to be saved
 *
 * @return Geo object containing List of Geo Points that have been saved
 *
 */
-(Geo*)createGeoPoints:(NSString*)geoStorageName geoPointsList:(NSArray*)geoPointsList;
/**
 * Search the near by point in given range(In KM) from specified source
 * point. Points to be searched should already be stored on cloud using
 * unique storage name handler.
 *
 * @param storageName
 *            - Unique handler for storage name
 * @param lat
 *            - Latitude of source point
 * @param lng
 *            - Longitude of source point
 * @param distanceInKM
 *            - Range in KM
 *
 * @return Geo object containing the target points in ascending order of
 *         distance from source point.
 *
 *
 */
-(Geo*)getNearByPointsByMaxDistance:(NSString*)storageName latitude:(double)lat longitude:(double)lng distanceInKM:(double)distanceInKM;
/**
 * Search the near by point from specified source point. Points to be
 * searched should already be stored on cloud using unique storage name
 * handler.
 *
 * @param storageName
 *            - Unique handler for storage name
 * @param lat
 *            - Latitude of source point
 * @param lng
 *            - Longitude of source point
 * @param resultLimit
 *            - Maximum number of results to be retrieved
 *
 * @return Geo object containing the target points in ascending order of
 *         distance from source point.
 *
 */
-(Geo*)getNearByPoint:(NSString*)storageName latitude:(double)lat longitude:(double)lng resultLimit:(int)resultLimit;
/**
 * Search the near by point from specified source point with in specified
 * radius. Points to be searched should already be stored on cloud using
 * unique storage name handler.
 *
 * @param storageName
 *            - Unique handler for storage name
 * @param lat
 *            - Lattitude of source point
 * @param lng
 *            - Longitude of source point
 * @param radiusInKM
 *            - Radius in KM
 * @param resultLimit
 *            - Maximum number of results to be retrieved
 *
 * @return Geo object containing the target points in ascending order of
 *         distance from source point.
 *
 */
-(Geo*)getPointsWithInCircle:(NSString*)storageName latitude:(double)lat longitude:(double)lng radiusInKM:(double)radiusInKM resultLimit:(int)resultLimit;
/**
 * Fetch the name of all storage stored on the cloud.
 *
 * @return Geo object containing List of all the storage created
 *
 */
-(NSArray*)getAllStorage;
/**
 * Delete the specified Geo Storage from Cloud.
 *
 * @param storageName
 *            - Unique handler for storage name
 *
 * @return App42Response object containing the name of the storage that has
 *         been deleted.
 *
 */
-(App42Response*)deleteStorage:(NSString*)storageName;
/**
 * Get All Point from storage.
 *
 * @param storageName
 *            - Unique handler for storage name
 *
 * @return Geo object containing all the stored Geo Points for the specified
 *         storage
 *
 */
-(Geo*)getAllPoints:(NSString*)storageName;

@end
