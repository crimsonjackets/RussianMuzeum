//  Created by Richard Topchiy on 31/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ZoomSegue.h"

@interface ZoomSegue ()

@property CGRect destStartFrame;

@end


@implementation ZoomSegue



-(void)perform {
    
    //lets use standard iOS 7 scale speed, as it uses about 60x60 icons ASAF
    
    //TODO width height have to be dependent on zoom level. small zoom llevel -> small room size
    //TODO offset by half of the size
    
    self.destStartFrame = CGRectMake(self.originatingPoint.x - 10, self.originatingPoint.y - 10, 20, 20);
    
    CGFloat duration = .5;
    
    UIViewController *source = self.sourceViewController;
    UIViewController *dest = self.destinationViewController;
    
    UIView *sourceView = [source.view snapshotViewAfterScreenUpdates:YES];
    UIView *destView = [dest.view snapshotViewAfterScreenUpdates:YES];

    sourceView.frame = UIScreen.mainScreen.bounds;
    
    destView.frame = self.destStartFrame;
    destView.alpha = 0.0f;
    
    [source.view addSubview:sourceView];
    [source.view addSubview:destView];
    
    [UIView animateWithDuration:duration animations:^{
        destView.alpha = 1.0f;
    }];
    
    [UIView animateWithDuration:duration * 2 animations:^{
        destView.frame = UIScreen.mainScreen.bounds;
        sourceView.frame = [self zoomedRect];
    } completion:^(BOOL finished) {
        [source.navigationController pushViewController:dest animated:NO];
        [destView removeFromSuperview];
        [sourceView removeFromSuperview];
    }];
    
}



- (CGRect)zoomedRect {
    float screenWidth = UIScreen.mainScreen.bounds.size.width;
    float screenHeight = UIScreen.mainScreen.bounds.size.height;
    
    float size = screenWidth / self.destStartFrame.size.width;
    float x = screenWidth/2 - (CGRectGetMidX(self.destStartFrame) * size);
    float y = screenHeight/2 - (CGRectGetMidY(self.destStartFrame) * size);
    
    return CGRectMake(x, y, screenWidth * size, screenHeight * size);
}

@end