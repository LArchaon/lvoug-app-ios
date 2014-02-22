#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * address_latitude;
@property (nonatomic, retain) NSDecimalNumber * address_longitude;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * event_page;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * title;

@end
