//
//  NavigationButton.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 04/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "NavigationButton.h"

@interface NavigationButton ()

@property BOOL buttonOpened;
@property (strong, nonatomic) UIButton *homeButton;
@property (strong, nonatomic) UIButton *mapButton;
@property (strong, nonatomic) UIButton *changeFloorButton;
@property (strong, nonatomic) UIButton *exhibitButton;
@end

@implementation NavigationButton

- (void)awakeFromNib {
    self.buttonOpened = NO;
    
    [self addTarget:self action:@selector(didTouchButton) forControlEvents:UIControlEventTouchUpInside];
    UIImage *buttonImage = [UIImage imageNamed:@"rmButton"];
    [self setImage:buttonImage forState:UIControlStateNormal];
}

- (void)didTouchButton {
    [self animateRMButton];
    
    [self showHideNeededButtons];
    
    _buttonOpened = YES;
}

- (void)showHideNeededButtons {
    if (self.buttonKind == mapVC) {
        [self showHideHomeButton];
        [self showHideChangeFloorButton];
        [self showHideExhibitButton];
    } else if (self.buttonKind == rootVC) {
        [self showHideMapButton];
        [self showHideExhibitButton];
    } else if (self.buttonKind == exhibitVC) {
        [self showHideHomeButton];
        [self showHideMapButton];

    }
}

- (void)animateRMButton {
    UIView *myView = self.imageView;
    CABasicAnimation* spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    spinAnimation.duration = 0.2f;
    spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    spinAnimation.toValue = [NSNumber numberWithFloat: 2.0 * M_PI * 1.0];
    [myView.layer addAnimation:spinAnimation forKey:@"spinAnimation"];
}

- (void)animateCreation:(UIButton *)button withOffset:(CGFloat)offset andDuration:(CGFloat)duration {
    CGPoint newLeftCenter = CGPointMake(offset + button.frame.size.width / 2.0f, button.center.y);
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         button.center = newLeftCenter;
                     } completion:^(BOOL finished) {
                     }];
}


- (void)animateDeletion:(UIButton *)button withDuration:(CGFloat)duration {
    CGRect frame = CGRectMake(self.frame.origin.x + 0.25 * self.frame.size.width, self.frame.origin.y + 0.25 * self.frame.size.height, button.frame.size.width / 2, button.frame.size.height / 2);
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         button.frame = frame;
                     } completion:^(BOOL finished) {
                    [button removeFromSuperview];
                     }];
}



- (void)showHideHomeButton {
    CGFloat duration = .2;
    CGFloat offset = 20;
    if (_homeButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"homeButton"];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(homeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, image.size.width, image.size.height);
        [[self superview] insertSubview:button belowSubview:self];
        [self animateCreation:button withOffset:offset andDuration:duration];
        _homeButton = button;
    } else {
        UIButton *button = _homeButton;
        [self animateDeletion:button withDuration:duration];
        _homeButton = nil;
    }
}

- (void)showHideMapButton {
    CGFloat duration = .3;
    CGFloat offset = 90;
    if (_mapButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"mapButton"];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(mapButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, image.size.width, image.size.height);
        [[self superview] insertSubview:button belowSubview:self];
        [self animateCreation:button withOffset:offset andDuration:duration];
        _mapButton = button;
    } else {
        UIButton *button = _mapButton;
        [self animateDeletion:button withDuration:duration];
        _mapButton = nil;
    }
}

- (void)showHideChangeFloorButton {
    CGFloat duration = .3;
    CGFloat offset = 90;
    if (_changeFloorButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIImage *image;

        if ([_currentFloor  isEqual: @2]) {
        image = [UIImage imageNamed:@"floor1Button"];
        } else {
        image = [UIImage imageNamed:@"floor2Button"];
        }

        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(changeFloorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, image.size.width, image.size.height);
        [[self superview] insertSubview:button belowSubview:self];
        [self animateCreation:button withOffset:offset andDuration:duration];
        _changeFloorButton = button;
    } else {
        UIButton *button = _changeFloorButton;
        [self animateDeletion:button withDuration:duration];
        _changeFloorButton = nil;
    }
}

- (void)showHideExhibitButton {
    CGFloat duration = .3;
    CGFloat offset = 160;
    if (_exhibitButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"exhibitButton"];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(exhibitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, image.size.width, image.size.height);
        [[self superview] insertSubview:button belowSubview:self];
        [self animateCreation:button withOffset:offset andDuration:duration];
        _exhibitButton = button;
    } else {
        UIButton *button = _exhibitButton;
        [self animateDeletion:button withDuration:duration];
        _exhibitButton = nil;
    }
}

- (void)animateButton {
    if (!_buttonOpened) {
        self.imageView.animationImages = @[[UIImage imageNamed:@"rmButton"], [UIImage imageNamed:@"block"]];
        self.imageView.animationDuration = 0.5;
        self.imageView.animationRepeatCount = 1;
        [self.imageView startAnimating];
        _buttonOpened = YES;
        [self setSelected:NO];
        UIImage *buttonImage = [UIImage imageNamed:@"block"];
        [self setImage:buttonImage forState:UIControlStateNormal];
        [self setSelected:NO];
    } else {
        self.imageView.animationImages = @[[UIImage imageNamed:@"block"], [UIImage imageNamed:@"rmButton"]];
        self.imageView.animationDuration = 0.5;
        self.imageView.animationRepeatCount = 1;
        [self.imageView startAnimating];
        _buttonOpened = NO;
        [self setSelected:NO];
        UIImage *buttonImage = [UIImage imageNamed:@"rmButton"];
        [self setImage:buttonImage forState:UIControlStateNormal];
    }

}

- (void)homeButtonPressed:(UIButton *)sender {
    [self.delegate homeButtonPressed];
}

- (void)mapButtonPressed:(UIButton *)sender {
    [self.delegate mapButtonPressed];
    
}
- (void)changeFloorButtonPressed:(UIButton *)sender {
    [self.delegate changeFloorButtonPressed];
    [self didTouchButton];
}
- (void)exhibitButtonPressed:(UIButton *)sender {
    [self.delegate exhibitButtonPressed];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
