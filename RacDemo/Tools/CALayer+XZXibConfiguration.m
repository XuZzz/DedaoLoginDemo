//
//  CALayer+XZXibConfiguration.m
//  RacDemo
//
//  Created by Xu on 2018/6/4.
//  Copyright © 2018年 com.delinshe. All rights reserved.
//

#import "CALayer+XZXibConfiguration.h"

@implementation CALayer (XZXibConfiguration)

- (void)setBorderUIColor:(UIColor *)borderUIColor{
    
    self.borderColor = borderUIColor.CGColor;
}

- (UIColor *)borderUIColor{
    
    return [UIColor colorWithCGColor:self.borderColor];
}
@end
