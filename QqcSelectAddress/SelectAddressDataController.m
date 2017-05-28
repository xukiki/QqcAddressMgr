//
//  SelectAddressDataController.m
//  MedicalSiri
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 JZTW. All rights reserved.
//

#import "SelectAddressDataController.h"
#import "QqcLog.h"
#import "QqcComFuncDef.h"
#import "NSBundle+Qqc.h"

@implementation SelectAddressDataController

- (void)fetchTableData:(void(^)(NSArray* arrayAddress))blockRet
{
    NSString* addressDataPath = [[NSBundle bundleWithName:@"QqcSelectAddress"] pathForResource:@"Address" ofType:@"plist"];
    NSArray* arrayAddress = nil;
    if (str_is_exist_qqc(addressDataPath)) {
       arrayAddress = [[NSMutableArray alloc] initWithContentsOfFile:addressDataPath];
    }else{
        QqcWarnLog(@"找不到Address.plist文件");
    }
    
    blockRet(arrayAddress);
}

@end
