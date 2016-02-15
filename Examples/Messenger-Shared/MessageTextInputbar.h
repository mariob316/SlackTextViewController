//
//  MessageTextInputbar.h
//  Messenger
//
//  Created by Ignacio Romero on 2/4/16.
//  Copyright © 2016 Slack Technologies, Inc. All rights reserved.
//

#import "SLKTextInputbar.h"
#import "DZNSegmentedControl.h"

@interface MessageTextInputbar : SLKTextInputbar

@property (nonatomic, strong) DZNSegmentedControl *segmentedControl;

@end
