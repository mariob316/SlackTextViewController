//
//  MessageTextInputbar.m
//  Messenger
//
//  Created by Ignacio Romero on 2/4/16.
//  Copyright © 2016 Slack Technologies, Inc. All rights reserved.
//

#import "MessageTextInputbar.h"

#import "MessageTextView.h"

static CGFloat const kSegmentedControlHeight = 44.0;

@interface MessageTextInputbar () <DZNSegmentedControlDelegate>
@end

@implementation MessageTextInputbar

- (instancetype)initWithTextViewClass:(Class)textViewClass
{
    if (self = [super initWithTextViewClass:textViewClass]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.tintColor = [MessageTextView tintColorForInputType:InputTypeKeyboard];

        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.tintColor = self.tintColor;
        self.textView.layer.borderWidth = 0.0f; // Removes border
        
        self.rightButton.tintColor = self.tintColor;
        
        [self addSubview:self.segmentedControl];
    }
    return self;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];

    [self setupViewConstraints];
}

- (CGFloat)bottomMargin
{
    return kSegmentedControlHeight;
}

- (DZNSegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        _segmentedControl = [[DZNSegmentedControl alloc] initWithItems:[self segmentedControlItems]];
        _segmentedControl.delegate = self;
        _segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
        _segmentedControl.backgroundColor = [UIColor clearColor];
        _segmentedControl.tintColor = self.tintColor;
        _segmentedControl.font = [UIFont fontWithName:@"slack-icons-Regular" size:22.0];
        _segmentedControl.hairlineColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        _segmentedControl.autoAdjustSelectionIndicatorWidth = NO;
        _segmentedControl.selectionIndicatorHeight = 4.0;
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.bouncySelectionIndicator = NO;
        _segmentedControl.animationDuration = 0.4;
        _segmentedControl.showsCount = NO;
        
        [_segmentedControl setTitleColor:[UIColor colorWithRed:178/255.0 green:179/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_segmentedControl setTitleColor:[UIColor colorWithRed:178/255.0 green:179/255.0 blue:180/255.0 alpha:0.5] forState:UIControlStateDisabled];
        
        [_segmentedControl addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
        
        _segmentedControl.selectedSegmentIndex = -1;
    }
    return _segmentedControl;
}

- (NSArray *)segmentedControlItems
{
    return @[@"\uE144", @"\uE011", @"\uE092", @"\uE119", @"\uE038"];
}

- (void)setupViewConstraints
{
    NSDictionary *views = @{@"segmentedControl": self.segmentedControl};
    NSDictionary *metrics = @{@"height": @(kSegmentedControlHeight)};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[segmentedControl]|" options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[segmentedControl(height@750)]|" options:0 metrics:metrics views:views]];
}

- (void)didChangeSegment:(id)sender
{
    NSLog(@"%s",__FUNCTION__);
    
    NSUInteger segment = self.segmentedControl.selectedSegmentIndex;
    MessageTextView *textView = (MessageTextView *)self.textView;
    
    if (![textView isFirstResponder]) {
        [textView becomeFirstResponder];
    }
    
    textView.inputType = segment;
    
    if (textView.inputType == InputTypeCalls) {
        // TODO: Hide the text view and outlets
    }
    
    self.segmentedControl.tintColor = [MessageTextView tintColorForInputType:segment];
}

- (void)beginTextEditing
{
    [super beginTextEditing];
    
    // Disable all other segments
    for (int i = 1; i < sizeof(InputType); i++) {
        [self.segmentedControl setEnabled:NO forSegmentAtIndex:i];
    }
}

- (void)endTextEditing
{
    [super endTextEditing];
    
    // Re-enable all segments
    for (int i = 0; i < sizeof(InputType); i++) {
        [self.segmentedControl setEnabled:YES forSegmentAtIndex:i];
    }
}


#pragma mark - DZNSegmentedControlDelegate Methods

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionTop;
}

- (UIBarPosition)positionForSelectionIndicator:(id<UIBarPositioning>)bar
{
    return UIBarPositionBottom;
}

@end
