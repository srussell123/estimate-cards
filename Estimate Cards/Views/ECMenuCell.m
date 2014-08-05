//
//  ECMenuCellTableViewCell.m
//  Estimate Cards
//
//  Created by Christopher Martin on 6/25/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "ECMenuCell.h"

@implementation ECMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
