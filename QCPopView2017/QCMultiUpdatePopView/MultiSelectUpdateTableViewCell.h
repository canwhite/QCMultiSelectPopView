//
//  MultiSelectUpdateTableViewCell.h
//  QCMultiUpdatePopView2017
//
//  Created by EricZhang on 2018/9/27.
//  Copyright © 2018年 BoYaXun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MultiViewCell1Delegate <NSObject>
-(void)MultiViewCell1DelegateClickWithIndexPath:(NSIndexPath *)indexPath;
@end


@interface MultiSelectUpdateTableViewCell : UITableViewCell
@property(nonatomic,strong) UIButton *selectButton;
@property(nonatomic,assign) BOOL isSelect;
@property(nonatomic,weak) id<MultiViewCell1Delegate> delegate;
@property(nonatomic,strong) NSIndexPath *indexPath;


@end
