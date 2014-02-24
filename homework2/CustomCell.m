//
//  CustomCell.m
//  homework2
//
//  Created by Ed Salvana on 2/23/14.
//  Copyright (c) 2014 Ed Salvana. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    //self.frame = CGRectMake(0,0, 320, 80);
 
    //self.notificationLabel.text = @"adfasdf";
    // Configure the view for the selected state
}

@end
