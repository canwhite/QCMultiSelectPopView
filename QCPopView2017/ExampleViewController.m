//
//  ExampleViewController.m
//  QCMultiPopView
//
//  Created by 乔超 on 2017/8/8.
//  Copyright © 2017年 BoYaXun. All rights reserved.
//

#import "ExampleViewController.h"
#import "QCMultiPopView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ExampleViewController ()<QCMultiPopViewDelegate>

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) UIButton *testButton;
@property (nonatomic, strong) QCMultiPopView *QCMultiPopView;
@property(nonatomic,strong) NSMutableArray *hasSelectArr;


@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTitleArray];
    [self initSubViews];

}


//懒加载标题数组
- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

//要现在堆中建立位置
-(NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray new];
    }
    return _imageArr;
}

- (void)initTitleArray{
    //给此数组传递popView的各项标题
    [self.titleArray addObject:@"测试1"];
    [self.titleArray addObject:@"测试2"];
    [self.titleArray addObject:@"测试3"];
    [self.titleArray addObject:@"测试4"];
    [self.titleArray addObject:@"测试5"];
    [self.titleArray addObject:@"测试6"];
    [self.titleArray addObject:@"测试7"];
    [self.titleArray addObject:@"测试8"];
    [self.titleArray addObject:@"测试9"];
    

    
}

- (void)initSubViews{
    //此按钮可改成自己的控件
    _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _testButton.frame = CGRectMake(100, 100, 200, 100);
    [_testButton setTitle:@"测试按钮" forState:UIWindowLevelNormal];
    [_testButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_testButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    _testButton.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_testButton];
    
}

- (void)buttonClick{
    
    //初始化
    _QCMultiPopView = [[QCMultiPopView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height)];
    //遵守协议
    _QCMultiPopView.QCMultiPopViewDelegate = self;
        self.hasSelectArr = [NSMutableArray new];
    //传递数据
    [_QCMultiPopView showThePopViewWithArray:self.titleArray];
    __weak typeof(self) weakSelf = self;
    _QCMultiPopView.sendData = ^(BOOL isCancel) {
        if (isCancel) {
            typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.hasSelectArr removeAllObjects];
            NSLog(@"我点击了取消按钮，数组已经被清空");
        }
    };
    
    
}

#pragma mark - QCMultiPopViewDelegate

-(void)getTheButtonTitleWithIndexPath:(NSIndexPath *)indexPath andState:(NSString *)state{
    
    
    NSString *buttonStr = self.titleArray[indexPath.row];
    [_testButton setTitle:buttonStr forState:UIControlStateNormal];
    //0就是没选中
    if ([state isEqual:@"0"]) {
        if ([self.hasSelectArr containsObject:self.titleArray[indexPath.row]]) {
            [self.hasSelectArr removeObject:self.titleArray[indexPath.row]];
        }
        
    //1就是选中了
    }else if ([state isEqual:@"1"]){
        
        if (![self.hasSelectArr containsObject:self.titleArray[indexPath.row]]) {
            [self.hasSelectArr addObject:self.titleArray[indexPath.row]];
        }
        
    }
    
    NSLog(@"$$$$$$$%@",[self jointStringByMutableArr:self.hasSelectArr]);
    

}


-(NSString *)jointStringByMutableArr:(NSMutableArray *)arr{
    
    NSString *pinStr = @"";
    for (int i =0; i< arr.count; i ++) {
        if (i == 0) {
            pinStr = [NSString stringWithFormat:@"%@,",arr[i]];
        }else if (i == arr.count -1){
            pinStr = [NSString stringWithFormat:@"%@%@",pinStr,arr[i]];
        }else{
            pinStr = [NSString stringWithFormat:@"%@%@,",pinStr,arr[i]];
        }
    }
    return pinStr;
    
    
}



@end
