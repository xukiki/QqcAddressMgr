//
//  SelectAddressViewController.h
//  MedicalSiri
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 JZTW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityAddress.h"

typedef void(^selAddressBlock)(NSDictionary* dicSelectedProvince, NSDictionary* dicSelectedCity, NSDictionary* dicSelectedArea);

@interface SelectAddressViewController : UIViewController

- (void)configWithCurrentSelAddressEntity:(EntityAddress*)entity;

- (void)showModelWithBlock:(selAddressBlock)block;

@end
