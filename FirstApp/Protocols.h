//
//  Protocols.h
//  FirstApp
//
//  Created by A-Team User on 3.05.18.
//  Copyright © 2018 A-Team User. All rights reserved.
//

#ifndef Protocols_h
#define Protocols_h

@class ToDoModel;
@class UserModel;

@protocol ToDoListDataDelegate
- (NSArray<ToDoModel *> *) toDosForName:(NSString *) name;
- (void) addToDo:(ToDoModel *)todo forName:(NSString *)name;
- (void) deleteToDoAtIndex:(NSUInteger)index forName:(NSString *)name;
@end

@protocol UsersDataDelegate
- (NSArray<UserModel *> *) allUsers;
- (UserModel *) userAtIndex:(NSUInteger)index;
@end

#endif /* Protocols_h */
