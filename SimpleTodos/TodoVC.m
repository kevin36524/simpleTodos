//
//  TodoVC.m
//  SimpleTodos
//
//  Created by Kevin Patel on 8/13/13.
//  Copyright (c) 2013 Kevin Patel. All rights reserved.
//

#import "TodoVC.h"
#import "TodoCell.h"

@interface TodoVC ()
@property (strong,nonatomic) NSArray *todoModel;
@end

@implementation TodoVC

@synthesize todoModel = _todoModel;

#pragma mark - setters and getters

-(NSArray *) todoModel {
    if (!_todoModel) {
        _todoModel = @[@"foo", @"bar"];
    }
    return _todoModel;
}

-(void) setTodoModel:(NSArray *)todoModel{
    _todoModel = todoModel;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"TODOS";
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.todoModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"todo Cell";
    
    UINib *customNib = [UINib nibWithNibName:@"TodoCell" bundle:nil];
    [self.tableView registerNib:customNib forCellReuseIdentifier:CellIdentifier];
    
    TodoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textCell.text = [self.todoModel objectAtIndex:indexPath.row];
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSMutableArray *mutableModel = [self.todoModel mutableCopy];
        [mutableModel removeObjectAtIndex:indexPath.row];
        self.todoModel = [mutableModel copy];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
