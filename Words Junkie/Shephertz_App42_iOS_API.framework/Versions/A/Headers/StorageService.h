//
//  StorageService.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 13/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StorageResponseBuilder.h"
#import "App42Response.h"
#import "App42Service.h"

@class Storage;
@class Query;
@class GeoQuery;
/**
 * Storage service on cloud provides the way to store the JSON document in NoSQL
 * database running on cloud. One can store the JSON document, update it ,
 * serach it and can apply the map-reduce search on stored documents. Example :
 * If one will store JSON doc {"date":"5Feb"} it will be stored with unique
 * Object Id and stored JSON object will loook like { "date" : "5Feb" , "_id" :
 * { "$oid" : "4f423dcce1603b3f0bd560cf"}}. This oid can further be used to
 * access/search the document.
 *
 * @see Storage
 * @see App42Response
 *
 */
@interface StorageService : App42Service
{
    
    
    
}

-(id)init __attribute__((unavailable));
-(id)initWithAPIKey:(NSString *)apiKey  secretKey:(NSString *)secretKey;

/**
 * Save the JSON document in given database name and collection name.
 *
 * @param dbName
 *            - Unique handler for storage name
 * @param collectionName
 *            - Name of collection under which JSON doc has to be saved
 * @param json
 *            - Target JSON document to be saved
 *
 * @return Storage object
 *
 *
 */
-(Storage*)insertJSONDocument:(NSString*)dbName collectionName:(NSString*)collectionName json:(NSString*)json;
/**
 * Find all documents stored in given database and collection.
 *
 * @param dbName
 *            - Unique handler for storage name
 * @param collectionName
 *            - Name of collection under which JSON doc needs to be searched
 *
 * @return Storage object
 *
 *
 */
-(Storage*)findAllDocuments:(NSString*)dbName collectionName:(NSString*)collectionName;
/**
 * Gets the count of all documents stored in given database and collection.
 *
 * @param dbName
 *            - Unique handler for storage name
 * @param collectionName
 *            - Name of collection under which JSON doc needs to be searched
 *
 * @return App42Response object
 *
 *
 */
-(App42Response*)findAllDocumentsCount:(NSString*)dbName collectionName:(NSString*)collectionName;

/**
 * Find all documents stored in given database and collection.
 *
 * @param dbName
 *            - Unique handler for storage name
 * @param collectionName
 *            - Name of collection under which JSON doc needs to be searched
 * @param max
 *            - Maximum number of records to be fetched
 * @param offset
 *            - From where the records are to be fetched
 *
 * @return Storage object
 *
 *
 */
-(Storage*)findAllDocuments:(NSString*)dbName collectionName:(NSString*)collectionName max:(int)max offset:(int)offset;


/**
 * Find all collections stored in given database.
 *
 * @param dbName
 *            - Unique handler for storage name
 *
 * @return Storage object
 *
 * @throws App42Exception
 *
 */

-(Storage*)findAllCollections:(NSString*)dbName;


/**
 * Find target document by given unique object id.
 *
 * @param dbName
 *            - Unique handler for storage name
 * @param collectionName
 *            - Name of collection under which JSON doc needs to be searched
 * @param docId
 *            - Unique Object Id handler
 *
 * @return Storage object
 *
 *
 */
-(Storage*)findDocumentById:(NSString*)dbName collectionName:(NSString*)collectionName docId:(NSString*)docId;
/**
 * Find target document using key value search parameter. This key value
 * pair will be searched in the JSON doc stored on the cloud and matching
 * Doc will be returned as a result of this method.
 *
 * @param dbName
 *            - Unique handler for storage name
 * @param collectionName
 *            - Name of collection under which JSON doc needs to be searched
 * @param key
 *            - Key to be searched for target JSON doc
 * @param value
 *            - Value to be searched for target JSON doc
 *
 * @return Storage object
 *
 *
 */
-(Storage*)findDocumentByKeyValue:(NSString*)dbName collectionName:(NSString*)collectionName key:(NSString*)key value:(NSString*)value;
/**
 * Update target document using key value search parameter. This key value
 * pair will be searched in the JSON doc stored in the cloud and matching
 * Doc will be updated with new value passed.
 *
 * @param dbName
 *            - Unique handler for storage name
 * @param collectionName
 *            - Name of collection under which JSON doc needs to be searched
 * @param key
 *            - Key to be searched for target JSON doc
 * @param value
 *            - Value to be searched for target JSON doc
 * @param newJsonDoc
 *            - New Json document to be added
 *
 * @return Storage object
 *
 *
 */
-(Storage*)updateDocumentByKeyValue:(NSString*)dbName collectionName:(NSString*)collectionName key:(NSString*)key value:(NSString*)value newJsonDoc:(NSString*)newJsonDoc;
/**
 * Update target document using the document id.
 *
 * @param dbName
 *            - Unique handler for storage name
 * @param collectionName
 *            - Name of collection under which JSON doc needs to be searched
 * @param docId
 *            - Id of the document to be searched for target JSON doc
 * @param newJsonDoc
 *            - New Json document to be added
 *
 * @return Storage object
 *
 *
 */
-(Storage*)updateDocumentByDocId:(NSString*)dbName collectionName:(NSString*)collectionName docId:(NSString*)docId newJsonDoc:(NSString*)newJsonDoc;

/**
 * Delete target document using Object Id from given db and collection. The
 * Object Id will be searched in the JSON doc stored on the cloud and
 * matching Doc will be deleted.
 *
 * @param dbName
 *            - Unique handler for storage name
 * @param collectionName
 *            - Name of collection under which JSON doc needs to be searched
 * @param docId
 *            - Unique Object Id handler
 *
 * @return App42Response object if deleted successfully
 *
 *
 */

-(App42Response*)deleteDocumentById:(NSString*)dbName collectionName:(NSString*)collectionName docId:(NSString*)docId;

/**
 * Save the JSON document in given database name and collection name. It
 * accepts the HashMap containing key-value and convert it into JSON.
 * Converted JSON doc further saved on the cloud using given db name and
 * collection name.
 *
 * @param dbName
 *            - Unique handler for storage name
 * @param collectionName
 *            - Name of collection under which JSON doc has to be saved
 * @param map
 *            - HashMap containing key-value pairs
 *
 * @return Storage object
 *
 *
 */
-(Storage*)insertJsonDocUsingMap:(NSString*)dbName collectionName:(NSString*)collectionName map:(NSMutableDictionary*)map;
/**
 * Map reduce function to search the target document. Please see detail
 * information on map-reduce http://en.wikipedia.org/wiki/MapReduce
 *
 * @param dbName
 *            - Unique handler for storage name
 * @param collectionName
 *            - Name of collection under which JSON doc needs to be searched
 * @param mapFunction
 *            - Map function to be used to search the document
 * @param reduceFunction
 *            - Reduce function to be used to search the document
 *
 * @return Returns the target JSON document.
 *
 */
-(NSString*)mapReduce:(NSString*)dbName collectionName:(NSString*)collectionName mapFunction:(NSString*)mapFunction reduceFunction:(NSString*)reduceFunction;


/**
 * Find target document using Custom Query.
 *
 * @param Query
 *            - Query Object containing custom query for searching docs
 * @param dbName
 *            - Unique handler for storage name
 * @param collectionName
 *            - Name of collection under which JSON doc needs to be searched
 * @return Storage object
 *
 * @throws App42Exception
 *
 */

-(Storage*)findDocumentsByQuery:(Query*)query dbName:(NSString*)dbName collectionName:(NSString*)collectionName;

/**
 * Find target document using Custom Query with paging.
 *
 * @param dbName
 *            - Unique handler for storage name
 * @param collectionName
 *            - Name of collection under which JSON doc needs to be searched
 * @param Query
 *            - Query Object containing custom query for searching docs
 * @param max
 *            - Maximum number of records to be fetched
 * @param offset
 *            - From where the records are to be fetched
 *
 * @return Storage object
 *
 * @throws App42Exception
 *
 */
-(Storage*)findDocumentsByQueryWithPaging:(NSString*)dbName collectionName:(NSString*)collectionName query:(Query*)query max:(int)max offset:(int)offset;


/**
 * Find target document using Custom Query with paging and orderby.
 *
 * @param dbName
 *            - Unique handler for storage name
 * @param collectionName
 *            - Name of collection under which JSON doc needs to be searched
 * @param Query
 *            - Query Object containing custom query for searching docs
 * @param max
 *            - max result parameter
 * @param offset
 *            - offset result parameter
 * @param orderByKey
 *            - Name of Key on which order by has to be applied
 * @param type
 *            - ASCENDING/DESCENDING mode
 * @return
 * @throws App42Exception
 */
-(Storage*) findDocsWithQueryPagingOrderBy:(NSString*)dbName
                            collectionName:(NSString*)collectionName
                                     query:(Query*)query
                                       max:(int)max
                                    offset:(int)offset
                                orderByKey:(NSString*)orderByKey
                               orderByType:(NSString*)orderType;

-(Storage*)grantAccessOnDoc:(NSString*)dbName
             collectionName:(NSString*)collectionName
                      docId:(NSString*) docId
                 andAclList:(NSArray*) aclList;

-(Storage*)revokeAccessOnDoc:(NSString*)dbName
              collectionName:(NSString*)collectionName
                       docId:(NSString*) docId
                  andAclList:(NSArray*) aclList;

-(App42Response*) deleteAllDocuments:(NSString*)dbName collectionName:(NSString*) collectionName;
-(Storage*)findDocumentsByLocation:(NSString*)dbName collectionName:(NSString*)collectionName geoQuery:(GeoQuery*)query;
/**
 * Delete target document using key and value from given db and collection.
 * The key value will be searched in the JSON doc stored on the cloud and
 * matching value will be deleted.
 *
 * @param dbName
 *            - Unique handler for storage name
 * @param collectionName
 *            - Name of collection under which JSON doc needs to be searched
 * @param key
 *            - Unique key handler
 * @param value
 *            - Unique value handler
 *
 * @return App42Response object if deleted successfully
 *
 * @throws App42Exception
 *
 */
-(App42Response*)deleteDocumentsByKeyValue:(NSString*)dbName collectionName:(NSString*)collectionName key:(NSString*)key value:(NSString*)value;
@end
