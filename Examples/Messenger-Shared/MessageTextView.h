//
//  MessageTextView.h
//  Messenger
//
//  Created by Ignacio Romero Z. on 1/20/15.
//  Copyright (c) 2015 Slack Technologies, Inc. All rights reserved.
//

#import "SLKTextView.h"

typedef NS_ENUM(NSUInteger, InputType) {
    InputTypeDisabled = -1,
    InputTypeKeyboard = 0,
    InputTypeApps,
    InputTypeCalls,
    InputTypeEmoji,
    InputTypeMedia
};

@protocol MessageTextViewDelegate;

@interface MessageTextView : SLKTextView

@property (nonatomic, weak) id<MessageTextViewDelegate,SLKTextViewDelegate>delegate;
@property (nonatomic) InputType inputType;

+ (UIColor *)tintColorForInputType:(InputType)inputType;

@end


@protocol MessageTextViewDelegate <SLKTextViewDelegate>

- (UIInputViewController *)inputViewControllerForType:(InputType)type;

@end