//
//  BPBarButtonItem.m
//
//  Created by Cory Imdieke on 4/25/13.
//  Copyright (c) 2013 BitSuites, LLC. All rights reserved.
//

#import "BPBarButtonItem.h"

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

+ (void)customizeBarButtonItem:(UIBarButtonItem *)item withTintColor:(UIColor *)tintColor{
	// nil button item means customize appearance proxy
	if(!item){
		item = [UIBarButtonItem appearance];
	}
	
	[item setBackgroundImage:[self stretchableButtonImageForTintColor:tintColor barMetrics:UIBarMetricsDefault] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	[item setBackgroundImage:[self stretchableButtonImageForTintColor:[self lighterColorFromColor:tintColor modificationAmount:0.1] barMetrics:UIBarMetricsDefault] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
	
	[item setBackgroundImage:[self stretchableButtonImageForTintColor:tintColor barMetrics:UIBarMetricsLandscapePhone] forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
	[item setBackgroundImage:[self stretchableButtonImageForTintColor:[self lighterColorFromColor:tintColor modificationAmount:0.1] barMetrics:UIBarMetricsLandscapePhone] forState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone];
}

+ (UIImage *)stretchableButtonImageForTintColor:(UIColor *)tintColor barMetrics:(UIBarMetrics)metrics{
	CGFloat pixelsWide = 9.0;
	CGFloat pixelsHigh = (metrics == UIBarMetricsDefault) ? 30.0 : 24.0;
	CGFloat drawScale = [[UIScreen mainScreen] scale];
	
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(pixelsWide, pixelsHigh), NO, drawScale);
	CGContextRef bitmapContext = UIGraphicsGetCurrentContext();
	
	[self drawButtonStyleForRect:CGRectMake(0.0, 0.0, pixelsWide, pixelsHigh) inContext:bitmapContext  withTintColor:tintColor];
	
	CGImageRef image = CGBitmapContextCreateImage(bitmapContext);
	UIImage *newImage = [[UIImage alloc] initWithCGImage:image scale:drawScale orientation:UIImageOrientationUp];
	CGImageRelease(image);
	UIGraphicsPopContext();
	
	return [newImage resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 4.0)];
}

+ (void)drawButtonStyleForRect:(CGRect)rect inContext:(CGContextRef)context withTintColor:(UIColor *)tintColor{
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
	
	// Memory Mgmt
	CGGradientRelease(gradient);
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
