//
//  QCMultiUpdatePopView.h
//  test
//
//  Created by 乔超 on 2017/8/8.
//  Copyright © 2017年 BoYaXun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QCMultiUpdatePopViewDelegate <NSObject>

- (void)getTheButtonTitleWithIndexPath:(NSIndexPath *)indexPath andState:(NSString*) state;

@end

@interface QCMultiUpdatePopView : UIView
/**
 *  内容视图
 */
@property (nonatomic, strong) UIView *contentView;
/**
 *  按钮高度
 */
@property (nonatomic, assign) CGFloat buttonH;
/**
 *  按钮的垂直方向的间隙
 */
@property (nonatomic, assign) CGFloat buttonMargin;
/**
 *  内容视图的位移
 */
@property (nonatomic, assign) CGFloat contentShift;
/**
 *  动画持续时间
 */
@property (nonatomic, assign) CGFloat animationTime;
/**
 * tableView的高度
 */
@property (nonatomic, assign) CGFloat tableViewH;
@property (nonatomic, weak) id <QCMultiUpdatePopViewDelegate> QCMultiUpdatePopViewDelegate ;

/**
 *  展示popView
 *
 *  @param array button的title数组
 */
- (void)showThePopViewWithArray:(NSMutableArray *)array andState:(NSMutableArray *)state;

/*
 *   取消返回清空操作
 */
@property(nonatomic,copy) void(^isCancel)(BOOL isCancel);

/*
 *   确认返回清空操作
 */
@property(nonatomic,copy) void (^isSure)(BOOL isSure);



/**
 *  移除popView
 */
- (void)dismissThePopView;




@end
