//
//  SampleViewController.m
//  ButtonItemSample
//
//  Created by Cory Imdieke on 4/25/13.
//  Copyright (c) 2013 BitSuites, LLC. All rights reserved.
//

#import "SampleViewController.h"
#import "BPBarButtonItem.h"

@interface SampleViewController ()

@end

@implementation SampleViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	self.navigationItem.rightBarButtonItem = [BPBarButtonItem barButtonItemWithStyle:BPBarButtonItemStyleAction title:@"Action" target:nil action:nil];
	self.navigationItem.leftBarButtonItem = [BPBarButtonItem barButtonItemWithStyle:BPBarButtonItemStyleStandard title:@"Standard" target:nil action:nil];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
