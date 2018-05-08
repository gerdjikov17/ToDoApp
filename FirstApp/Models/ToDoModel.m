//
//  ToDoModel.m
//  FirstApp
//
//  Created by A-Team User on 3.05.18.
//  Copyright © 2018 A-Team User. All rights reserved.
//

#import "ToDoModel.h"

@implementation ToDoModel

- (instancetype)initWithText:(NSString *)text andTimeCreated:(NSDate *)timeCreated {
    self = [super init];
    if (self) {
        self.text = text;
        self.timeCreated = timeCreated;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.text forKey:@"text"];
    [encoder encodeObject:self.timeCreated forKey:@"timeCreated"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        //decode properties, other class vars
        self.text = [decoder decodeObjectForKey:@"text"];
        self.timeCreated = [decoder decodeObjectForKey:@"timeCreated"];
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%@, %@", self.text, self.timeCreated];
}


@end
