#import "RepositoryCachePlugin.h"
#import <repository_cache/repository_cache-Swift.h>

@implementation RepositoryCachePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRepositoryCachePlugin registerWithRegistrar:registrar];
}
@end
