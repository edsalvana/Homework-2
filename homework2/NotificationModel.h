//
//  NotificationModel.h
//  homework2
//
//  Created by Ed Salvana on 2/23/14.
//  Copyright (c) 2014 Ed Salvana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationModel : NSObject
@property (nonatomic, strong) NSString *profileImageURL;
@property (nonatomic, strong) NSString *notificationMessage;
@property (nonatomic, assign) NSString *notificationTime;
@property (nonatomic, assign) NSString *notificationIconURL;

-(id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)notificationDetails;

@end
