
#import "AppgainSdk.h"
#import "RCTLog.h"
#import "Appgain.h"
@implementation AppgainSdk

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(initializeAppWithID:(NSString *) appId andApiKey:(NSString *) apiKey automaticConfiguration: (BOOL) configure  whenFinish: (RCTResponseSenderBlock)callback)
{
    [Appgain initializeAppWithID:appId andApiKey:apiKey automaticConfiguration:configure whenFinish:^(NSURLResponse * response, NSMutableDictionary * info) {
        
        callback(@[response, info]);
    }];
}

RCT_EXPORT_METHOD(deInitializeApp)
{
    [Appgain deInitializeApp];
}


RCT_EXPORT_METHOD(createSmartLinkWith :(NSString *) header withImage :(NSString *) imageUrl andLinkDesc :(NSString *) linkDescription andLinkName :(NSString *) linkName andSlug:(NSString *) slug forIosTarget :(NSString *)iosPrimary and:(NSString *)iosFallback  forAndroidTarget :(NSString *)AndroidPrimary and:(NSString *)AndroidFallback forWebTarget :(NSString *)webPrimary and:(NSString *)weballback whenFinish: (RCTResponseSenderBlock)callback )
{
    
    TargetPlatform *iosTarget = [[TargetPlatform alloc] initWithPrimary:iosPrimary withFallBack:iosFallback];
    TargetPlatform *androidTarget = [[TargetPlatform alloc] initWithPrimary:AndroidPrimary  withFallBack:AndroidFallback];
    TargetPlatform *webTarget = [[TargetPlatform alloc] initWithPrimary:webPrimary  withFallBack:weballback];
    
    
    SmartDeepLink *smartObject = [[SmartDeepLink alloc] initWithHeader:header andImage:imageUrl andDescription:linkDescription andName:linkName iosTarget:iosTarget androidTarget:androidTarget webTarget:webTarget];
    
    [Appgain CreateSmartLinkWithObject:smartObject whenFinish:^(NSURLResponse *response, NSMutableDictionary *info) {
        callback(@[response, info]);
    }];
}

RCT_EXPORT_METHOD(createLinkMactcherWithUserID:(NSString *)  userId  whenFinish: (RCTResponseSenderBlock)callback)
{
    [Appgain CreateLinkMactcherWithUserID: userId whenFinish:^(NSURLResponse *response, NSMutableDictionary *info) {
        callback(@[response, info]);
        
    }];
}

//button is array of dictionary
//["title":"","iosUrlTarget":"","androidUrlTarget":"","webUrlTarget": ""]

//socail media dictionary
//["title" : "", "mediaDescription":"", "imageUrl":""]

RCT_EXPORT_METHOD(createLandingPageWith :(NSString *) header logo :(NSString *) LogoUrl andParagraph :(NSString *) paragraph andButtons : (NSArray *) buttons  andSliderImages :(NSArray *) sliderImagesUrls andSocialMediaSetting :(NSDictionary *) socialMediaSetting  andLang:(NSString *) lang forWebPushSubscription :(NSString *)subscription withDefaultImageUrl:(NSString *)imageUrl  andLabel :(NSString *)label andSlug:(NSString *)slug  whenFinish: (RCTResponseSenderBlock)callback )
{
    
    NSMutableArray *buttonObjects = [NSMutableArray new];
    for (NSMutableDictionary *item in buttons) {
        MobileLandingPageButton *tempObj = [[MobileLandingPageButton alloc] initWithTitle:[item objectForKey:@"title"] iosTarget:[item objectForKey:@"iosUrlTarget"] andAndroid: [item objectForKey:@"androidUrlTarget"] andWeb:[item objectForKey:@"webUrlTarget"]];
        [buttonObjects addObject: tempObj];
    }
    SocialmediaSettings * socailTemp = [[SocialmediaSettings alloc] initWithTitle:[socialMediaSetting objectForKey:@"title"] andDescription:[socialMediaSetting objectForKey:@"mediaDescription"] andImage:[socialMediaSetting objectForKey:@"imageUrl"]];
    
    MobileLandingPage *tempPage = [[MobileLandingPage alloc] initWithLogo:LogoUrl andHeader:header andParagraph:paragraph withSliderUrlImages:sliderImagesUrls andButtons:buttonObjects andSocialMediaSetting:socailTemp language:lang andSubscription:subscription andimage:imageUrl andlabel:label];
    
    [Appgain createLandingPageWithObject:tempPage whenFinish:^(NSURLResponse *response, NSMutableDictionary *info) {
        callback(@[response, info]);
    }];
}

RCT_EXPORT_METHOD(createAutomatorWithTrigger :(NSString *) trigger andUserId :(NSString *) userId  whenFinish: (RCTResponseSenderBlock)callback )
{
    
    [Appgain CreateAutomatorWithTrigger:trigger andUserId:userId  whenFinish:^(NSURLResponse *response, NSMutableDictionary *info) {
        callback(@[response, info]);
    }];
}
RCT_EXPORT_METHOD(createAutomatorWithTrigger :(NSString *) trigger andUserId :(NSString *) userId andParameters:(NSMutableDictionary*) parameters  whenFinish: (RCTResponseSenderBlock)callback )
{
    
    [Appgain CreateAutomatorWithTrigger:trigger andUserId:userId  andParameters: parameters  whenFinish:^(NSURLResponse *response, NSMutableDictionary *info) {
        callback(@[response, info]);
    }];
}

RCT_EXPORT_METHOD(updateUserId  :(NSString *) userId )
{
    [Appgain updateUserId:userId];
}


RCT_EXPORT_METHOD(createUserID )
{
    [Appgain createUserID];
}


RCT_EXPORT_METHOD(logPurchaseForItem :(NSString *) productName andCurrency :(NSString *) currency andAmount:(NSString*) amount  whenFinish: (RCTResponseSenderBlock)callback )
{
    
    PurchaseItem *item = [[PurchaseItem alloc] initWithProductName:productName andAmount:amount andCurrency:currency];
    
    [Appgain logPurchaseForItem:item whenFinish:^(BOOL success, NSError *error) {
        callback(@[ success ? @"true" : @"false", error.description]);
    }];
}

//"appPush","sms","email","webPush";
RCT_EXPORT_METHOD(enableReciveNotification :(BOOL)enable forType :(NSString*) type  whenFinish: (RCTResponseSenderBlock)callback )
{
    [Appgain enableReciveNotification:enable forType:type whenFinish:^(BOOL success, NSError * error) {
        callback(@[ success ? @"true" : @"false", error.description]);
    }];
}

RCT_EXPORT_METHOD(createNotificationChannelForType :(NSString *) notificationType andExtraItem :(NSString*) item whenFinish: (RCTResponseSenderBlock)callback )
{
    [Appgain createNotificationChannelForType:notificationType andExtraItem:item   whenFinish:^(BOOL success, NSError * error) {
        callback(@[ success ? @"true" : @"false", error.description]);
    }];
}
RCT_EXPORT_METHOD(loginWithEmail :(NSString *) email andPassword :(NSString*) password whenFinish: (RCTResponseSenderBlock)callback )
{
    
    [Appgain loginWithEmail:email andPassword:password whenFinish:^(PFUser * user, NSError *error) {
        
        callback(@[ user.description, error.description]);
        
    }];
    
}

RCT_EXPORT_METHOD(loginWithSocailAccountEmail :(NSString *) userEmail andId :(NSString*) userId  andUserName : (NSString *) userName whenFinish: (RCTResponseSenderBlock)callback )
{
    
    [Appgain loginWithSocailAccountEmail:userEmail andId:userId andUserName:userName whenFinish:^(BOOL success, NSError *error) {
        callback(@[ success ? @"true" : @"false", error.description]);
    }];
}

RCT_EXPORT_METHOD(signUpWith :(NSString *) email andId :(NSString*) password  andFullName : (NSString *) name whenFinish: (RCTResponseSenderBlock)callback )
{
    PFUser *user = [PFUser user];
    user.username = name;
    user.email = email;
    user.password = password;
    
    [Appgain signUpWithUser:user whenFinish:^(BOOL success, NSError * error) {
        callback(@[ success ? @"true" : @"false", error.description]);
    }];
}

RCT_EXPORT_METHOD(skipUserLogin  )
{
    
    [Appgain skipUserLogin];
    
}

@end

