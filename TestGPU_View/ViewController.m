//
//  ViewController.m
//  TestGPU_View
//
//  Created by rex on 2019/8/18.
//  Copyright © 2019 rex. All rights reserved.
//

#import "ViewController.h"
#import "GPUView.h"

@interface ViewController ()
{
    GPUView *gpuView;
  
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    gpuView = [GPUView new];
    gpuView.frame = self.view.bounds;
    [self.view addSubview:gpuView];
    [gpuView prepareRender];
}


@end
