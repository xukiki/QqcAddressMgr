//
//  SelectAddressTableViewCell.m
//  MedicalSiri
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 JZTW. All rights reserved.
//

#import "SelectAddressTableViewCell.h"
#import "UIView+Qqc.h"

@interface SelectAddressTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UIImageView *indicate;

@end

@implementation SelectAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configUIWithObj:(NSDictionary*)dicObj selectedId:(NSNumber*)selId
{
    self.address.text = [dicObj objectForKey:@"name"];
    
    if (nil==selId || ![[dicObj objectForKey:@"id"] isEqualToNumber:selId]) {
        self.indicate.hidden=YES;
    }else{
        self.indicate.hidden=NO;
    }
}


@end
