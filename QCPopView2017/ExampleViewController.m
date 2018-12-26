//
//  ExampleViewController.m
//  QCMultiUpdatePopView
//
//  Created by 乔超 on 2017/8/8.
//  Copyright © 2017年 BoYaXun. All rights reserved.
//

#import "ExampleViewController.h"
#import "QCMultiUpdatePopView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ExampleViewController ()<QCMultiUpdatePopViewDelegate>

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) UIButton *testButton;
@property (nonatomic, strong) QCMultiUpdatePopView *QCMultiUpdatePopView;
@property(nonatomic,strong) NSMutableArray *hasSelectArr;
@property(nonatomic,strong) NSMutableArray *flagArr;


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

-(NSMutableArray *)flagArr{
    
    if (!_flagArr) {
        _flagArr = [NSMutableArray new];
    }
    return _flagArr;
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
    
    
    [self.flagArr  addObject:@"0"];
    [self.flagArr  addObject:@"1"];
    [self.flagArr  addObject:@"0"];
    [self.flagArr  addObject:@"1"];
    [self.flagArr  addObject:@"0"];
    [self.flagArr  addObject:@"1"];
    [self.flagArr  addObject:@"0"];
    [self.flagArr  addObject:@"1"];
    [self.flagArr  addObject:@"0"];
    
    
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
    
    
    //MARK:初始化选中数据
    self.hasSelectArr = [NSMutableArray new];
    [self.flagArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:@"1"]) {
            [self.hasSelectArr addObject:self.titleArray[idx]];
        }
    }];
    
    [self popWithNameArr:self.titleArray AndStateArr:self.flagArr];
    


}

#pragma mark - 创建和弹出
-(void)popWithNameArr:(NSMutableArray *)nameArr AndStateArr:(NSMutableArray *)stateArr{
    
    
    //初始化，
    _QCMultiUpdatePopView = [[QCMultiUpdatePopView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height)];
    //遵守协议
    _QCMultiUpdatePopView.QCMultiUpdatePopViewDelegate = self;
    
    //    _QCMultiUpdatePopView.selectArr = self.flagArr;//展示选中效果
    //传递数据
    [_QCMultiUpdatePopView showThePopViewWithArray:nameArr andState:stateArr];
    __weak typeof(self) weakSelf = self;
    //MARK:取消
    _QCMultiUpdatePopView.isCancel = ^(BOOL isCancel) {
        if (isCancel) {
            typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.hasSelectArr removeAllObjects];
            NSLog(@"我点击了取消按钮，数组已经被清空");
        }
    };
    //MARK:确认
    _QCMultiUpdatePopView.isSure = ^(BOOL isSure) {
        //进行一些请求上传的工作
        typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.hasSelectArr removeAllObjects];
        NSLog(@"%@",@"我点击了确认按钮，在这里给后台发送请求，记住状态");
        
    };
    
    
    
    
}


#pragma mark - QCMultiUpdatePopViewDelegate

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
    
    NSLog(@"=====%@",[self jointStringByMutableArr:self.hasSelectArr]);
    

}

#pragma mark - 字符串拼接
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
