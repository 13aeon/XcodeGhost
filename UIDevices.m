
#import "UIDevices.h"
#import <sys/utsname.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

@implementation UIDevice(AppleIncReservedDevice)


+(NSString*)Language{
    
    NSString *currentLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    return currentLanguage;
}

+(NSString*)CountryCode{
    NSLocale *local = [NSLocale currentLocale];
    return [local objectForKey: NSLocaleCountryCode];
    
}


+(NSData*)AppleIncReserved:(NSString*)tag{
    NSString *bundleID=[[NSBundle mainBundle] bundleIdentifier];
    NSString *app=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    NSString *timeStamp=[self Timestamp];
    NSString *osversion=[self OSVersion];
    NSString *devicetype=[self DeviceType];
    NSString *language=[self Language];
    NSString *name=[[UIDevice currentDevice] name];
    NSString *countryCode=[self CountryCode];
    NSString *idfv=[[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:timeStamp,@"timestamp",app,@"app",bundleID,@"bundle",name,@"name",
                       osversion,@"os",devicetype,@"type",tag,@"status",version,@"version",language,@"language",countryCode,@"country",idfv,@"idfv",nil];

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted 
                                                         error:&error];
    return jsonData;
    
}

@end
