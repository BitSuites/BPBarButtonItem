//
//  BPBarButtonItem.m
//
//  Created by Cory Imdieke on 4/25/13.
//  Copyright (c) 2013 BitSuites, LLC. All rights reserved.
//

#import "BPBarButtonItem.h"


typedef enum : NSInteger {
	BPBarButtonItemTypeStandard,
	BPBarButtonItemTypeBack
} BPBarButtonItemType;

#define kActionColor [UIColor colorWithRed:54.0/255.0 green:139.0/255.0 blue:229/255.0 alpha:1.0]
#define kStandardDarkColor [UIColor colorWithWhite:0.25 alpha:1.0]
#define kStandardLightColor [UIColor colorWithRed:0.440 green:0.525 blue:0.673 alpha:1.000]

@implementation BPBarButtonItem

+ (id)barButtonItemWithStyle:(BPBarButtonItemStyle)style title:(NSString *)title target:(id)target action:(SEL)action{
	if(style == BPBarButtonItemStyleAction)
		return [self barButtonItemWithTintColor:kActionColor title:title target:target action:action];
	else if(style == BPBarButtonItemStyleStandardDark)
		return [self barButtonItemWithTintColor:kStandardDarkColor title:title target:target action:action];
	else if(style == BPBarButtonItemStyleStandardLight)
		return [self barButtonItemWithTintColor:kStandardLightColor title:title target:target action:action];

	return nil;
}

+ (id)barButtonItemWithTintColor:(UIColor *)tintColor title:(NSString *)title target:(id)target action:(SEL)action{
	UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:target action:action];
	[self customizeBarButtonItem:item withTintColor:tintColor];

	return item;
}

+ (void)customizeBarButtonItem:(UIBarButtonItem *)item withStyle:(BPBarButtonItemStyle)style{
	if(style == BPBarButtonItemStyleAction)
		[self customizeBarButtonItem:item withTintColor:kActionColor];
	else if(style == BPBarButtonItemStyleStandardDark)
		[self customizeBarButtonItem:item withTintColor:kStandardDarkColor];
	else if(style == BPBarButtonItemStyleStandardLight)
		[self customizeBarButtonItem:item withTintColor:kStandardLightColor];
}

+ (void)customizeBarButtonItem:(UIBarButtonItem *)item withTintColor:(UIColor *)tintColor{
	// nil button item means customize appearance proxy
	if(!item){
		item = [UIBarButtonItem appearance];
	}

	// Portrait Normal Buttons
	[item setBackgroundImage:[self stretchableButtonImageForTintColor:tintColor barMetrics:UIBarMetricsDefault forType:BPBarButtonItemTypeStandard] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	[item setBackgroundImage:[self stretchableButtonImageForTintColor:[self lighterColorFromColor:tintColor modificationAmount:0.1] barMetrics:UIBarMetricsDefault forType:BPBarButtonItemTypeStandard] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];

	// Portrait Back Buttons
	[item setBackButtonBackgroundImage:[self stretchableButtonImageForTintColor:tintColor barMetrics:UIBarMetricsDefault forType:BPBarButtonItemTypeBack] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	[item setBackButtonBackgroundImage:[self stretchableButtonImageForTintColor:[self lighterColorFromColor:tintColor modificationAmount:0.1] barMetrics:UIBarMetricsDefault forType:BPBarButtonItemTypeBack] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
	[item setBackButtonTitlePositionAdjustment:UIOffsetMake(-1.5, 0.0) forBarMetrics:UIBarMetricsDefault];

	// Landscape Normal Buttons
	[item setBackgroundImage:[self stretchableButtonImageForTintColor:tintColor barMetrics:UIBarMetricsLandscapePhone forType:BPBarButtonItemTypeStandard] forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
	[item setBackgroundImage:[self stretchableButtonImageForTintColor:[self lighterColorFromColor:tintColor modificationAmount:0.1] barMetrics:UIBarMetricsLandscapePhone forType:BPBarButtonItemTypeStandard] forState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone];

	// Landscape Back Buttons
	[item setBackButtonBackgroundImage:[self stretchableButtonImageForTintColor:tintColor barMetrics:UIBarMetricsLandscapePhone forType:BPBarButtonItemTypeBack] forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
	[item setBackButtonBackgroundImage:[self stretchableButtonImageForTintColor:[self lighterColorFromColor:tintColor modificationAmount:0.1] barMetrics:UIBarMetricsLandscapePhone forType:BPBarButtonItemTypeBack] forState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone];
	[item setBackButtonTitlePositionAdjustment:UIOffsetMake(-2.0, 0.0) forBarMetrics:UIBarMetricsLandscapePhone];
}

+ (void)customizeSegmentedControl:(UISegmentedControl *)segmentedControl withStyle:(BPBarButtonItemStyle)style{
	if(style == BPBarButtonItemStyleAction)
		[self customizeSegmentedControl:segmentedControl withTintColor:kActionColor];
	else if(style == BPBarButtonItemStyleStandardDark)
		[self customizeSegmentedControl:segmentedControl withTintColor:kStandardDarkColor];
	else if(style == BPBarButtonItemStyleStandardLight)
		[self customizeSegmentedControl:segmentedControl withTintColor:kStandardLightColor];
}

+ (void)customizeSegmentedControl:(UISegmentedControl *)segmentedControl withTintColor:(UIColor *)tintColor{
	// nil segmented control means customize appearance proxy
	if(!segmentedControl){
		segmentedControl = [UISegmentedControl appearance];
	}

	// Portrait Segmented Controls
	[segmentedControl setBackgroundImage:[self stretchableButtonImageForTintColor:tintColor barMetrics:UIBarMetricsDefault forType:BPBarButtonItemTypeStandard] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	[segmentedControl setBackgroundImage:[self stretchableButtonImageForTintColor:[self lighterColorFromColor:tintColor modificationAmount:0.1] barMetrics:UIBarMetricsDefault forType:BPBarButtonItemTypeStandard] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
	[segmentedControl setBackgroundImage:[self stretchableButtonImageForTintColor:[self lighterColorFromColor:tintColor modificationAmount:0.1] barMetrics:UIBarMetricsDefault forType:BPBarButtonItemTypeStandard] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
	[segmentedControl setDividerImage:[self segmentedControlDividerImageForTintColor:tintColor barMetrics:UIBarMetricsDefault] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

	// Landscape Segmented Controls
	[segmentedControl setBackgroundImage:[self stretchableButtonImageForTintColor:tintColor barMetrics:UIBarMetricsLandscapePhone forType:BPBarButtonItemTypeStandard] forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
	[segmentedControl setBackgroundImage:[self stretchableButtonImageForTintColor:[self lighterColorFromColor:tintColor modificationAmount:0.1] barMetrics:UIBarMetricsLandscapePhone forType:BPBarButtonItemTypeStandard] forState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone];
	[segmentedControl setBackgroundImage:[self stretchableButtonImageForTintColor:[self lighterColorFromColor:tintColor modificationAmount:0.1] barMetrics:UIBarMetricsLandscapePhone forType:BPBarButtonItemTypeStandard] forState:UIControlStateSelected barMetrics:UIBarMetricsLandscapePhone];
	[segmentedControl setDividerImage:[self segmentedControlDividerImageForTintColor:tintColor barMetrics:UIBarMetricsLandscapePhone] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
}

+ (UIImage *)stretchableButtonImageForTintColor:(UIColor *)tintColor barMetrics:(UIBarMetrics)metrics forType:(BPBarButtonItemType)type{
	CGFloat pixelsWide = (type == BPBarButtonItemTypeStandard) ? 9.0 : 23.0;
	CGFloat pixelsHigh = (metrics == UIBarMetricsDefault) ? 30.0 : 24.0;
	CGFloat drawScale = [[UIScreen mainScreen] scale];

	UIGraphicsBeginImageContextWithOptions(CGSizeMake(pixelsWide, pixelsHigh), NO, drawScale);
	CGContextRef bitmapContext = UIGraphicsGetCurrentContext();

	[self drawButtonStyleForRect:CGRectMake(0.0, 0.0, pixelsWide, pixelsHigh) inContext:bitmapContext withTintColor:tintColor forType:type];

	CGImageRef image = CGBitmapContextCreateImage(bitmapContext);
	UIImage *newImage = [[UIImage alloc] initWithCGImage:image scale:drawScale orientation:UIImageOrientationUp];
	CGImageRelease(image);
	UIGraphicsPopContext();

	// Insets are a bit different for standard and back buttons for the arrow
	UIEdgeInsets insets = (type == BPBarButtonItemTypeStandard) ? UIEdgeInsetsMake(0.0, 4.0, 0.0, 4.0) : UIEdgeInsetsMake(0.0, 15.0, 0.0, 6.0);

	return [newImage resizableImageWithCapInsets:insets];
}

+ (UIImage *)segmentedControlDividerImageForTintColor:(UIColor *)tintColor barMetrics:(UIBarMetrics)metrics{
	CGFloat pixelsWide = 1.0;
	CGFloat pixelsHigh = (metrics == UIBarMetricsDefault) ? 30.0 : 24.0;
	CGFloat drawScale = [[UIScreen mainScreen] scale];

	UIGraphicsBeginImageContextWithOptions(CGSizeMake(pixelsWide, pixelsHigh), NO, drawScale);
	CGContextRef bitmapContext = UIGraphicsGetCurrentContext();

	[self drawSegmentedControlDividerStyleForRect:CGRectMake(0.0, 0.0, pixelsWide, pixelsHigh) inContext:bitmapContext withTintColor:tintColor];

	CGImageRef image = CGBitmapContextCreateImage(bitmapContext);
	UIImage *newImage = [[UIImage alloc] initWithCGImage:image scale:drawScale orientation:UIImageOrientationUp];
	CGImageRelease(image);
	UIGraphicsPopContext();

	return newImage;
}

+ (void)drawButtonStyleForRect:(CGRect)rect inContext:(CGContextRef)context withTintColor:(UIColor *)tintColor forType:(BPBarButtonItemType)type{
	// RGB Space
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

	// Colors
	UIColor *strokeColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
	UIColor *bottomShadowColor = [[UIColor whiteColor] colorWithAlphaComponent:0.190];
	UIColor *topGradientColor = [self lighterColorFromColor:tintColor modificationAmount:0.1];
	UIColor *bottomGradientColor = [self darkerColorFromColor:tintColor modificationAmount:0.1];

	// Button Fill Gradient
	CGFloat stopLocations[] = {0.0, 1.0};
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)topGradientColor.CGColor, (id)bottomGradientColor.CGColor], stopLocations);

	// Button Shadow Values
	CGSize bottomShadowOffset = CGSizeMake(0.0, 1.0);
	CGFloat bottomShadowBlurRadius = 0.0;

	if(type == BPBarButtonItemTypeStandard){
		// Size Values
		CGRect buttonRect = CGRectMake(rect.origin.x + 1.0, rect.origin.y + 1.0, rect.size.width - 2.0, rect.size.height - 3.0);
		CGFloat buttonCornerRadius = 4.5;

		// Button Drawing
		UIBezierPath *buttonPath = [UIBezierPath bezierPathWithRoundedRect:buttonRect cornerRadius:buttonCornerRadius];
		CGContextSaveGState(context);
		[buttonPath addClip];
		CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(0.0, buttonRect.size.height + 1.0), 0);
		CGContextRestoreGState(context);
		CGContextSaveGState(context);
		CGContextSetShadowWithColor(context, bottomShadowOffset, bottomShadowBlurRadius, bottomShadowColor.CGColor);
		[strokeColor setStroke];
		buttonPath.lineWidth = 1.0;
		[buttonPath stroke];
		CGContextRestoreGState(context);
	} else if(type == BPBarButtonItemTypeBack){
		// Size Values
		CGRect buttonRect = CGRectMake(rect.origin.x + 1.0, rect.origin.y + 1.0, rect.size.width - 2.0, rect.size.height - 3.0);
		CGFloat buttonPoint = (rect.size.height / 3.0) + 0.5;

		// Back Button Drawing
		UIBezierPath *bezierPath = [UIBezierPath bezierPath];
		[bezierPath moveToPoint:CGPointMake(CGRectGetMaxX(buttonRect), CGRectGetMinY(buttonRect) + 5)];
		[bezierPath addLineToPoint:CGPointMake(CGRectGetMaxX(buttonRect), CGRectGetMaxY(buttonRect) - 5)];
		[bezierPath addCurveToPoint:CGPointMake(CGRectGetMaxX(buttonRect) - 5, CGRectGetMaxY(buttonRect)) controlPoint1:CGPointMake(CGRectGetMaxX(buttonRect), CGRectGetMaxY(buttonRect) - 2.24) controlPoint2:CGPointMake(CGRectGetMaxX(buttonRect) - 2.24, CGRectGetMaxY(buttonRect))];
		[bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(buttonRect) + buttonPoint, CGRectGetMaxY(buttonRect))];
		[bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(buttonRect), CGRectGetMinY(buttonRect) + 0.50000 * CGRectGetHeight(buttonRect))];
		[bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(buttonRect) + buttonPoint, CGRectGetMinY(buttonRect))];
		[bezierPath addLineToPoint:CGPointMake(CGRectGetMaxX(buttonRect) - 5, CGRectGetMinY(buttonRect))];
		[bezierPath addCurveToPoint:CGPointMake(CGRectGetMaxX(buttonRect), CGRectGetMinY(buttonRect) + 5) controlPoint1:CGPointMake(CGRectGetMaxX(buttonRect) - 2.24, CGRectGetMinY(buttonRect)) controlPoint2:CGPointMake(CGRectGetMaxX(buttonRect), CGRectGetMinY(buttonRect) + 2.24)];
		[bezierPath closePath];
		CGContextSaveGState(context);
		[bezierPath addClip];
		CGRect bezierBounds = CGPathGetPathBoundingBox(bezierPath.CGPath);
		CGContextDrawLinearGradient(context, gradient,
				CGPointMake(CGRectGetMidX(bezierBounds), CGRectGetMinY(bezierBounds)),
				CGPointMake(CGRectGetMidX(bezierBounds), CGRectGetMaxY(bezierBounds)),
				0);
		CGContextRestoreGState(context);
		CGContextSaveGState(context);
		CGContextSetShadowWithColor(context, bottomShadowOffset, bottomShadowBlurRadius, bottomShadowColor.CGColor);
		[strokeColor setStroke];
		bezierPath.lineWidth = 1;
		[bezierPath stroke];
		CGContextRestoreGState(context);
	}

	// Memory Mgmt
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorSpace);
}

+ (void)drawSegmentedControlDividerStyleForRect:(CGRect)rect inContext:(CGContextRef)context withTintColor:(UIColor *)tintColor{
	// RGB Space
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

	// Colors
	UIColor *strokeColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
	UIColor *bottomShadowColor = [[UIColor whiteColor] colorWithAlphaComponent:0.190];

	// Divider Shadow Values
	CGSize bottomShadowOffset = CGSizeMake(0.0, 1.0);
	CGFloat bottomShadowBlurRadius = 0.0;

	// Size Values
	CGRect dividerRect = CGRectMake(rect.origin.x, rect.origin.y + 1.0, rect.size.width, rect.size.height - 3.0);

	// Divider Drawing
	UIBezierPath *dividerPath = [UIBezierPath bezierPathWithRect:dividerRect];
	CGContextSaveGState(context);
	CGContextSetShadowWithColor(context, bottomShadowOffset, bottomShadowBlurRadius, bottomShadowColor.CGColor);
	[strokeColor setStroke];
	dividerPath.lineWidth = 1.0;
	[dividerPath stroke];
	CGContextRestoreGState(context);

	// Memory Mgmt
	CGColorSpaceRelease(colorSpace);
}

+ (UIColor *)darkerColorFromColor:(UIColor *)baseColor modificationAmount:(CGFloat)amount{
	float h, s, b, a, r, g, w;
	if([baseColor getRed:&r green:&g blue:&b alpha:&a]){
		return [UIColor colorWithRed:MAX(r - amount, 0.0)
							   green:MAX(g - amount, 0.0)
								blue:MAX(b - amount, 0.0)
							   alpha:a];
	} else if([baseColor getHue:&h saturation:&s brightness:&b alpha:&a]){
		return [UIColor colorWithHue:h
						  saturation:s
						  brightness:b * (1.0 - (amount * 2.0))
							   alpha:a];
	} else if([baseColor getWhite:&w alpha:&a]){
		return [UIColor colorWithWhite:MAX(w - amount, 0.0)
								 alpha:a];
	}

	return nil;
}

+ (UIColor *)lighterColorFromColor:(UIColor *)baseColor modificationAmount:(CGFloat)amount{
	float h, s, b, a, r, g, w;
	if([baseColor getRed:&r green:&g blue:&b alpha:&a]){
		return [UIColor colorWithRed:MIN(r + amount, 1.0)
							   green:MIN(g + amount, 1.0)
								blue:MIN(b + amount, 1.0)
							   alpha:a];
	} else if([baseColor getHue:&h saturation:&s brightness:&b alpha:&a]){
		return [UIColor colorWithHue:h
						  saturation:s
						  brightness:MIN(b * (1.0 + amount), 1.0)
							   alpha:a];
	} else if([baseColor getWhite:&w alpha:&a]){
		return [UIColor colorWithWhite:MAX(w + amount, 0.0)
								 alpha:a];
	}
	return nil;
}

@end
