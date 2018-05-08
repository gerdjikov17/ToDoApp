//
//  UsersDataSerializer.m
//  FirstApp
//
//  Created by A-Team User on 4.05.18.
//  Copyright © 2018 A-Team User. All rights reserved.
//

#import "UsersDataSerializer.h"

@implementation UsersDataSerializer

+ (void) saveUsersInUserDefaults:(NSArray<UserModel *> *) users {
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:users];
    [[NSUserDefaults standardUserDefaults] setObject:encodedData forKey:@"users"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
+ (NSArray<UserModel *> *) usersFromUserDefaults {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"users"];
    NSArray<UserModel *> *users = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return users;
}

@end
