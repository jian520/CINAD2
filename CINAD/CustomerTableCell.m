//
//  CustomerTableCell.m
//  WCHL
//
//  Created by John Smith on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomerTableCell.h"

@implementation CustomerTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
    if (self == [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
        
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator]; 
        
        self.textLabel.font = TTSTYLEVAR(tableFont);
        self.textLabel.textColor = TTSTYLEVAR(textColor);
        self.textLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.textLabel.textAlignment = UITextAlignmentLeft;
        self.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
        self.textLabel.adjustsFontSizeToFitWidth = YES;
        if (TTIsPad()) {
             self.textLabel.numberOfLines =1; 
        }else
            self.textLabel.numberOfLines = 2;
        
        
        self.detailTextLabel.font = TTSTYLEVAR(font);
        self.detailTextLabel.textColor = TTSTYLEVAR(tableSubTextColor);
        self.detailTextLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.detailTextLabel.textAlignment = UITextAlignmentLeft;
        self.detailTextLabel.contentMode = UIViewContentModeTop;
        //  self.detailTextLabel.lineBreakMode = UILineBreakModeTailTruncation;
        //  self.detailTextLabel.numberOfLines = kTableMessageTextLineCount;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    
    CGFloat height = self.contentView.height;
    
    CGFloat width = self.contentView.width - (height + kTableCellSmallMargin);
    CGFloat left = 0;
    /// NSLog(@"%f", height);
    if (_imageView2) {
        _imageView2.frame = CGRectMake(2,5, 75, 60);
        _imageView2.backgroundColor = [UIColor whiteColor];
        
       
        
        left = _imageView2.right + kTableCellSmallMargin;
        
        CALayer *layer = [_imageView2 layer];
        layer.borderColor = [[UIColor whiteColor] CGColor];
        layer.borderWidth = 1.0f;
        
        _imageView2.layer.shadowColor = [UIColor blackColor].CGColor;
        _imageView2.layer.shadowOffset = CGSizeMake(1, 1);
        _imageView2.layer.shadowOpacity = 0.5;
        _imageView2.layer.shadowRadius = 2.0;
        
    } else {
        left = kTableCellHPadding;
    }
    
    if (self.detailTextLabel.text.length) {
        CGFloat textHeight = 40;
        CGFloat subtitleHeight = self.detailTextLabel.font.ttLineHeight;
        CGFloat paddingY = floor((height - (textHeight + subtitleHeight))/2);
        
        if (TTIsPad()) {
            width = 700;
        }else width = 220;
        
        self.textLabel.frame = CGRectMake(left, paddingY, width, textHeight);
        self.detailTextLabel.frame = CGRectMake(left, self.textLabel.bottom, width, subtitleHeight);
        
    } else {
        self.textLabel.frame = CGRectMake(_imageView2.right + kTableCellSmallMargin, 0, width, height);
        self.detailTextLabel.frame = CGRectZero;
    }
}



@end
