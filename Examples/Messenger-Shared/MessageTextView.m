//
//  MessageTextView.m
//  Messenger
//
//  Created by Ignacio Romero Z. on 1/20/15.
//  Copyright (c) 2015 Slack Technologies, Inc. All rights reserved.
//

#import "MessageTextView.h"

@implementation MessageTextView
@dynamic delegate;

- (instancetype)init
{
    if (self = [super init]) {
        // Do something
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.placeholder = NSLocalizedString(@"Message in #design-team ...", nil);
    self.placeholderColor = [UIColor lightGrayColor];
    self.pastableMediaTypes = SLKPastableMediaTypeAll;
    
    self.layer.borderColor = [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0].CGColor;
}

- (void)setInputType:(InputType)inputType
{
    if (self.inputType == inputType) {
        return;
    }
    
    _inputType = inputType;
    
    [super reloadInputViews];
}

+ (UIColor *)tintColorForInputType:(InputType)inputType
{
    switch (inputType) {
        case InputTypeKeyboard:     return [UIColor colorWithRed:64/255.0 green:161/255.0 blue:222/255.0 alpha:1.0];
        case InputTypeApps:         return [UIColor colorWithRed:225/255.0 green:22/255.0 blue:101/255.0 alpha:1.0];
        case InputTypeCalls:        return [UIColor colorWithRed:90/255.0 green:181/255.0 blue:140/255.0 alpha:1.0];
        case InputTypeEmoji:        return [UIColor colorWithRed:233/255.0 green:168/255.0 blue:35/255.0 alpha:1.0];
        case InputTypeMedia:        return [UIColor colorWithRed:233/255.0 green:79/255.0 blue:95/255.0 alpha:1.0];
        default:                    return [UIColor blackColor];
    }
}

- (UIInputViewController *)inputViewController
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputViewControllerForType:)]) {
        return [self.delegate inputViewControllerForType:self.inputType];
    }

    return nil;
}

@end
