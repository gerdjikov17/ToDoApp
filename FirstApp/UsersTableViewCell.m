//
//  UsersTableViewCell.m
//  FirstApp
//
//  Created by A-Team User on 4.05.18.
//  Copyright © 2018 A-Team User. All rights reserved.
//

#import "UsersTableViewCell.h"

@implementation UsersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userImage.layer.cornerRadius = self.userImage.frame.size.height/2;
    self.userImage.layer.masksToBounds = YES;
    self.userImage.clipsToBounds = YES;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
