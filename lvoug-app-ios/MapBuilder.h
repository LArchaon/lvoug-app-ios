#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapBuilder : NSObject

- (void)setPlacemarkWithLatitude:(double)latitude andLongitude:(double)longitude andTitle:(NSString *)title;
- (void)setCurrentLocationMark;
- (void)openInApp;

@end
