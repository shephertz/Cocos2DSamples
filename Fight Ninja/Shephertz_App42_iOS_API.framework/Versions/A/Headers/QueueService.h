//
//  Queue.h
//  App42_iOS_SERVICE_APIs
//
//  Created by shephertz technologies on 11/02/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueueResponseBuilder.h"
#import "App42Service.h"

@class Queue;
@class App42Response;
/**
 * Manages Asynchronous queues. Allows to create, delete, purge messages, view
 * pending messages and get all messages
 *
 * @see Queue
 *
 */
@interface QueueService : App42Service
{
}

-(id)init __attribute__((unavailable));
-(id)initWithAPIKey:(NSString *)apiKey  secretKey:(NSString *)secretKey;

/**
 * Creates a type Pull Queue
 *
 * @param queueName
 *            - The name of the queue which has to be created
 * @param queueDescription
 *            - The description of the queue
 *
 * @return Queue object containing queue name which has been created
 *
 */
-(Queue*)createPullQueue:(NSString*)queueName description:(NSString*)queueDescription;
/**
 * Deletes the Pull type Queue
 *
 * @param queueName
 *            - The name of the queue which has to be deleted
 *
 * @return App42Response if deleted successfully
 *
 */
-(App42Response*)deletePullQueue:(NSString*)queueName;
/**
 * Purges message on the Queue. Note: once the Queue is purged the messages
 * are removed from the Queue and wont be available for dequeuing.
 *
 * @param queueName
 *            - The name of the queue which has to be purged
 *
 * @return App42Response object containing queue name which has been purged
 *
 */
-(App42Response*)purgePullQueue:(NSString*)queueName;
/**
 * Messages which are pending to be dequeue. Note: Calling this method does
 * not dequeue the messages in the Queue. The messages stay in the Queue
 * till they are dequeued
 *
 * @param queueName
 *            - The name of the queue from which pending messages have to be
 *            fetched
 *
 * @return Queue object containing pending messages in the Queue
 *
 */
-(Queue*)pendingMessages:(NSString*)queueName;

/**
 * Messages are retrieved and dequeued from the Queue.
 *
 * @param queueName
 *            - The name of the queue which have to be retrieved
 * @param receiveTimeOut
 *            - Receive time out
 *
 * @return Queue object containing messages in the Queue
 *
 */

-(Queue*)getMessages:(NSString*)queueName receiveTimeOut:(long)receiveTimeOut;

/**
 * Send message on the queue with an expiry. The message will expire if it
 * is not pulled/dequeued before the expiry
 *
 * @param queueName
 *            - The name of the queue to which the message has to be sent
 * @param msg
 *            - Message that has to be sent
 * @param exp
 *            - Message expiry time
 *
 * @return Queue object containing message which has been sent with its
 *         message id and correlation id
 *
 */
-(Queue*)sendMessage:(NSString*)queueName message:(NSString*)msg expiryTime:(long)exp;
/**
 * Pulls all the message from the queue
 *
 * @param queueName
 *            - The name of the queue from which messages have to be pulled
 * @param receiveTimeOut
 *            - Receive time out
 *
 * @return Queue object containing messages which have been pulled
 *
 */
-(Queue*)receiveMessage:(NSString*)queueName receiveTimeOut:(long)receiveTimeOut;
/**
 * Pull message based on the correlation id
 *
 * @param queueName
 *            - The name of the queue from which the message has to be
 *            pulled
 * @param receiveTimeOut
 *            - Receive time out
 * @param correlationId
 *            - Correlation Id for which message has to be pulled
 *
 * @return Queue containing message which has pulled based on the
 *         correlation id
 *
 */
-(Queue*)receiveMessageByCorrelationId:(NSString*)queueName receiveTimeOut:(long)receiveTimeOut correlationId:(NSString*)correlationId;
/**
 * Remove message from the queue based on the message id. Note: Once the
 * message is removed it cannot be pulled
 *
 * @param queueName
 *            - The name of the queue from which the message has to be
 *            removed
 * @param messageId
 *            - The message id of the message which has to be removed.
 *
 * @return App42Response if removed successfully
 *
 */
-(App42Response*)removeMessage:(NSString*)queueName messageId:(NSString*)messageId;



@end
