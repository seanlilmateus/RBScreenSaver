//
//  RBScreenSaverView.m
//  RBScreenSaver
//
//  Created by Sean Mateus on 26.03.12.
//
#import <Cocoa/Cocoa.h>
#import <ScreenSaver/ScreenSaverView.h>
#import <MacRuby/MacRuby.h>

@interface RBScreenSaverView : ScreenSaverView
@end

@implementation RBScreenSaverView
+ (void) initialize
{
    static int initialized = 0;
    if (!initialized) {
        initialized = 1;
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        NSBundle *bundle = [NSBundle bundleForClass:self];
        NSString *main_path = [bundle pathForResource:@"RBScreenSaverView" ofType:@"rb"];
        if (main_path) {
            [[MacRuby sharedRuntime] evaluateFileAtPath:main_path];
        }
        [pool release];
    }
}
@end