//
//  CustomAnnotationView.m
//  CustomAnnotationDemo
//
//  Created by songjian on 13-3-11.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"

#define Width  25.f
#define Height 40.f

#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  50.f
#define kPortraitHeight 50.f

#define kCalloutWidth   60.0
#define kCalloutHeight  30.0

@interface CustomAnnotationView ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation CustomAnnotationView

@synthesize calloutView;
@synthesize portraitImageView   = _portraitImageView;
@synthesize nameLabel           = _nameLabel;

#pragma mark - Handle Action



- (void)setZuijin:(NSString *)zuijin
{
    _zuijin = zuijin;
    
    if ([zuijin isEqualToString:@"ok"]) {
        
        self.selected = YES;

    }
}

#pragma mark - Override

- (NSString *)name
{
    return self.nameLabel.text;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if ([_zuijin isEqualToString:@"ok"]) {
            
            if (self.calloutView == nil)
            {
                
                self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
                
                
                self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f,
                                                      -CGRectGetHeight(self.calloutView.bounds) / 2.f+5);
                
                UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, -5, 60, 30)];
                name.backgroundColor = [UIColor clearColor];
                name.textColor = [UIColor whiteColor];
                name.font = [UIFont systemFontOfSize:11];
                name.textAlignment = NSTextAlignmentCenter;
                name.text = @"离我最近";
                [self.calloutView addSubview:name];
            }
            
            [self addSubview:self.calloutView];

        }
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
  
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {

        
        self.bounds = CGRectMake(0.f, 0.f, Width, Height);
        
        
      
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitWidth + kHoriMargin,
                                                                   kVertMargin,
                                                                   Width ,
                                                                   Height )];
        self.nameLabel.backgroundColor  = [UIColor clearColor];
        self.nameLabel.textAlignment    = NSTextAlignmentCenter;
        self.nameLabel.textColor        = [UIColor whiteColor];
        self.nameLabel.font             = [UIFont systemFontOfSize:13.f];
        [self addSubview:self.nameLabel];
    }
    
    return self;
}

@end
