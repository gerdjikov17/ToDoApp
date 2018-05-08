//
//  UserModel.m
//  FirstApp
//
//  Created by A-Team User on 4.05.18.
//  Copyright © 2018 A-Team User. All rights reserved.
//

#import "UserModel.h"

@interface UserModel ()
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *password;
@end


@implementation UserModel

- (instancetype)initWithUsername:(NSString *)username andPassword:(NSString *)password
{
    self = [super init];
    if (self) {
        self.userName = username;
        self.password = password;
    }
    return self;
}

- (EnumGender) gender {
    EnumGender result = EnumGenderMale;
    if ([self.userName hasSuffix:@"le"] || [self.userName hasSuffix:@"a"]) {
        result = EnumGenderFemale;
    }
    return result;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.userName forKey:@"username"];
    [encoder encodeObject:self.password forKey:@"password"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.userName = [decoder decodeObjectForKey:@"username"];
        self.password = [decoder decodeObjectForKey:@"password"];
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    UserModel *newObj = (UserModel *) object;
    if (newObj.userName != self.userName) return NO;
    if (newObj.password != self.password) return NO;
    return YES;
}

@end
