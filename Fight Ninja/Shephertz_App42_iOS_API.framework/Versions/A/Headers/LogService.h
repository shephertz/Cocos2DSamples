//
//  LogService.h
//  App42_iOS_SERVICE_APIs
//
//  Created by shephertz technologies on 13/02/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogResponseBuilder.h"
#import "App42Service.h"
/**
 * Centralize logging for your App. This service allows different levels e.g.
 * info, debug, fatal, error etc. to log a message and query the messages based
 * on different parameters. You can fetch logs based on module, level, message,
 * date range etc.
 *
 * @see Log
 *
 */
@interface LogService : App42Service
{
    
}

-(id)init __attribute__((unavailable));
-(id)initWithAPIKey:(NSString *)apiKey  secretKey:(NSString *)secretKey;

/**
 * Logs the info message
 *
 * @param msg
 *            - Message to be logged
 * @param module
 *            - Module name for which the message is getting logged
 *
 * @return Log object containing logged message
 *
 *
 */
-(Log*)info:(NSString *)msg module:(NSString*)module;
/**
 * Logs the debug message
 *
 * @param msg
 *            - Message to be logged
 * @param module
 *            - Module name for which the message is getting logged
 *
 * @return Log object containing logged message.
 *
 */
-(Log*)debug:(NSString *)msg module:(NSString*)module;
/**
 * Logs the fatal message
 *
 * @param msg
 *            - Message to be logged
 * @param module
 *            - Module name for which the message is getting logged
 *
 * @return Log object containing logged message.
 *
 */
-(Log*)fatal:(NSString *)msg module:(NSString*)module;
/**
 * Logs the error message
 *
 * @param msg
 *            - Message to be logged
 * @param module
 *            - Module name for which the message is getting logged
 *
 * @return Log object containing logged message
 *
 */
-(Log*)error:(NSString *)msg module:(NSString*)module;
/**
 * Fetch the count of log messages based on the Module
 *
 * @param moduleName
 *            - Module name for which the count of messages has to be
 *            fetched
 *
 * @return App42Response object containing count of fetched messages.
 *
 */
-(App42Response*)fetchLogsCountByModule:(NSString*)moduleName;
/**
 * Fetch the log messages based on the Module
 *
 * @param moduleName
 *            - Module name for which the messages has to be fetched
 *
 * @return Log object containing fetched messages.
 *
 */
-(Log*)fetchLogsByModule:(NSString*)moduleName;
/**
 * Fetch the log messages based on the Module by paging.
 *
 * @param moduleName
 *            - Module name for which the messages has to be fetched
 * @param max
 *            - Maximum number of records to be fetched
 * @param offset
 *            - From where the records are to be fetched
 *
 * @return Log object containing fetched messages.
 *
 */
-(Log*)fetchLogsByModule:(NSString*)moduleName max:(int)max offset:(int)offset;
/**
 * Fetch count of log messages based on the Module and Message Text
 *
 * @param moduleName
 *            - Module name for which the count of messages has to be
 *            fetched
 * @param text
 *            - The log message on which count of logs have to be searched
 *
 * @return App42Response object containing count of fetched messages.
 *
 */
-(App42Response*)fetchLogsCountByModuleAndText:(NSString*)moduleName text:(NSString*)text;
/**
 * Fetch log messages based on the Module and Message Text
 *
 * @param moduleName
 *            - Module name for which the messages has to be fetched
 * @param text
 *            - The log message on which logs have to be searched
 *
 * @return Log object containing fetched messages.
 *
 */
-(Log*)fetchLogsByModuleAndText:(NSString*)moduleName text:(NSString*)text;
/**
 * Fetch log messages based on the Module and Message Text by paging.
 *
 * @param moduleName
 *            - Module name for which the messages has to be fetched
 * @param text
 *            - The log message on which logs have to be searched
 *
 * @param max
 *            - Maximum number of records to be fetched
 * @param offset
 *            - From where the records are to be fetched
 *
 * @return Log object containing fetched messages.
 *
 */
-(Log*)fetchLogsByModuleAndText:(NSString*)moduleName text:(NSString*)text max:(int)max offset:(int)offset;
/**
 * Fetch count of log messages based on Info Level
 *
 * @return App42Response object containing count of fetched info messages.
 *
 */
-(App42Response*)fetchLogsCountByInfo;
/**
 * Fetch count of log messages based on Debug Level
 *
 * @return App42Response object containing count of fetched debug messages.
 *
 */
-(App42Response*)fetchLogsCountByDebug;
/**
 * Fetch count of log messages based on Error Level
 *
 * @return App42Response object containing count of fetched error messages.
 *
 */
-(App42Response*)fetchLogsCountByError;
/**
 * Fetch count of log messages based on Fatal Level
 *
 * @return App42Response object containing count of fetched Fatal messages.
 *
 */
-(App42Response*)fetchLogsCountByFatal;

/**
 * Fetch log messages based on Info Level
 *
 * @return Log object containing fetched info messages.
 *
 */
-(Log*)fetchLogsByInfo;
/**
 * Fetch log messages based on Debug Level
 *
 * @return Log object containing fetched debug messages
 *
 */
-(Log*)fetchLogsByDebug;
/**
 * Fetch log messages based on Error Level
 *
 * @return Log object containing fetched error messages
 *
 */
-(Log*)fetchLogsByError;
/**
 * Fetch log messages based on Fatal Level
 *
 * @return Log object containing fetched Fatal messages
 *
 */
-(Log*)fetchLogsByFatal;
/**
 * Fetch log messages based on Info Level by paging.
 *
 * @param max
 *            - Maximum number of records to be fetched
 * @param offset
 *            - From where the records are to be fetched
 *
 * @return Log object containing fetched info messages.
 * 
 */
-(Log*)fetchLogsByInfo:(int)max offset:(int)offset;
/**
 * Fetch log messages based on Debug Level by paging.
 *
 * @param max
 *            - Maximum number of records to be fetched
 * @param offset
 *            - From where the records are to be fetched
 *
 * @return Log object containing fetched debug messages.
 *
 */
-(Log*)fetchLogsByDebug:(int)max offset:(int)offset;
/**
 * Fetch log messages based on Error Level by paging.
 *
 * @param max
 *            - Maximum number of records to be fetched
 * @param offset
 *            - From where the records are to be fetched
 *
 * @return Log object containing fetched error messages.
 *
 */
-(Log*)fetchLogsByError:(int)max offset:(int)offset;
/**
 * Fetch log messages based on Fatal Level by paging.
 *
 * @param max
 *            - Maximum number of records to be fetched
 * @param offset
 *            - From where the records are to be fetched
 *
 * @return Log object containing fetched Fatal messages.
 *
 */
-(Log*)fetchLogsByFatal:(int)max offset:(int)offset;
/**
 * Fetch count of log messages based on Date range
 * 
 * @param startDate
 *            Start date from which the count of log messages have to be fetched
 * @param endDate
 *            End date upto which the count of log messages have to be fetched
 * @return App42Response object containing count of fetched messages.
 */
-(App42Response*)fetchLogCountByDateRange:(NSDate*)startDate endDate:(NSDate*)endDate;
/**
 * Fetch count of log messages based on Date range
 *
 * @param startDate
 *            - Start date from which the count of log messages have to be
 *            fetched
 * @param endDate
 *            - End date upto which the count of log messages have to be
 *            fetched
 *
 * @return App42Response object containing count of fetched messages.
 *
 */
-(Log*)fetchLogByDateRange:(NSDate*)startDate endDate:(NSDate*)endDate;
/**
 * Fetch log messages based on Date range by paging.
 *
 * @param startDate
 *            - Start date from which the log messages have to be fetched
 * @param endDate
 *            - End date upto which the log messages have to be fetched
 *
 * @param max
 *            - Maximum number of records to be fetched
 * @param offset
 *            - From where the records are to be fetched
 *
 * @return Log object containing fetched messages
 *
 */
-(Log*)fetchLogByDateRange:(NSDate*)startDate endDate:(NSDate*)endDate max:(int)max offset:(int)offset;


/**
 * Log event on App42 cloud for analytics purpose
 * @param eventName
 */
-(void)setEventWithName:(NSString*)eventName forModule:(NSString*)moduleName;
/**
* Log event on App42 cloud for analytics purpose
* @param eventName
*/
-(void)setEventWithName:(NSString*)eventName;

@end
