//
//  ToDoListTableViewController.h
//  FirstApp
//
//  Created by A-Team User on 2.05.18.
//  Copyright © 2018 A-Team User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"
@class UserModel;

@interface ToDoListTableViewController : UITableViewController<UISearchBarDelegate>
@property (weak, nonatomic) id<ToDoListDataDelegate> dataDelegate;
@property (strong, nonatomic) UserModel *currentUser;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
- (NSArray<ToDoModel *> *)toDos;

@end
