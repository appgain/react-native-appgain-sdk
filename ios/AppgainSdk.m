#import "AppgainSDK.h"

#import <Appgain/Appgain.h>

@implementation AppgainSDK

RCT_EXPORT_MODULE()

//MARK : init sdk in app
//parameter :-
// appId (String)
// apiKey (String)
// configure (Bool)

// Output : -  callback with two parameter
///   response  as string
///    info dictionary
RCT_EXPORT_METHOD(initAppgainSDK:(NSString *) projectId apiKey:(NSString *) apiKey autoconfig: (BOOL) autoconfig  success: (RCTResponseSenderBlock)success  failure: (RCTResponseErrorBlock)failure)
{
    
    [Appgain initializeAppWithID:projectId andApiKey:apiKey automaticConfiguration:autoconfig whenFinish:^(NSURLResponse * response, NSMutableDictionary * info, NSError* error ) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (response == nil && info == nil && error == nil) {
                success(@[ @"success in init without call api, it is done form api"]);
            }
            else if (error != nil ){
                failure(error);
            }
            else{
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                if(httpResponse.statusCode ==200)
                {
                    success(@[ [NSString stringWithFormat:@"AppgianResponse -- %@ Info result  --%@",response,info]]);
                }
                else{
                    failure([[NSError alloc] initWithDomain:httpResponse.allHeaderFields.description code:httpResponse.statusCode userInfo:info]);
                }
            }
            
        });
    }];
    
}

//Getting userID
//Output  : - callback with userID

RCT_EXPORT_METHOD(getuserId : (RCTResponseSenderBlock)callback )
{
    dispatch_async(dispatch_get_main_queue(), ^{

    callback(@[[Appgain getUserID]]);
    });

}

//deInit app  NO input or output
RCT_EXPORT_METHOD(deInitializeApp)
{
  [Appgain deInitializeApp];
}


// MARK: create smartLink
// Input Parameter
//header (String)
//imageUrl (String)
//linkDescription (String)
//linkName (String)
//slug (String)
//iosPrimary (String)  url string for ios
//iosFallback (String) url string
//AndroidPrimary (String)  url string for android
//AndroidFallback (String)  url string for
//webPrimary (String)  url string for web
//weballback (String)  url string for

// Output : -  callback with two parameter
///   response  as string
///    info dictionary

RCT_EXPORT_METHOD(createSmartLinkWith :(NSString *) header withImage :(NSString *) imageUrl andLinkDesc :(NSString *) linkDescription andLinkName :(NSString *) linkName andSlug:(NSString *) slug forIosTarget :(NSString *)iosPrimary and:(NSString *)iosFallback  forAndroidTarget :(NSString *)AndroidPrimary and:(NSString *)AndroidFallback forWebTarget :(NSString *)webPrimary and:(NSString *)weballback success: (RCTResponseSenderBlock)success  failure: (RCTResponseErrorBlock)failure )
{
    
    TargetPlatform *iosTarget = [[TargetPlatform alloc] initWithPrimary:iosPrimary withFallBack:iosFallback];
    TargetPlatform *androidTarget = [[TargetPlatform alloc] initWithPrimary:AndroidPrimary  withFallBack:AndroidFallback];
    TargetPlatform *webTarget = [[TargetPlatform alloc] initWithPrimary:webPrimary  withFallBack:weballback];


    SmartDeepLink *smartObject = [[SmartDeepLink alloc] initWithHeader:header andImage:imageUrl andDescription:linkDescription andName:linkName iosTarget:iosTarget androidTarget:androidTarget webTarget:webTarget];

    [Appgain CreateSmartLinkWithObject:smartObject whenFinish:^(NSURLResponse *response, NSMutableDictionary *info, NSError* error) {
         dispatch_async(dispatch_get_main_queue(), ^{
                   
                   if (response == nil && info == nil && error == nil) {
                       success(@[ @"success in init without call api, it is done form api"]);
                   }
                   else if (error != nil ){
                       failure(error);
                   }
                   else{
                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                       if(httpResponse.statusCode ==200)
                       {
                           success(@[ [NSString stringWithFormat:@"AppgianResponse -- %@ Info result  --%@",response,info]]);
                       }
                       else{
                           failure([[NSError alloc] initWithDomain:httpResponse.allHeaderFields.description code:httpResponse.statusCode userInfo:info]);
                       }
                   }
                   
               });
    }];
}

//MARK: create match link

// INPUT userID (String) or empty string

// Output : -  callback with two parameter
///   response  as string
///    info dictionary


RCT_EXPORT_METHOD(matchLink: (RCTResponseSenderBlock)success  failure: (RCTResponseErrorBlock)failure)
{
    [Appgain CreateLinkMactcherWithUserID: @"" whenFinish:^(NSURLResponse *response, NSMutableDictionary *info, NSError* error) {
         dispatch_async(dispatch_get_main_queue(), ^{
                  
                  if (response == nil && info == nil && error == nil) {
                      success(@[ @"success in init without call api, it is done form api"]);
                  }
                  else if (error != nil ){
                      failure(error);
                  }
                  else{
                      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                      if(httpResponse.statusCode ==200)
                      {
                          success(@[ [NSString stringWithFormat:@"AppgianResponse -- %@ Info result  --%@",response,info]]);
                      }
                      else{
                          failure([[NSError alloc] initWithDomain:httpResponse.allHeaderFields.description code:httpResponse.statusCode userInfo:info]);
                      }
                  }
                  
              });
    }];
}


//MARK: create landing page
//INput (String)
//header (String)
//LogoUrl (String)
//paragraph (String)
//buttons
//button is array of follow dictionary
//["title":"","iosUrlTarget":"","androidUrlTarget":"","webUrlTarget": ""]

//sliderImagesUrls
//Array of images urls strings.
//socialMediaSetting  typy of dict
//["title" : "", "mediaDescription":"", "imageUrl":""]

//lang (String)
//subscription (String)
//imageUrl (String)
//label (String)
//slug (String)

// Output : -  callback with two parameter
///   response  as string
///    info dictionary


RCT_EXPORT_METHOD(createLandingPageWith :(NSString *) header logo :(NSString *) LogoUrl andParagraph :(NSString *) paragraph andButtons : (NSArray *) buttons  andSliderImages :(NSArray *) sliderImagesUrls andSocialMediaSetting :(NSDictionary *) socialMediaSetting  andLang:(NSString *) lang forWebPushSubscription :(NSString *)subscription withDefaultImageUrl:(NSString *)imageUrl  andLabel :(NSString *)label andSlug:(NSString *)slug success: (RCTResponseSenderBlock)success  failure: (RCTResponseErrorBlock)failure )
{
    
   NSMutableArray *buttonObjects = [NSMutableArray new];
    for (NSMutableDictionary *item in buttons) {
        MobileLandingPageButton *tempObj = [[MobileLandingPageButton alloc] initWithTitle:[item objectForKey:@"title"] iosTarget:[item objectForKey:@"iosUrlTarget"] andAndroid: [item objectForKey:@"androidUrlTarget"] andWeb:[item objectForKey:@"webUrlTarget"]];
        [buttonObjects addObject: tempObj];
    }
    SocialmediaSettings * socailTemp = [[SocialmediaSettings alloc] initWithTitle:[socialMediaSetting objectForKey:@"title"] andDescription:[socialMediaSetting objectForKey:@"mediaDescription"] andImage:[socialMediaSetting objectForKey:@"imageUrl"]];

    MobileLandingPage *tempPage = [[MobileLandingPage alloc] initWithLogo:LogoUrl andHeader:header andParagraph:paragraph withSliderUrlImages:sliderImagesUrls andButtons:buttonObjects andSocialMediaSetting:socailTemp language:lang andSubscription:subscription andimage:imageUrl andlabel:label];

    [Appgain createLandingPageWithObject:tempPage whenFinish:^(NSURLResponse *response, NSMutableDictionary *info, NSError* error) {
             dispatch_async(dispatch_get_main_queue(), ^{
                      
                      if (response == nil && info == nil && error == nil) {
                          success(@[ @"success in init without call api, it is done form api"]);
                      }
                      else if (error != nil ){
                          failure(error);
                      }
                      else{
                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                          if(httpResponse.statusCode ==200)
                          {
                              success(@[ [NSString stringWithFormat:@"AppgianResponse -- %@ Info result  --%@",response,info]]);
                          }
                          else{
                              failure([[NSError alloc] initWithDomain:httpResponse.allHeaderFields.description code:httpResponse.statusCode userInfo:info]);
                          }
                      }
                      
                  });
    }];
}

//MARK: create automator

//trigger (String)
//userId (String)
 
// Output : -  callback with two parameter
///   response  as string
///    info dictionary




RCT_EXPORT_METHOD(fireAutomator :(NSString *) triggerPointName    success: (RCTResponseSenderBlock)success  failure: (RCTResponseErrorBlock)failure )
{
    
    [Appgain CreateAutomatorWithTrigger:triggerPointName andUserId:@""  whenFinish:^(NSURLResponse *response, NSMutableDictionary *info, NSError* error) {
       dispatch_async(dispatch_get_main_queue(), ^{
                   
                   if (response == nil && info == nil && error == nil) {
                       success(@[ @"success in init without call api, it is done form api"]);
                   }
                   else if (error != nil ){
                       failure(error);
                   }
                   else{
                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                       if(httpResponse.statusCode ==200)
                       {
                           success(@[ [NSString stringWithFormat:@"AppgianResponse -- %@ Info result  --%@",response,info]]);
                       }
                       else{
                           failure([[NSError alloc] initWithDomain:httpResponse.allHeaderFields.description code:httpResponse.statusCode userInfo:info]);
                       }
                   }
                   
               });

    }];
}

//MARK: create automator with exta parameter

//trigger (String)
//userId (String)
 //parameters Dictionary of key and value

// Output : -  callback with two parameter
///   response  as string
///    info dictionary



RCT_EXPORT_METHOD(fireAutomator :(NSString *) triggerPointName  personalizationMap:(id) personalizationMap  success: (RCTResponseSenderBlock)success  failure: (RCTResponseErrorBlock)failure)
{
    
    [Appgain CreateAutomatorWithTrigger:triggerPointName andUserId:@""  andParameters: personalizationMap  whenFinish:^(NSURLResponse *response, NSMutableDictionary *info, NSError* error) {
        dispatch_async(dispatch_get_main_queue(), ^{
                  
                  if (response == nil && info == nil && error == nil) {
                      success(@[ @"success in init without call api, it is done form api"]);
                  }
                  else if (error != nil ){
                      failure(error);
                  }
                  else{
                      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                      if(httpResponse.statusCode ==200)
                      {
                          success(@[ [NSString stringWithFormat:@"AppgianResponse -- %@ Info result  --%@",response,info]]);
                      }
                      else{
                          failure([[NSError alloc] initWithDomain:httpResponse.allHeaderFields.description code:httpResponse.statusCode userInfo:info]);
                      }
                  }
                  
              });

    }];
}


//MARK: update user id

//userId (String)
 //parameters Dictionary of key and value

RCT_EXPORT_METHOD(setuserId  :(NSString *) userId )
{
    [Appgain updateUserId:userId];
}


//MARK: logPurchaseForItem

//productName (String)
//currency (String)
//amount (String)


// Output : -  callback with two parameter
///   success bool   as string
///     error



RCT_EXPORT_METHOD(addPurchase :(NSString *) productName curruncy :(NSString *) curruncy amount:(NSString*) amount  success: (RCTResponseSenderBlock)success  failure: (RCTResponseErrorBlock)failure )
{
    
    PurchaseItem *item = [[PurchaseItem alloc] initWithProductName:productName andAmount:amount andCurrency:curruncy];

    [Appgain logPurchaseForItem:item whenFinish:^(BOOL succ, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (succ){
                
                success(@[ @"true"]);
            }
            else{
                failure(error);
            }
        });
    }];
}

//MARK: enableReciveNotification

//enable (String)
//type (String) one of theses values ("appPush","sms","email","webPush")


// Output : -  callback with two parameter
///   success bool   as string
///     error



RCT_EXPORT_METHOD(enableReciveNotification :(BOOL) enable forType :(NSString*) type   success: (RCTResponseSenderBlock)success  failure: (RCTResponseErrorBlock)failure  )
{
    [Appgain enableReciveNotification:enable forType:type whenFinish:^(BOOL succ, NSError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (succ){
                
                success( @[@"true"]);
            }
            else{
                failure(error);
            }
            
        });
    }];
}



//MARK: createNotificationChannelForType

//item (String)
//notificationType (String) one of theses values ("appPush","sms","email","webPush")


// Output : -  callback with two parameter
///   success bool   as string
///     error




RCT_EXPORT_METHOD(addNotificationChannel :(NSString *) notificationType item :(NSString*) item success: (RCTResponseSenderBlock)success  failure: (RCTResponseErrorBlock)failure )
{
    [Appgain createNotificationChannelForType:notificationType andExtraItem:item   whenFinish:^(BOOL succ, NSError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (succ){
                
                success( @[@"true"]);
            }
            else{
                failure(error);
            }
        });
    }];
}

//MARK: loginWithEmail

//email (String)
//password (String)


// Output : -  callback with two parameter
///   user object  as string
///     error



RCT_EXPORT_METHOD(loginWithEmail :(NSString *) email andPassword :(NSString*) password success: (RCTResponseSenderBlock)success  failure: (RCTResponseErrorBlock)failure )
{
    
    [Appgain loginWithEmail:email andPassword:password whenFinish:^(PFUser * user, NSError *error) {

          dispatch_async(dispatch_get_main_queue(), ^{
                  if (error != nil ){
                      
                      failure(error);
                      
                  }
                  else{
                      success(@[user]);
                  }
              });
    }];
    
}


//MARK: loginWithSocailAccountEmail

//userEmail (String)
//userId (String)
// andUserName (String)



// Output : -  callback with two parameter
///   success bool   as string
///     error


RCT_EXPORT_METHOD(loginWithSocailAccountEmail :(NSString *) userEmail andId :(NSString*) userId  andUserName : (NSString *) userName success: (RCTResponseSenderBlock)success  failure: (RCTResponseErrorBlock)failure )
{
    
    [Appgain loginWithSocailAccountEmail:userEmail andId:userId andUserName:userName whenFinish:^(BOOL succ, NSError *error) {
           dispatch_async(dispatch_get_main_queue(), ^{
                if (succ){
                    
                    success( @[@"true"]);
                }
                else{
                    failure(error);
                }
            });
    }];
}


//MARK: signUpWith

//email (String)
//password (String)
// name (String)



// Output : -  callback with two parameter
///   success bool   as string
///     error


RCT_EXPORT_METHOD(initUser :(NSString *) email pass :(NSString*) pass  username : (NSString *) username success: (RCTResponseSenderBlock)success  failure: (RCTResponseErrorBlock)failure)
{
    PFUser *user = [PFUser user];
    user.username = username;
    user.email = email;
    user.password = pass;
    
    [Appgain signUpWithUser:user whenFinish:^(BOOL succ, NSError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (succ){
                
                success( @[@"true"]);
            }
            else{
                failure(error);
            }
        });
    }];
    
    
}



//MARK: skip login no input no output

RCT_EXPORT_METHOD(skipUserLogin  )
{
        [Appgain skipUserLogin];
    
}



//MARK: update user profile
//email (String)
//password (String)
// name (String)

// Output : -  callback with two parameter
///   success bool   as string
///     error




RCT_EXPORT_METHOD(updateUser :(NSString *) email pass :(NSString*) pass  username : (NSString *) username success: (RCTResponseSenderBlock)success  failure: (RCTResponseErrorBlock)failure )
{
    PFUser *user = [PFUser user];
    user.username = username;
    user.email = email;
    user.password = pass;
    
    
    [Appgain updateUserProfileFor:user whenFinish:^(BOOL succ, NSError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (succ){
                
                success( @[@"true"]);
            }
            else{
                failure(error);
            }
        });
    }];
}

//MARK: log event
//type (String)
//action (String)

// Output : -  callback with two parameter
///   response  as string
///    info dictionary

RCT_EXPORT_METHOD(logEvent :(NSString *) type action :(NSString*) action success: (RCTResponseSenderBlock)success  failure: (RCTResponseErrorBlock)failure)
{
    [ Appgain logEventForAction:(NSString *)action andType:(NSString *)type whenFinish:^(NSURLResponse *response, NSMutableDictionary *info,NSError * error){
          dispatch_async(dispatch_get_main_queue(), ^{
                   
                   if (response == nil && info == nil && error == nil) {
                       success(@[ @"success in init without call api, it is done form api"]);
                   }
                   else if (error != nil ){
                       failure(error);
                   }
                   else{
                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                       if(httpResponse.statusCode ==200)
                       {
                           success(@[ [NSString stringWithFormat:@"AppgianResponse -- %@ Info result  --%@",response,info]]);
                       }
                       else{
                           failure([[NSError alloc] initWithDomain:httpResponse.allHeaderFields.description code:httpResponse.statusCode userInfo:info]);
                       }
                   }
                   
               });
    }];
}



@end
