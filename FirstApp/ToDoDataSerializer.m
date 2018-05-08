//
//  ToDoSerializer.m
//  FirstApp
//
//  Created by A-Team User on 3.05.18.
//  Copyright © 2018 A-Team User. All rights reserved.
//

#import "ToDoDataSerializer.h"

@implementation ToDoDataSerializer


+ (NSMutableDictionary<NSString *,NSMutableArray<ToDoModel*> *> *) toDoDictFromUserDefaults{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"data"];
    NSMutableDictionary<NSString *,NSMutableArray<ToDoModel*> *> *toDosDict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return toDosDict;
}

+ (void) saveAllToDos:(NSMutableDictionary<NSString *,NSMutableArray<ToDoModel*> *> *) toDosDict{
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:toDosDict];
    [[NSUserDefaults standardUserDefaults] setObject:encodedData forKey:@"data"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
