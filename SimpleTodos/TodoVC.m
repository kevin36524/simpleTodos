//
//  TodoVC.m
//  SimpleTodos
//
//  Created by Kevin Patel on 8/13/13.
//  Copyright (c) 2013 Kevin Patel. All rights reserved.
//

#import "TodoVC.h"
#import "TodoCell.h"

#define TODOSTOREKEY @"todoStoreKey"

@interface TodoVC () <todoCellDelegate>
@property (strong,nonatomic) NSArray *todoModel;
@property (strong,nonatomic) UITapGestureRecognizer *tgs;
@end

@implementation TodoVC

@synthesize todoModel = _todoModel;
@synthesize tgs = _tgs;

#pragma mark - setters and getters

-(NSArray *) todoModel {
    if (!_todoModel) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _todoModel = [defaults objectForKey:TODOSTOREKEY];
        if (!_todoModel) {
            _todoModel = @[];
        }
    }
    return _todoModel;
}

-(void) setTodoModel:(NSArray *)todoModel{
    _todoModel = todoModel;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_todoModel forKey:TODOSTOREKEY];
    [defaults synchronize];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"TODOS";
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewTodo)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.tgs = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeKeyBoard)];
    
}


#pragma mark - Todo Cell delegates
-(void) todoCell:(TodoCell *)cell onEndEditing:(UITextField *)textField {
    NSMutableArray *mutableModel = [self.todoModel mutableCopy];
    NSString *newText = textField.text;
    NSUInteger row = [self.tableView indexPathForCell:cell].row;
    BOOL shouldReload = NO;
    
    if ([newText isEqual:@""]) {
        [mutableModel removeObjectAtIndex:row];
        shouldReload = YES;
    } else {
        [mutableModel setObject:newText atIndexedSubscript:row];
    }
    self.todoModel = [mutableModel copy];
    if (shouldReload) {
        [self.tableView reloadData];
    }
    [self.view removeGestureRecognizer:self.tgs];
}

-(void)todoCell:(TodoCell *)cell onBeginEditing:(UITextField *)textField {
    [self.view addGestureRecognizer:self.tgs];
}

#pragma mark - local methods
-(void) removeKeyBoard {
    [self.view endEditing:YES];
}

-(void) addNewTodo {
    [self removeKeyBoard];
    self.todoModel = [@[@""] arrayByAddingObjectsFromArray:self.todoModel];
    [self.tableView reloadData];
    TodoCell *firstCell = (TodoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [firstCell.textCell becomeFirstResponder];
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
    cell.delegate = self;
    return cell;
}

-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self removeKeyBoard];
    return UITableViewCellEditingStyleDelete;
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


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSMutableArray *mutableModel = [self.todoModel mutableCopy];
    id tempObj = [mutableModel objectAtIndex:fromIndexPath.row];
    [mutableModel removeObjectAtIndex:fromIndexPath.row];
    [mutableModel insertObject:tempObj atIndex:fromIndexPath.row];
    
    self.todoModel = [mutableModel copy];
}


#pragma mark - Legacy Methods

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
