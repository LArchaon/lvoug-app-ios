#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact, Material, Sponsor;

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
@property (nonatomic, retain) NSSet *eventContacts;
@property (nonatomic, retain) NSSet *eventMaterials;
@property (nonatomic, retain) NSSet *eventSponsors;
@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addEventContactsObject:(Contact *)value;
- (void)removeEventContactsObject:(Contact *)value;
- (void)addEventContacts:(NSSet *)values;
- (void)removeEventContacts:(NSSet *)values;

- (void)addEventMaterialsObject:(Material *)value;
- (void)removeEventMaterialsObject:(Material *)value;
- (void)addEventMaterials:(NSSet *)values;
- (void)removeEventMaterials:(NSSet *)values;

- (void)addEventSponsorsObject:(Sponsor *)value;
- (void)removeEventSponsorsObject:(Sponsor *)value;
- (void)addEventSponsors:(NSSet *)values;
- (void)removeEventSponsors:(NSSet *)values;

@end
