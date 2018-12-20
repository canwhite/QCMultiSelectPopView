//
//  QCMultiUpdatePopView.m
//  test
//
//  Created by 乔超 on 2017/8/8.
//  Copyright © 2017年 BoYaXun. All rights reserved.
//

#import "QCMultiUpdatePopView.h"
#import "MultiSelectUpdateTableViewCell.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define LineColor [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]
#define QCTitleColor [UIColor colorWithRed:103.0/255.0 green:103.0/255.0 blue:103.0/255.0 alpha:1.0]

@interface QCMultiUpdatePopView ()<UITableViewDataSource,UITableViewDelegate,MultiViewCell1Delegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *imageSource;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic,strong) NSMutableArray *selectArr;//state标志

@end
@implementation QCMultiUpdatePopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        //初始化各种起始属性
        [self initAttribute];
        [self initTabelView];
        
    }
    return self;
}

- (void)initTabelView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH-40, self.contentShift-80) style:UITableViewStylePlain];
//    self.tableView.layer.cornerRadius = 10;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MultiSelectUpdateTableViewCell class] forCellReuseIdentifier:@"cell1"];
    
    [self.contentView addSubview:self.tableView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);

    
    
    CGFloat width = self.tableView.frame.size.width;
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 40)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(width/2-100, 13, 200, 14)];
    label.text = @"可选内容";
    //    label.textColor = RGBA(103, 103, 103, 1);
    label.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:label];
    label.font = [UIFont systemFontOfSize:14];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [UIView new];
    lineView.frame = CGRectMake(0, 39, width, 1);
    lineView.backgroundColor = LineColor;
    [headerView  addSubview:lineView];
    [self.contentView addSubview:headerView];

    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:headerView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = headerView.bounds;
    maskLayer1.path = maskPath1.CGPath;
    headerView.layer.mask = maskLayer1;


    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 40 +self.tableView.frame.size.height, width,40)];
    [self.contentView addSubview:footerView];
    UIView *lineView2 = [UIView new];
    [footerView addSubview:lineView2];
    lineView2.frame = CGRectMake(0, 0, width, 1);
    lineView2.backgroundColor = LineColor;
    
//    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, width/2, 100)];
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 1, width/2-1,39)];
    [footerView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:0];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn setTitleColor:QCTitleColor forState:0];
    
    UIView *virLineView = [[UIView alloc]initWithFrame:CGRectMake(width/2-1, 1, 1, 39)];
    virLineView.backgroundColor = LineColor;
    [footerView addSubview:virLineView];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(width/2, 1, width/2, 39)];
    [footerView addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(clickSure:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确定" forState:0];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureBtn setTitleColor:QCTitleColor forState:0];
    //
    
}


//点击了取消按钮
-(void)clickCancel:(UIButton *)btn{
    
//    if (self.sendData) {
//        self.sendData(YES);
//    }
    
    if (self.isCancel) {
        self.isCancel(YES);
    }
    
    [self.selectArr removeAllObjects];
    self.selectArr = nil;
    
    [self removeFromSuperview];
}

//点击确认
-(void)clickSure:(UIButton *)btn{
    
    if (self.isSure) {
        self.isSure(YES);
    }
    [self.selectArr removeAllObjects];
    self.selectArr  = nil;
    
    [self removeFromSuperview];
}


/**
 *  初始化起始属性
 */

- (void)initAttribute{
    
    self.buttonH = SCREEN_HEIGHT * (40.0/736.0)+1;
    self.buttonMargin = 5;
    self.contentShift = SCREEN_HEIGHT * (400.0/736.0);
    self.animationTime = 0.8;
    self.backgroundColor = [UIColor colorWithWhite:0.614 alpha:0.700];
    
    [self initSubViews];
}


/**
 *  初始化子控件
 */
- (void)initSubViews{
    
    self.contentView = [[UIView alloc]init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 10;
    self.contentView.frame = CGRectMake(20, 150, SCREEN_WIDTH-40, self.contentShift);
    [self addSubview:self.contentView];
    
}
/**
 *  展示pop视图
 *
 *  @param array 需要显示button的title数组
 */
- (void)showThePopViewWithArray:(NSMutableArray *)array andState:(NSMutableArray *)state{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    
    [window addSubview:self];
    self.dataSource = array;
    
    NSLog(@"%@",state);
//    [state enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self.selectArr addObject:obj];
//    }];
    //mutableCopy 返回的是mutableArr ，copy 返回的是nsarray
    self.selectArr = [state mutableCopy];

    NSLog(@"%@",self.selectArr);


}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   MultiSelectUpdateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    NSString * buttonStr = self.dataSource[indexPath.row];
    [cell.selectButton setTitle:buttonStr forState:0];
    cell.delegate = self;
    cell.indexPath = indexPath;
    NSLog(@"=====%@",self.selectArr[indexPath.row]);
    cell.isSelect = [self.selectArr[indexPath.row] integerValue];
    

    return cell;
}
#pragma mark - UITableViewDelagate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.buttonH;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if ([self.QCMultiUpdatePopViewDelegate respondsToSelector:@selector(getTheButtonTitleWithIndexPath:)]) {
//        [self.QCMultiUpdatePopViewDelegate getTheButtonTitleWithIndexPath:indexPath];
//    }
}

#pragma mark -- collectioCell1的代理
-(void)MultiViewCell1DelegateClickWithIndexPath:(NSIndexPath *)indexPath{
    
    MultiSelectUpdateTableViewCell *cell = (MultiSelectUpdateTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];

    cell.selectButton.selected = !cell.selectButton.selected;

    //是否点击判断
    BOOL click = cell.selectButton.selected;
    if (click) {
        [self.selectArr replaceObjectAtIndex:indexPath.row withObject:@"1"];

        if ([self.QCMultiUpdatePopViewDelegate respondsToSelector:@selector(getTheButtonTitleWithIndexPath:andState:)]) {
            [self.QCMultiUpdatePopViewDelegate getTheButtonTitleWithIndexPath:indexPath andState:self.selectArr[indexPath.row]];
        }

    }else{
        [self.selectArr replaceObjectAtIndex:indexPath.row withObject:@"0"];
        if ([self.QCMultiUpdatePopViewDelegate respondsToSelector:@selector(getTheButtonTitleWithIndexPath:andState:)]) {
            [self.QCMultiUpdatePopViewDelegate getTheButtonTitleWithIndexPath:indexPath andState:self.selectArr[indexPath.row]];
        }
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [self dismissThePopView];
    
    
}
- (void)dismissThePopView{
    
    [self removeFromSuperview];
    
}

-(NSMutableArray *)selectArr{

    if (!_selectArr) {
        _selectArr = [NSMutableArray new];
    }
    return _selectArr;
}





@end
