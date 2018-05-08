//
//  UsersTableViewController.h
//  FirstApp
//
//  Created by A-Team User on 4.05.18.
//  Copyright © 2018 A-Team User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"

@interface UsersTableViewController : UITableViewController

@property (weak, nonatomic) id<UsersDataDelegate> usersDataDelegate;
@property (strong, nonatomic) NSArray<NSString *> *users;
@property (weak, nonatomic) id<ToDoListDataDelegate> toDoListDataDelegate;

- (instancetype)initWithAnchorView:(UIView *)anchorView andDelegate:(id<UIPopoverPresentationControllerDelegate>)popOverDelegate;

@end
