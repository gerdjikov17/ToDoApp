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
    [self showAlertMessageWithTitle:@"Login failed" andMsg:@"Please try again"];
    return NO;
}

- (IBAction)onRegisterButtonTap:(id)sender {
    if (([self.nameTextField.text length] < 4) || ([self.passwordTextField.text length] < 6)) {
        [self showAlertMessageWithTitle:@"Registration failed" andMsg:@"Please try again."];
    }
    else {
        UserModel *newUser = [[UserModel alloc] initWithUsername:self.nameTextField.text andPassword:self.passwordTextField.text];
        [self showConfirmPasswordMessage:newUser];
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
}


- (void) showAlertMessageWithTitle:(NSString *)title andMsg:(NSString *)msg {
    UIAlertController *alert= [UIAlertController
                                 alertControllerWithTitle:title
                                 message:msg
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [self.navigationController presentViewController:alert animated:YES
                                               completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [alert dismissViewControllerAnimated:YES completion:^{
        }];
    });
}

- (void) showConfirmPasswordMessage:(UserModel *)user {
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Registration"
                               message:@"Please confirm password."
                               preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Password";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    UIAlertAction *confirmBtn = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([alert.textFields[0].text isEqualToString:user.password]) {
            if(![self doesUserExists:user])
            {
                [self.users addObject:user];
                [UsersDataSerializer saveUsersInUserDefaults:self.users];
                //[[NSUserDefaults standardUserDefaults] setObject:self.passwordTextField.text forKey:self.nameTextField.text];
            }
            else {
                [self showAlertMessageWithTitle:@"Registration failed." andMsg:@"Account with this username already exists."];
            }
        }
    }];
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:confirmBtn];
    [alert addAction:cancelBtn];
    [self.navigationController presentViewController:alert animated:YES
                                          completion:nil];
}

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

-(BOOL) doesUserExists:(UserModel *)newUser {
    for (UserModel *user in self.users) {
        if ([user.userName isEqualToString:newUser.userName]) {
            return YES;
        }
    }
    return NO;
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
