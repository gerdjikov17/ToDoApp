//
//  ViewController.m
//  FirstApp
//
//  Created by A-Team User on 2.05.18.
//  Copyright © 2018 A-Team User. All rights reserved.
//

#import "ViewController.h"
#import "ToDoListTableViewController.h"
#import "ToDoDataSerializer.h"
#import "UserModel.h"
#import "UsersTableViewController.h"
#import "UsersDataSerializer.h"




@interface ViewController () <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) NSMutableDictionary<NSString *,NSMutableArray<ToDoModel*> *> *toDosDict;
@property (strong, nonatomic) NSMutableArray<UserModel *> *users;
@property (weak, nonatomic) IBOutlet UIView *transperentViewTop;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    self.toDosDict = [ToDoDataSerializer toDoDictFromUserDefaults];
    if (self.toDosDict == nil) {
        self.toDosDict = [[NSMutableDictionary alloc] init];
    }
    self.users = [[UsersDataSerializer usersFromUserDefaults] mutableCopy];
    if (self.users == nil) {
        self.users = [[NSMutableArray alloc] init];
    }
}

- (IBAction)onLoginButtonTap:(id)sender {
    UserModel *user = [[UserModel alloc] initWithUsername:self.nameTextField.text andPassword:self.passwordTextField.text];
    if([self authenticateLoginForUserName:user]) {
        ToDoListTableViewController *toDoListViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"IdentifierToDoListController"];
        toDoListViewController.dataDelegate = self;
        toDoListViewController.currentUser = user;
        [self.navigationController pushViewController:toDoListViewController animated:YES];
    }
}

- (BOOL) authenticateLoginForUserName:(UserModel *)user {
    if([self.users containsObject:user])
    {
        return YES;
    }
    [self showAlertMessage];
    return NO;
}

- (IBAction)onRegisterButtonTap:(id)sender {
    if (([self.nameTextField.text length] < 4) || ([self.passwordTextField.text length] < 6)) {
        [self showAlertMessage];
    }
    else {
        UserModel *newUser = [[UserModel alloc] initWithUsername:self.nameTextField.text andPassword:self.passwordTextField.text];
        if(![self.users containsObject:newUser])
        {
            [self.users addObject:newUser];
            [UsersDataSerializer saveUsersInUserDefaults:self.users];
            //[[NSUserDefaults standardUserDefaults] setObject:self.passwordTextField.text forKey:self.nameTextField.text];
        }
        else {
            
        }
    }
}

- (IBAction)onUsersButtonTap:(id)sender {
    
    UsersTableViewController *usersTableViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"IdentifierUsersTableController"];
    usersTableViewController.usersDataDelegate = self;
    usersTableViewController.toDoListDataDelegate = self;
    
    usersTableViewController.modalPresentationStyle = UIModalPresentationPopover;
    usersTableViewController.popoverPresentationController.sourceView = self.transperentViewTop;
    usersTableViewController.popoverPresentationController.sourceRect = self.transperentViewTop.bounds;
    usersTableViewController.popoverPresentationController.delegate = self;
    [self presentViewController:usersTableViewController animated:YES completion:nil];
    //[self.navigationController pushViewController:usersTableViewController animated:YES];
}


- (void) showAlertMessage {
    UIAlertController *alert= [UIAlertController
                                 alertControllerWithTitle:@"Login fail."
                                 message:@"Please try again."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [self.navigationController presentViewController:alert animated:YES
                                               completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [alert dismissViewControllerAnimated:YES completion:^{
        }];
    });
}

//- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
//    return HalfSized
//}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}



- (NSArray<ToDoModel *> *) toDosForName:(NSString *) name {
    return [self.toDosDict objectForKey:name];
}

- (void) deleteToDoAtIndex:(NSUInteger)index forName:(NSString *)name {
    [[self.toDosDict objectForKey:name] removeObjectAtIndex:index];
}

- (void) addToDo:(ToDoModel *) todo forName:(NSString *)name {
    if ([self.toDosDict objectForKey:name] == nil) {
        [self.toDosDict setObject:[[NSMutableArray alloc] init] forKey:name];
    }
    [[self.toDosDict objectForKey:name] addObject:todo];
}

- (NSArray<UserModel *> *) allUsers{
    return self.users;
}
- (UserModel *) userAtIndex:(NSUInteger)index {
    return [self.users objectAtIndex:index];
}

- (void) applicationWillResignActive:(UIApplication *)application {
    [ToDoDataSerializer saveAllToDos:self.toDosDict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
