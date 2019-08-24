//
//  GPUView.h
//  TestGPU_View
//
//  Created by rex on 2019/8/18.
//  Copyright © 2019 rex. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPUView : UIView
{
    CADisplayLink * displayLink;
    CAShapeLayer * drawingLayer;
}
- (void)prepareRender;
@end

NS_ASSUME_NONNULL_END
