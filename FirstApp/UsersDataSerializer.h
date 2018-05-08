//
//  UsersDataSerializer.h
//  FirstApp
//
//  Created by A-Team User on 4.05.18.
//  Copyright © 2018 A-Team User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"

@class UserModel;

@interface UsersDataSerializer : NSObject
+ (void) saveUsersInUserDefaults:(NSArray<UserModel *> *) users;
+ (NSArray<UserModel *> *) usersFromUserDefaults;
@end
