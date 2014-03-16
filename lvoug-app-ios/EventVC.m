#import "EventVC.h"
#import "DataService.h"
#import "DateHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation EventVC

NSString * eventPage;
NSNumber * eventLatitude;
NSNumber * eventLongitude;
NSNumber * chosenEvent;

NSArray * materials;
NSArray * sponsors;
NSArray * contacts;

- (void)viewDidLoad
{
    [super viewDidLoad];

    Event *event = [[DataService instance] event:chosenEvent];
    
    self.eventTitle.text = event.title;
    self.eventText.text = event.text;
    
    NSMutableString * address = [[NSMutableString alloc] init];
    [address appendString:event.address];
    [address appendString:@" (get directions)"];
    self.eventAddress.text = address;
    self.eventDate.text = [DateHelper getStringDateTimeFromApiFormat:event.date];
    
    [self.eventImage setImageWithURL:[NSURL URLWithString:event.logo] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    eventPage = event.event_page;
    self.eventPageButton.backgroundColor = [UIColor colorWithRed:255/255.0f green:129/255.0f blue:127/255.0f alpha:1.0f];
    [self.eventPageButton addTarget:self action:@selector(openUrlOnButtonPress) forControlEvents:UIControlEventTouchUpInside];
    
    eventLatitude = event.address_latitude;
    eventLongitude = event.address_longitude;

    if (eventLatitude != nil && eventLongitude != nil) {
        self.eventAddress.textColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        self.eventAddress.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openMapOnAddressPress)];
        [self.eventAddress addGestureRecognizer:tapGesture];
    }
    
    contacts = [NSArray arrayWithArray:[event.eventContacts allObjects]];
    materials = [NSArray arrayWithArray:[event.eventMaterials allObjects]];
    sponsors = [NSArray arrayWithArray:[event.eventSponsors allObjects]];
    self.eventMaterials.dataSource = self;
    self.eventSponsors.dataSource = self;
    self.eventContacts.dataSource = self;
    self.eventMaterials.delegate = self;
    self.eventSponsors.delegate = self;
    self.eventContacts.delegate = self;
}

- (void)openUrlOnButtonPress
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: eventPage]];
}

- (void)openMapOnAddressPress
{
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        CLLocationCoordinate2D coordinate =
        CLLocationCoordinate2DMake([eventLatitude doubleValue], [eventLongitude doubleValue]);
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:@"Venue"];
        
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking};
        MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
        [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem]
                       launchOptions:launchOptions];
    }
}

- (void)setEvent:(NSNumber *)eventId
{
    chosenEvent = eventId;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell;
    if (tableView == self.eventMaterials) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"materialCell"];
        Material *material = [materials objectAtIndex:indexPath.row];
        cell.textLabel.text = material.title;
    }
    
    if (tableView == self.eventSponsors) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"sponsorCell"];
        Sponsor *sponsor = [sponsors objectAtIndex:indexPath.row];
        cell.textLabel.text = sponsor.name;
        [cell.imageView setImageWithURL:[NSURL URLWithString:sponsor.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    
    if (tableView == self.eventContacts) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell"];
        Contact *contact = [contacts objectAtIndex:indexPath.row];
        NSMutableString * nameSurname = [[NSMutableString alloc] init];
        [nameSurname appendString:contact.name];
        [nameSurname appendString:@" "];
        [nameSurname appendString:contact.surname];
        cell.textLabel.text = nameSurname;
        cell.detailTextLabel.text = contact.email;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.eventMaterials) {
        Material *material = [materials objectAtIndex:indexPath.row];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: material.url]];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount = 0;
    if (tableView == self.eventMaterials)
        rowCount = materials.count;
    
    if (tableView == self.eventSponsors)
        rowCount = sponsors.count;
    
    if (tableView == self.eventContacts)
        rowCount = contacts.count;

    
    return rowCount;
}

/* three shitcode methods because i don't 
 * know how to make UIScrollView and three 
 * UITableViews friends using autolayout.
 * todo refactor */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self adjustHeightOfTableview];
}

- (void)adjustHeightOfTableview {
    [self adjustHeightOfTableview:self.eventMaterials withHeight:self.eventMaterialsConstraint];
    [self adjustHeightOfTableview:self.eventContacts withHeight:self.eventContactsConstraint];
    [self adjustHeightOfTableview:self.eventSponsors withHeight:self.eventSponsorsConstraint];
}

- (void)adjustHeightOfTableview:(UITableView *)current withHeight:(NSLayoutConstraint *)constraint
{
    CGFloat height = current.contentSize.height;
    [UIView animateWithDuration:0.25 animations:^{
        constraint.constant = height;
        [self.view needsUpdateConstraints];
    }];
}

@end
