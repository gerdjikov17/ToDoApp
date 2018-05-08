//
//  UsersTableViewController.m
//  FirstApp
//
//  Created by A-Team User on 4.05.18.
//  Copyright © 2018 A-Team User. All rights reserved.
//

#import "UsersTableViewController.h"
#import "UsersTableViewCell.h"
#import "UserModel.h"
#import "ToDoListTableViewController.h"
@class ViewController;

@interface UsersTableViewController ()


@end

@implementation UsersTableViewController

- (instancetype)initWithAnchorView:(UIView *)anchorView andDelegate:(id<UIPopoverPresentationControllerDelegate>)popOverDelegate
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popoverPresentationController.sourceView = anchorView;
        self.popoverPresentationController.sourceRect = anchorView.bounds;
        self.popoverPresentationController.delegate = popOverDelegate;
        
        self.preferredContentSize = CGSizeMake(100.0f, 100.0f);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.usersDataDelegate.allUsers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UsersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user_cell" forIndexPath:indexPath];
    UserModel *user = [self.usersDataDelegate userAtIndex:indexPath.row];
    cell.userName.text = user.userName;
    UIImage *userImage;
    if (user.gender == EnumGenderMale) {
        userImage = [UIImage imageNamed:@"bratzo.png"];
    }
    else {
        userImage = [UIImage imageNamed:@"melania.png"];
    }
    cell.userImage.image = userImage;
    return cell;
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserModel *currentUser = [self.usersDataDelegate userAtIndex:indexPath.row];
    [self showAlertViewForPassword:currentUser];
}

- (void) showAlertViewForPassword:(UserModel *)currentUser {
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:currentUser.userName
                               message:@"Password"
                               preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Password";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    NSArray *textFields = alert.textFields;
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Login" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                         {
                             UITextField *passwordTextField = textFields[0];
                             if ([passwordTextField.text isEqualToString:currentUser.password]) {
                                 ToDoListTableViewController *toDoListViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"IdentifierToDoListController"];
                                 toDoListViewController.dataDelegate = self.toDoListDataDelegate;
                                 toDoListViewController.currentUser = currentUser;
                                 UINavigationController *navigationController = (UINavigationController *)[UIApplication.sharedApplication.keyWindow rootViewController];
                                 [self dismissViewControllerAnimated:YES completion:nil];
                                 [navigationController pushViewController:toDoListViewController animated:YES];
                             }
                         }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:NO completion:nil];
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
