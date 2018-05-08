//
//  UserModel.h
//  FirstApp
//
//  Created by A-Team User on 4.05.18.
//  Copyright © 2018 A-Team User. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    EnumGenderMale,
    EnumGenderFemale
} EnumGender;

@interface UserModel : NSObject<NSCoding>;

- (instancetype)initWithUsername:(NSString *)username andPassword:(NSString *)password;
@property (readonly, strong) NSString *userName;
@property (readonly, strong) NSString *password;
- (EnumGender) gender;

@end
