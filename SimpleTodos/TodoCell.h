//
//  TodoCell.h
//  SimpleTodos
//
//  Created by Kevin Patel on 8/13/13.
//  Copyright (c) 2013 Kevin Patel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TodoCell;

@protocol todoCellDelegate <NSObject>

-(void)todoCell:(TodoCell *)cell onEndEditing:(UITextField *)textField;

@end

@interface TodoCell : UITableViewCell
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *textCell;
@property (weak,nonatomic) id <todoCellDelegate> delegate;
@end
