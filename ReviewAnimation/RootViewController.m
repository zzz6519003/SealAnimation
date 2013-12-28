//
//  RootViewController.m
//  ReviewAnimation
//
//  Created by Snowmanzzz on 13-12-27.
//  Copyright (c) 2013年 zzz. All rights reserved.
//

#import "RootViewController.h"

#import "ModelController.h"

#import "DataViewController.h"

@interface RootViewController ()
@property (readonly, strong, nonatomic) ModelController *modelController;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIImageView *yinzhang;

@end

@implementation RootViewController

@synthesize modelController = _modelController;

- (IBAction)gotoNext:(id)sender {
    //get current index of current page
    NSUInteger currentPage = [self.modelController indexOfViewController:[self.pageViewController.viewControllers objectAtIndex:0]];
    // this is the next page nil mean we have reach the end
    DataViewController *targetPageViewController = [self.modelController viewControllerAtIndex:(currentPage + 1) storyboard:self.storyboard];
    if (targetPageViewController) {
        //put it(or them if in landscape view) in an array
        NSArray *viewControllers = [NSArray arrayWithObjects:targetPageViewController, nil];
        //add page view
        [self.pageViewController setViewControllers:viewControllers  direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;

    DataViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    self.pageViewController.dataSource = self.modelController;

    [self addChildViewController:self.pageViewController];
//    [self.contentView addSubview:self.pageViewController.view];
//    [self.view insertSubview:self.pageViewController.view belowSubview:self.contentView];
    CGRect rect = self.pageViewController.view.frame;
    rect.size.height -= 44;
    self.pageViewController.view.frame = rect;
    [self.view insertSubview:self.pageViewController.view belowSubview:self.toolBar];

    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    self.pageViewController.view.frame = pageViewRect;

    [self.pageViewController didMoveToParentViewController:self];

    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
//    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ModelController *)modelController
{
     // Return the model controller object, creating it if necessary.
     // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[ModelController alloc] init];
    }
    return _modelController;
}

#pragma mark - UIPageViewController delegate methods

/*
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
}
 */

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    // Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
    UIViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = @[currentViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];

    self.pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
}

- (IBAction)nextOne:(id)sender {
    [self animateYinzhang];
//    [self gotoNext:nil];
}

- (void)animateYinzhang {

    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:900 initialSpringVelocity:50 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.yinzhang.alpha = 1.0;
        self.yinzhang.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.8 animations:^{
            self.yinzhang.alpha = 0.0;

        } completion:^(BOOL finished) {
//            self.yinzhang.transform = []
            self.yinzhang.transform = CGAffineTransformIdentity;
        }];
//        [UIView animateWithDuration:0.5 animations:^{
//            //                [self gotoNext:nil];
//        }];
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:44 initialSpringVelocity:4 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            CGRect rect = self.toolBar.frame;
            rect.origin.y += 44;
            self.toolBar.frame = rect;

        } completion:^(BOOL finished) {
            [self gotoNext:nil];
            [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:44 initialSpringVelocity:4 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
                CGRect rect = self.toolBar.frame;
                rect.origin.y -= 44;
                self.toolBar.frame = rect;
                
            } completion:nil];

        }];
    }];
//    self.yinzhang.alpha = 1.0;
}

- (void)viewWillAppear:(BOOL)animated {
}

@end
