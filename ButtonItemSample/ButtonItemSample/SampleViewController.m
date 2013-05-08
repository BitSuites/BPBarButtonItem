//
//  SampleViewController.m
//  ButtonItemSample
//
//  Created by Cory Imdieke on 4/25/13.
//  Copyright (c) 2013 BitSuites, LLC. All rights reserved.
//

#import "SampleViewController.h"


@interface SampleViewController ()

@end

@implementation SampleViewController

- (id)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if(self){
		// Default style
		_buttonStyle = BPBarButtonItemStyleStandardDark;
	}
	return self;
}

- (void)viewDidLoad{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	if(self.buttonStyle == BPBarButtonItemStyleStandardDark)
		self.navigationController.navigationBar.tintColor = [UIColor blackColor];

	// These override the appearance proxy settings we have in the delegate
	self.navigationItem.rightBarButtonItem = [BPBarButtonItem barButtonItemWithStyle:BPBarButtonItemStyleAction title:@"Action" target:self action:@selector(switchStyles)];
	self.navigationItem.leftBarButtonItem = [BPBarButtonItem barButtonItemWithStyle:self.buttonStyle title:@"Standard" target:self action:@selector(switchStyles)];

	[BPBarButtonItem customizeSegmentedControl:(UISegmentedControl *)[self.navigationItem titleView] withStyle:self.buttonStyle];
}

- (void)didReceiveMemoryWarning{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)switchStyles{
	if(self.buttonStyle == BPBarButtonItemStyleStandardDark){
		// Switch to Light
		UINavigationController *sample = [self.storyboard instantiateInitialViewController];
		[(SampleViewController *)[sample topViewController] setButtonStyle:BPBarButtonItemStyleStandardLight];
		[self presentViewController:sample animated:YES completion:nil];
	} else {
		// Switch back to Dark
		[self dismissViewControllerAnimated:YES completion:nil];
	}
}

@end
