//
//  SelectAddressViewController.m
//  MedicalSiri
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 JZTW. All rights reserved.
//

#import "SelectAddressViewController.h"
#import "SelectAddressDataController.h"
#import "SelectAddressTableViewCell.h"
#import "QqcModelPanel.h"
#import "UIButton+Qqc.h"
#import "UINib+Qqc.h"

@interface SelectAddressViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewBg;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnClose;

@property (nonatomic, strong) NSMutableArray* arrayDataCurrent;
@property (nonatomic, strong) NSArray* arrayAddress;
@property (nonatomic, strong) NSString* currentSelFor;          //Province,City,Area
@property (nonatomic, strong) NSDictionary* dicSelectedProvince;
@property (nonatomic, strong) NSDictionary* dicSelectedCity;
@property (nonatomic, strong) NSDictionary* dicSelectedArea;

@property (nonatomic, strong) EntityAddress* entityAddress;
@property (nonatomic, strong) SelectAddressDataController* selectAddressDC;
@property (nonatomic, copy) selAddressBlock blockRet;

@property(nonatomic, strong)UIView* viewTouch;

@end

@implementation SelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configTableView];

    [self.btnBack setImage:@"navigationbar_back.png" bundle:@"QqcSelectAddress"];
    [self.btnClose setImage:@"list_ticked_gray.png" bundle:@"QqcSelectAddress"];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.viewBg.backgroundColor = [UIColor whiteColor];
    self.btnBack.hidden = YES;
    _currentSelFor = @"Province";
    
    [self loadData];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapMainView:)];
    [self.viewTouch addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewTouch
{
    if (nil == _viewTouch) {
        _viewTouch = [[UIView alloc] initWithFrame:self.view.frame];
        _viewTouch.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:_viewTouch];
        [self.view sendSubviewToBack:_viewTouch];
    }
    
    return _viewTouch;
}


- (void)onTapMainView:(UITapGestureRecognizer *)sender
{
    _blockRet(nil, nil, nil);
    [self closeView];
}

#pragma mark - 接口
- (void)configWithCurrentSelAddressEntity:(EntityAddress*)entity
{
    _entityAddress = entity;
}

- (void)showModelWithBlock:(selAddressBlock)block
{
    _blockRet = block;
    [QqcModelPanel showModelAppendView:self.view animationType:QqcModelAnimationTypeFromBottom bgAlpha:0.33 isOnCenter:YES];
}

#pragma mark - 数据初始化
- (SelectAddressDataController *)selectAddressDC
{
    if (nil == _selectAddressDC) {
        _selectAddressDC = [[SelectAddressDataController alloc] init];
    }
    
    return _selectAddressDC;
}

- (void)loadData
{
    __weak typeof(self)weakSelf = self;
    [self.selectAddressDC fetchTableData:^(NSArray *arrayAddress) {
        
        weakSelf.arrayAddress = [[NSArray alloc] initWithArray:arrayAddress];
        
        weakSelf.arrayDataCurrent = [[NSMutableArray alloc] initWithArray:arrayAddress];
        [weakSelf.tableView reloadData];
        
    }];
}

- (void)configTableView
{
    _tableView.rowHeight = 44;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionHeaderHeight = 24;
    _tableView.sectionFooterHeight = 0.1;
    
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    [_tableView registerNib:[UINib nibWithNibName:@"SelectAddressTableViewCell" bundleName:@"QqcSelectAddress"] forCellReuseIdentifier:@"SelectAddressTableViewCellIdentity"];
}

#pragma mark - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    if (_arrayDataCurrent) {
        numberOfRows = _arrayDataCurrent.count;
    }
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectAddressTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SelectAddressTableViewCellIdentity" forIndexPath:indexPath];
    NSNumber* numberSel = nil;
    if ([_currentSelFor isEqualToString:@"Province"]) {
        numberSel = [_dicSelectedProvince objectForKey:@"id"];
    }else if ([_currentSelFor isEqualToString:@"City"]){
        numberSel = [_dicSelectedCity objectForKey:@"id"];
    }else if ([_currentSelFor isEqualToString:@"Area"]){
        numberSel = [_dicSelectedArea objectForKey:@"id"];
    }
    
    [cell configUIWithObj:[_arrayDataCurrent objectAtIndex:indexPath.row] selectedId:numberSel];
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _btnBack.hidden = NO;
    
    NSDictionary* dicSel = [_arrayDataCurrent objectAtIndex:indexPath.row];
    
    if ([_currentSelFor isEqualToString:@"Province"]) {
        
        if (nil == _dicSelectedProvince) {
            _dicSelectedProvince = [[NSMutableDictionary alloc] init];
        }
        
        [_dicSelectedProvince setValue:[dicSel objectForKey:@"id"] forKey:@"id"];
        [_dicSelectedProvince setValue:[dicSel objectForKey:@"name"] forKey:@"name"];
        [_dicSelectedProvince setValue:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"rowindex"];
        _currentSelFor = @"City";
    }
    else if ([_currentSelFor isEqualToString:@"City"]){
        
        if (nil == _dicSelectedCity){
            _dicSelectedCity = [[NSMutableDictionary alloc] init];
        }
        
        [_dicSelectedCity setValue:[dicSel objectForKey:@"id"] forKey:@"id"];
        [_dicSelectedCity setValue:[dicSel objectForKey:@"name"] forKey:@"name"];
        [_dicSelectedCity setValue:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"rowindex"];
        _currentSelFor = @"Area";
    }
    else if ([_currentSelFor isEqualToString:@"Area"]){
        if (nil == _dicSelectedArea){
            _dicSelectedArea = [[NSMutableDictionary alloc] init];
        }
        
        [_dicSelectedArea setValue:[dicSel objectForKey:@"id"] forKey:@"id"];
        [_dicSelectedArea setValue:[dicSel objectForKey:@"name"] forKey:@"name"];
        [_dicSelectedArea setValue:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"rowindex"];
    }
    
    NSArray* arraySub = [[_arrayDataCurrent objectAtIndex:indexPath.row] objectForKey:@"children"];
    if (nil == arraySub || arraySub.count < 1) {
        //没有一级了则回调结果
        
        _blockRet(_dicSelectedProvince, _dicSelectedCity, _dicSelectedArea);
        [self closeView];
    }
    else
    {
        [_arrayDataCurrent removeAllObjects];
        [_arrayDataCurrent addObjectsFromArray:arraySub];
        
        [self.tableView reloadData];
        
        NSIndexPath *scroll2FirstRow = [NSIndexPath indexPathForRow:0 inSection:0];
        [[self tableView] scrollToRowAtIndexPath:scroll2FirstRow
                                atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (IBAction)onBtnBack:(id)sender {
    
    NSNumber* numOfSelRow = nil;
    if ([_currentSelFor isEqualToString:@"Area"]) {
        
        _currentSelFor = @"City";
        _dicSelectedArea = nil;
        [_arrayDataCurrent removeAllObjects];
        NSInteger selProvinceRow = [[_dicSelectedProvince objectForKey:@"rowindex"] integerValue];
        numOfSelRow = [_dicSelectedCity objectForKey:@"rowindex"];
        [_arrayDataCurrent addObjectsFromArray:[[_arrayAddress objectAtIndex:selProvinceRow] objectForKey:@"children"]];
        
    }else if ([_currentSelFor isEqualToString:@"City"]){
        
        _currentSelFor = @"Province";
        _dicSelectedCity = nil;
        self.btnBack.hidden = YES;
        [_arrayDataCurrent removeAllObjects];
        numOfSelRow = [_dicSelectedProvince objectForKey:@"rowindex"];
        [_arrayDataCurrent addObjectsFromArray:_arrayAddress];
    }
    
    [self.tableView reloadData];
    
    NSIndexPath *scroll2FirstRow = [NSIndexPath indexPathForRow:[numOfSelRow integerValue] inSection:0];
    [[self tableView] scrollToRowAtIndexPath:scroll2FirstRow
                            atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
}

- (IBAction)onBtnConfirm:(id)sender {
    
    _blockRet(_dicSelectedProvince, _dicSelectedCity, _dicSelectedArea);
    [self closeView];
}


- (void)closeView
{
    [QqcModelPanel closeModelView];
}

@end
