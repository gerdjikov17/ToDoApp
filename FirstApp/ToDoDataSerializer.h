//
//  ToDoSerializer.h
//  FirstApp
//
//  Created by A-Team User on 3.05.18.
//  Copyright © 2018 A-Team User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"

@interface ToDoDataSerializer : NSObject;

+ (void) saveAllToDos:(NSMutableDictionary<NSString *,NSMutableArray<ToDoModel*> *> *) toDosDict;
+ (NSMutableDictionary<NSString *,NSMutableArray<ToDoModel*> *> *) toDoDictFromUserDefaults;

@end
