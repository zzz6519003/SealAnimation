//
//  ModelController.h
//  ReviewAnimation
//
//  Created by Snowmanzzz on 13-12-27.
//  Copyright (c) 2013年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end
