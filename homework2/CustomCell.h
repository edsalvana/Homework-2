//
//  CustomCell.h
//  homework2
//
//  Created by Ed Salvana on 2/23/14.
//  Copyright (c) 2014 Ed Salvana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (nonatomic, weak) IBOutlet UILabel *notificationLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *notificationIcon;

@end
