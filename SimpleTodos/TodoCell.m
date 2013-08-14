//
//  TodoCell.m
//  SimpleTodos
//
//  Created by Kevin Patel on 8/13/13.
//  Copyright (c) 2013 Kevin Patel. All rights reserved.
//

#import "TodoCell.h"

@implementation TodoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)editingDone:(id)sender {
    [self.delegate todoCell:self onEndEditing:sender];
}

- (IBAction)editingBegins:(id)sender {
    if ([self.delegate respondsToSelector:@selector(todoCell:onBeginEditing:)]) {
        [self.delegate todoCell:self onBeginEditing:sender];
    }
}

@end
