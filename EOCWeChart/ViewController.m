//
//  ViewController.m
//  EOCWeChart
//
//  Created by leo on 2018/5/30.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "ViewController.h"
#import "EOCFadeView.h"

@interface ViewController ()

@property (strong, nonatomic) EOCFadeView *fadeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (EOCFadeView *)fadeView {
    [_fadeView removeFromSuperview];
    _fadeView = [EOCFadeView fadeWithController:self];
    _fadeView.userInteractionEnabled = false;
    [[UIApplication sharedApplication].keyWindow addSubview:_fadeView];
    return _fadeView;
}

- (IBAction)action:(id)sender {
    [self.fadeView animateFrom:self.view.bounds animateTo:CGRectMake(310, 480, 60, 60)];
    [self.navigationController popViewControllerAnimated:false];
}


@end
