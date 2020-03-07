
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>

#endif
#import <Appgain/Appgain.h>
@interface AppgainSdk : NSObject <RCTBridgeModule>

@end
  
