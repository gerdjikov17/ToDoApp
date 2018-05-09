//
//  ToDoListTableViewController.m
//  FirstApp
//
//  Created by A-Team User on 2.05.18.
//  Copyright © 2018 A-Team User. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ToDoListTableViewController.h"
#import "ToDoListTableViewCell.h"
#import "ToDoModel.h"
#import "UserModel.h"

@interface ToDoListTableViewController ()

@end

@implementation ToDoListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.searchBar;
    self.searchBar.delegate = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTodo)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)addTodo {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add ToDo" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Write to do";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Category";
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDate * now = [NSDate date];
        ToDoModel *toDo = [[ToDoModel alloc] initWithText:alertController.textFields[0].text andTimeCreated:now andCategory:alertController.textFields[1].text];
        [self.dataDelegate addToDo:toDo forName:self.currentUser.userName];
        [self.tableView reloadData];
    }];
    UIAlertAction *discardAction = [UIAlertAction actionWithTitle:@"Discard" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:okAction];
    [alertController addAction:discardAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.toDos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoListTableViewCell *cell = (ToDoListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ToDoModel *toDo = [self.toDos objectAtIndex:indexPath.row];
    cell.nameLabel.text = self.currentUser.userName;
    cell.todoLabel.text = toDo.text;
    cell.categoryLabel.text = toDo.category;
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm:ss"];
    NSString *newTimeString = [outputFormatter stringFromDate:toDo.timeCreated];
    cell.timeLabel.text = newTimeString;
    if (self.currentUser.gender == EnumGenderMale) {
        cell.profileImage.image = [UIImage imageNamed:@"bratzo.png"];
    }
    else {
        cell.profileImage.image = [UIImage imageNamed:@"melania.png"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataDelegate deleteToDoAtIndex:indexPath.row forName:self.currentUser.userName];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.tableView reloadData];
}

-(NSArray<ToDoModel *> *) filteredTodosWithCategoryString:(NSString *)categoryString {
    return [[self.dataDelegate toDosForName:self.currentUser.userName] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(ToDoModel*  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.category.lowercaseString hasPrefix:categoryString.lowercaseString];
    }]];
}

- (NSArray<ToDoModel *> *)toDos {
    if ([self.searchBar.text isEqualToString:@""]) {
        return [self.dataDelegate toDosForName:self.currentUser.userName];
    }
    return [self filteredTodosWithCategoryString:self.searchBar.text];
}
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
