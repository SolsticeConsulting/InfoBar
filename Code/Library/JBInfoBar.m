//
//  JBInfoBar.m
//  InfoBar
//
//  Created by Junior B. on 20.02.11.
//  Copyright 2011 ThinkDiff.ch. All rights reserved.
//

#import "JBInfoBar.h"

#define kDefaultFontName	@"MavenPro"
#define kDefaultFontSize	14

#define kDefaultBackgroundColor	[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.5]
#define kDefaultTextColor		[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]

#define kDefaultHideAnimationDelay		0.0f
#define kDefaultHideAnimationDuration	1.5f
#define kDefaultShowAnimationDuration	0.5f


@interface JBInfoBar ()

- (void) prepareCenterPoints;
- (void) prepareInfoLabel;
- (void) prepareDefaultTimings;

@end


@implementation JBInfoBar

@synthesize visible;
@synthesize hideAnimationDelay;
@synthesize hideAnimationDuration;
@synthesize showAnimationDuration;


#pragma Public Action Methods

- (void)showBarWithMessage:(NSString *)_message {
    self.message = _message;
	
    if(visible)
		return;
	
	[self setHidden:NO];
	[UIView transitionWithView:self duration:showAnimationDuration
					   options:UIViewAnimationOptionTransitionNone
					animations:^ {
						self.center = showCP;
					}
					completion:nil];
	visible = YES;
}

- (void)hideBarWithMessage:(NSString *)_message {
    self.message = _message;
	
    if(!visible)
		return;
	
	[UIView animateWithDuration:hideAnimationDuration
						  delay:hideAnimationDelay
						options:UIViewAnimationOptionTransitionNone
					 animations:^ {
						 self.center = hiddenCP;
					 }
					 completion:^(BOOL finished) {
						 [self setHidden:YES];
					 }];
	visible = NO;
}

- (void)hideBarImmediately {
    if(!visible)
		return;
	
	self.center = hiddenCP;
	[self setHidden:YES];
	visible = NO;
}

#pragma mark Property Accessors

- (void)setMessage:(NSString *)_message {
	infoLabel.text = _message;
}

- (NSString*)message {
	return infoLabel.text;
}

- (void) setTextColor:(UIColor *)textColor {
	infoLabel.textColor = textColor;
}

- (UIColor*) textColor {
	return infoLabel.textColor;
}

- (void) setTextFont:(UIFont *)textFont {
	infoLabel.font = textFont;
}

- (UIFont*) textFont {
	return infoLabel.font;
}

- (UILabel *)infoLabel {
    return infoLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
 */

#pragma mark Instance Lifecycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        visible = NO;
		
		[self prepareCenterPoints];
		[self prepareInfoLabel];
		
		self.backgroundColor = kDefaultBackgroundColor;
		self.hidden = YES;
        
		[self prepareDefaultTimings];
    }
    return self;
}

- (void) prepareCenterPoints {
	double centerX = self.frame.origin.x + self.frame.size.width / 2.0;
	double hiddenCenterY = self.frame.origin.y + self.frame.size.height / 2.0;
	double shownCenterY = self.frame.origin.y - self.frame.size.height / 2.0;
	
	hiddenCP = CGPointMake(centerX, hiddenCenterY);
	showCP = CGPointMake(centerX, shownCenterY);
}

- (void) prepareInfoLabel {
	infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	
	infoLabel.textAlignment = UITextAlignmentCenter;
	infoLabel.font = [UIFont fontWithName:kDefaultFontName size:kDefaultFontSize];
	
	infoLabel.textColor = kDefaultTextColor;
	infoLabel.backgroundColor = [UIColor clearColor];
	
	[self addSubview:infoLabel];
}

- (void) prepareDefaultTimings {
	hideAnimationDelay = kDefaultHideAnimationDelay;
	hideAnimationDuration = kDefaultHideAnimationDuration;
	showAnimationDuration = kDefaultShowAnimationDuration;
}

- (void)dealloc {
    [infoLabel release];
	
    [super dealloc];
}

@end
