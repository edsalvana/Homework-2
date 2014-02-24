//
//  NotificationModel.m
//  homework2
//
//  Created by Ed Salvana on 2/23/14.
//  Copyright (c) 2014 Ed Salvana. All rights reserved.
//

#import "NotificationModel.h"

@implementation NotificationModel

-(id)initWithDictionary:(NSDictionary *)dictionary {
    
    self.profileImageURL = dictionary[@"profileImageURL"];
    self.notificationMessage = dictionary[@"notificationMessage"];
    self.notificationTime = dictionary[@"notificationTime"];
    self.notificationIconURL = dictionary[@"notificationIconURL"];
    return self;
    
}


+ (NSMutableArray *)notificationDetails {
    
    const int numberOfNotifications = 30;
    
    //create a list of notifications
    NSMutableArray *notifications = [[NSMutableArray alloc] init];
    
    NSDictionary *notificationData;
    NotificationModel *notification;
    
    //create some things to populate notifications
    NSArray *profileImages  = [NSArray arrayWithObjects:
                                @"profileImage2.png",
                                @"profileImage3.png",
                                @"profileImage4.png",
                                @"profileImage5.png",
                                nil
                              ];
                              
    NSArray *messages      = [NSArray arrayWithObjects:
                                @"<b>Josh Damon Williams</b> likes your <b>photo</b>.",
                                @"<b>Tony Paves</b>, <b>Holly Hagen</b> and 2 other commented on your <b>status</b>.",
                                @"<b>Hannah Fletcher</b>, <b>vika</b> and 20 other people like your <b>photo</b>.",
                                @"<b>Timothy Lee</b> posted in iOS Bootcamp for Designers: \"Here's a quick video on setting up XCode to run...\"",
                                nil
                              ];
    NSArray *time      = [NSArray arrayWithObjects:
                                @"<small>Just now</small>",
                                @"<small>A few minutes ago</small>",
                                @"<small>3 minutes ago</small>",
                                @"<small>12 minutes ago</small>",
                                @"<small>30 minutes ago</small>",
                                @"<small>1 hour ago</small>",
                                @"<small>6 hours ago</small>",
                                @"<small>7 hours ago</small>",
                                nil
                              ];
    NSArray *icons      = [NSArray arrayWithObjects:
                                @"icon-group-sunglasses-16px.png",
                                @"icon-like-16px.png",
                                @"icon-comment-16px@2x.png",
                                nil
                              ];
    
    //create random notifications
    for( int i = 0; i < numberOfNotifications; i++){
        notificationData = @{@"profileImageURL"     : [profileImages objectAtIndex: arc4random() % [profileImages count] ],
                             @"notificationMessage" : [messages objectAtIndex:      arc4random() % [messages count] ],
                             @"notificationTime"    : [time objectAtIndex:          arc4random() % [time count] ],
                             @"notificationIconURL" : [icons objectAtIndex:         arc4random() % [icons count] ]
                             };
        
        notification = [[NotificationModel alloc] initWithDictionary:notificationData ];
        [ notifications addObject:notification ];
    }
    
    //retrun the notification
    return notifications;
    
    

    
}



@end
