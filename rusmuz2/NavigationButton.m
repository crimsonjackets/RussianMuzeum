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

@end

@implementation NavigationButton

- (void)awakeFromNib {
    self.buttonOpened = NO;
    
    NSLog(@"Yeah, it self!!!");
    [self addTarget:self action:@selector(didTouchButton) forControlEvents:UIControlEventTouchUpInside];
    UIImage *buttonImage = [UIImage imageNamed:@"rmButton"];
    [self setImage:buttonImage forState:UIControlStateNormal];

    [UIView animateWithDuration:0.5 animations:^{
        NSLog(@"Animation");
    }completion:^(BOOL finished) {
    }];
}


/*
- (void)didTouchButton {
    NSLog(@"YEAH, it works, baby!");
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [self.layer addAnimation:animation forKey:nil];
    
    self.hidden = YES;
}
*/



- (void)didTouchButton {
    [self testAnimate];
    [self createHomeButton];
    [self createMapButton];
    [self createExhibitButton];
}

- (void)testAnimate {
    //self.imageView.transform = CGAffineTransformMakeRotation((200) * M_PI / 180);
    UIView *myView = self.imageView;
    CABasicAnimation* spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    spinAnimation.duration = 0.3f;
    spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    spinAnimation.toValue = [NSNumber numberWithFloat: 2.0 * M_PI * 1.0];
    [myView.layer addAnimation:spinAnimation forKey:@"spinAnimation"];

}

- (void)createHomeButton {
    UIImage *image = [UIImage imageNamed:@"homeButton"];
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton addTarget:self action:@selector(homePressed:) forControlEvents:UIControlEventTouchUpInside];
    [myButton setBackgroundImage:image forState:UIControlStateNormal];
    myButton.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, image.size.width, image.size.height);
    [[self superview] insertSubview:myButton belowSubview:self];

    CGPoint newLeftCenter = CGPointMake( 20.0f + myButton.frame.size.width / 2.0f, myButton.center.y);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2f];
    myButton.center = newLeftCenter;
    [UIView commitAnimations];

}

- (void)createMapButton {
    UIImage *image = [UIImage imageNamed:@"mapButton"];
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton addTarget:self action:@selector(homePressed:) forControlEvents:UIControlEventTouchUpInside];
    [myButton setBackgroundImage:image forState:UIControlStateNormal];
    myButton.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, image.size.width, image.size.height);
    [[self superview] insertSubview:myButton belowSubview:self];
    
    CGPoint newLeftCenter = CGPointMake( 90.0f + myButton.frame.size.width / 2.0f, myButton.center.y);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    myButton.center = newLeftCenter;
    [UIView commitAnimations];
}

- (void)createExhibitButton {
    UIImage *image = [UIImage imageNamed:@"exhibitButton"];
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton addTarget:self action:@selector(homePressed:) forControlEvents:UIControlEventTouchUpInside];
    [myButton setBackgroundImage:image forState:UIControlStateNormal];
    myButton.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, image.size.width, image.size.height);
    [[self superview] insertSubview:myButton belowSubview:self];
    
    CGPoint newLeftCenter = CGPointMake(160.0f + myButton.frame.size.width / 2.0f, myButton.center.y);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4f];
    myButton.center = newLeftCenter;
    [UIView commitAnimations];
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

- (void)homePressed:(UIButton *)sender {
    NSLog(@"home button pressed");
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
