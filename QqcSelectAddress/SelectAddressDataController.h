//
//  SelectAddressDataController.h
//  MedicalSiri
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 JZTW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectAddressDataController : NSObject

- (void)fetchTableData:(void(^)(NSArray* arrayAddress))blockRet;

@end
