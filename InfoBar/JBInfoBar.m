//
//  JBInfoBar.m
//  InfoBar
//
//  Created by Junior B. on 20.02.11.
//  Copyright 2011 ThinkDiff.ch. All rights reserved.
//

#import "JBInfoBar.h" 

@implementation JBInfoBar

@synthesize isHidden;

- (id)initWithFrame:(CGRect)frame
    backgroundColor:(UIColor *)bColor
          textColor:(UIColor *)tColor
           textFont:(UIFont *)tFont
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        isHidden = YES;
        hiddenCP = CGPointMake(frame.origin.x + frame.size.width / 2.0, frame.origin.y + frame.size.height / 2.0);
        showCP = CGPointMake(frame.origin.x + frame.size.width / 2.0, frame.origin.y - frame.size.height / 2.0);
        
        if (!bColor) {
            [self setBackgroundColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.5]];
        } else {
            [self setBackgroundColor:bColor];
        }
        
        infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [infoLabel setTextAlignment:UITextAlignmentCenter];

        if (!tFont) {
            [infoLabel setFont:[UIFont fontWithName:@"MavenPro" size:14]];
        } else {
            [infoLabel setFont:tFont];
        }
        
        if (!tColor) {
            [infoLabel setTextColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]];
        } else {
            [infoLabel setTextColor:tColor];
        }
        
        [infoLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:infoLabel];
    }
    return self;
}

- (void)setMessage:(NSString *)message {
    if (message != nil) infoLabel.text = message;
}

- (UILabel *)infoLabel {
    return infoLabel;
}

- (void)showBarWithMessage:(NSString *)message {
    [self setMessage:message];
    if (isHidden) {
        [UIView transitionWithView:self duration:0.5
                           options:UIViewAnimationOptionTransitionNone
                        animations:^ { self.center = showCP; }
                        completion:nil];
        isHidden = NO;
    }
}

- (void)hideBarWithMessage:(NSString *)message {
    if (message)
        [self setMessage:message];
    if (!isHidden) {
        [UIView transitionWithView:self duration:1.5
                           options:UIViewAnimationOptionTransitionNone
                        animations:^ { self.center = hiddenCP; }
                        completion:nil];
        isHidden = YES;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [infoLabel release];
    [super dealloc];
}

@end
