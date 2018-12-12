//
//  MultiSelectTableViewCell.m
//  QCMultiPopView2017
//
//  Created by EricZhang on 2018/9/27.
//  Copyright © 2018年 BoYaXun. All rights reserved.
//

#import "MultiSelectTableViewCell.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define LineColor [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]
@implementation MultiSelectTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.backgroundColor = [UIColor whiteColor];
        CGFloat width = self.frame.size.width;
        
        UIView *view = [UIView new];
        [self addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH - 40, SCREEN_HEIGHT * (40.0/736.0));

        self.selectButton = [[UIButton alloc]initWithFrame:view.frame];
        self.selectButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.selectButton setTitleColor:[UIColor blackColor] forState:0];
        [self.selectButton setBackgroundImage:[UIImage imageNamed:@"multi_unselect"] forState:UIControlStateNormal];
        [self.selectButton setBackgroundImage:[UIImage imageNamed:@"multi_select"] forState:UIControlStateSelected];
        [self.selectButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:self.selectButton];

    }
    return self;
}

-(void)clickButton:(UIButton *)button{
    if (_delegate && [_delegate respondsToSelector:@selector(MultiViewCell1DelegateClickWithIndexPath:)]) {
        [_delegate MultiViewCell1DelegateClickWithIndexPath:_indexPath];
    }
}

-(void)setIsSelect:(BOOL)isSelect{
    
    if (isSelect) {
        self.selectButton.selected = YES;
    }else{
        self.selectButton.selected = NO;
    }
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
