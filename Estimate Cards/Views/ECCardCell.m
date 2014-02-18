//
//  ECCardCell.m
//  Estimate Cards
//
//  Created by Christopher Martin on 2/17/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "ECCardCell.h"

NSString *const kECCardCellReuseId = @"ECCardCellId";

@interface ECCardCell ()

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (weak, nonatomic) IBOutlet UILabel *upperLeftDisplayLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowerRightDisplayLabel;

@end

@implementation ECCardCell

+(NSString*)cellReuseId{
    return kECCardCellReuseId;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 7.0;
    self.layer.borderColor = [[UIColor blackColor] CGColor];
}

-(void)setDisplayValue:(NSString *)displayValue{
    _displayValue = displayValue;
    
    self.displayLabel.text = self.displayValue;
    self.upperLeftDisplayLabel.text = self.displayValue;
    self.lowerRightDisplayLabel.text = self.displayValue;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
