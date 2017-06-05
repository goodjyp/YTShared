//
//  UIView+YYHFrame.m
//  lesson UIView
//
//  Created by 元虎的mac on 15/7/27.
//  Copyright (c) 2015年 元虎的mac. All rights reserved.
//

#import "UIView+YYHFrame.h"

@implementation UIView (YYHFrame)
- (CGFloat)height{
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height{
    
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width{
    
}

-(CGFloat)Y{
    return self.frame.origin.y;
}

-(void)setY:(CGFloat)Y{
    
}

-(CGFloat)X{
    return self.frame.origin.x;
}

-(void)setX:(CGFloat)X{
    
}
-(CGFloat)X_width{
    return self.X + self.width;
}
-(void)setX_width:(CGFloat)X_width{
    
}
-(CGFloat)Y_height{
    return self.Y + self.height;
}
-(void)setY_height:(CGFloat)Y_height{
    
}
@end
