// Copyright 2004-present Facebook. All Rights Reserved.

#import "RCTAppState.h"

#import "RCTAssert.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

static NSString *RCTCurrentAppBackgroundState()
{
  static NSDictionary *states;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    states = @{
      @(UIApplicationStateActive): @"active",
      @(UIApplicationStateBackground): @"background",
      @(UIApplicationStateInactive): @"inactive"
    };
  });

  return states[@([[UIApplication sharedApplication] applicationState])] ?: @"unknown";
}

@implementation RCTAppState
{
  NSString *_lastKnownState;
}

@synthesize bridge = _bridge;

#pragma mark - Lifecycle

- (instancetype)init
{
  if ((self = [super init])) {

    _lastKnownState = RCTCurrentAppBackgroundState();

    for (NSString *name in @[UIApplicationDidBecomeActiveNotification,
                             UIApplicationDidEnterBackgroundNotification,
                             UIApplicationDidFinishLaunchingNotification]) {

      [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(handleAppStateDidChange)
                                                   name:name
                                                 object:nil];
    }
  }
  return self;
}


- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - App Notification Methods

- (void)handleAppStateDidChange
{
  NSString *newState = RCTCurrentAppBackgroundState();
  if (![newState isEqualToString:_lastKnownState]) {
    _lastKnownState = newState;
    [_bridge.eventDispatcher sendDeviceEventWithName:@"appStateDidChange"
                                                body:@{@"app_state": _lastKnownState}];
  }
}

#pragma mark - Public API

/**
 * Get the current background/foreground state of the app
 */
- (void)getCurrentAppState:(RCTResponseSenderBlock)callback
                     error:(__unused RCTResponseSenderBlock)error
{
  RCT_EXPORT();

  callback(@[@{@"app_state": _lastKnownState}]);
}

/**
 * Update the application icon badge number on the home screen
 */
- (void)setApplicationIconBadgeNumber:(NSInteger)number
{
  RCT_EXPORT();

  [UIApplication sharedApplication].applicationIconBadgeNumber = number;
}

/**
 * Get the current application icon badge number on the home screen
 */
- (void)getApplicationIconBadgeNumber:(RCTResponseSenderBlock)callback
{
  RCT_EXPORT();

  callback(@[
    @([UIApplication sharedApplication].applicationIconBadgeNumber)
  ]);
}

@end
