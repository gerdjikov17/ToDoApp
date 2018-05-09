//
//  ToDoModel.h
//  FirstApp
//
//  Created by A-Team User on 3.05.18.
//  Copyright © 2018 A-Team User. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ToDoModel : NSObject<NSCoding>;
@property (strong, nonatomic) NSDate *timeCreated;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *category;

- (instancetype)initWithText:(NSString *)text andTimeCreated:(NSDate *)timeCreated andCategory:(NSString *)category;
@end
