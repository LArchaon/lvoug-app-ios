#import "MapBuilder.h"

@implementation MapBuilder

NSMutableDictionary *launchOptions;
NSMutableArray *mapItems;


- (MapBuilder *)init
{
    self = [super init];
    
    launchOptions = [[NSMutableDictionary alloc] init];
    mapItems = [[NSMutableArray alloc] init];    
    
    return self;
}

- (void)setPlacemarkWithLatitude:(double)latitude andLongitude:(double)longitude andTitle:(NSString *)title
{
    CLLocationCoordinate2D coordinate =
    CLLocationCoordinate2DMake(latitude, longitude);
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                   addressDictionary:nil];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    [mapItem setName:title];
    
    [mapItems addObject:mapItem];
}

- (void)setCurrentLocationMark
{
    MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
    [mapItems addObject:currentLocationMapItem];
}

- (void)openInApp
{
    [MKMapItem openMapsWithItems:mapItems launchOptions:launchOptions];
}

@end
