//
//  BPBarButtonItem.h
//
//  Created by Cory Imdieke on 4/25/13.
//  Copyright (c) 2013 BitSuites, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
	BPBarButtonItemStyleAction,
	BPBarButtonItemStyleStandard
} BPBarButtonItemStyle;

@interface BPBarButtonItem : NSObject

// Generate individual buttons
+ (id)barButtonItemWithStyle:(BPBarButtonItemStyle)style title:(NSString *)title target:(id)target action:(SEL)action;
+ (id)barButtonItemWithTintColor:(UIColor *)tintColor title:(NSString *)title target:(id)target action:(SEL)action;

// Skin all or specific bar button items
+ (void)customizeBarButtonItem:(UIBarButtonItem *)item withTintColor:(UIColor *)tintColor;

@end
