#import "EventVC.h"
#import "DataService.h"
#import "DateHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NavigationHelper.h"
#import "MapBuilder.h"
#import "ContactCollectionCell.h"

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
    
    self.eventAddress.text = event.address;
    self.eventDate.text = [DateHelper getStringDateTimeFromApiFormat:event.date];
    
    [self.eventImage setImageWithURL:[NSURL URLWithString:event.logo] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    eventPage = event.event_page;
    [self.eventPageButton addTarget:self action:@selector(openUrlOnEventPageButtonPress) forControlEvents:UIControlEventTouchUpInside];
    
    eventLatitude = event.address_latitude;
    eventLongitude = event.address_longitude;

    if (eventLatitude != nil && eventLongitude != nil && [eventLatitude intValue] != 0 && [eventLongitude intValue] != 0) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openMapOnAddressPress)];
        [self.mapIcon addGestureRecognizer:tapGesture];
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

- (void)openUrlOnEventPageButtonPress
{
    [NavigationHelper openUrl:eventPage];
}

- (void)openMapOnAddressPress
{
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]) {
        MapBuilder *mapBuilder = [[MapBuilder alloc] init];
        [mapBuilder setPlacemarkWithLatitude:[eventLatitude doubleValue] andLongitude:[eventLongitude doubleValue] andTitle:@"Venue"];
        [mapBuilder openInApp];
    }
}

- (void)setEvent:(NSNumber *)eventId
{
    chosenEvent = eventId;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    if (tableView == self.eventMaterials) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"materialCell"];
        
        if (materials.count > indexPath.row) {
            Material *material = [materials objectAtIndex:indexPath.row];
            cell.textLabel.text = material.title;
        } else {
            cell.textLabel.text = @"No materials provided";
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            [cell setUserInteractionEnabled:FALSE];
            [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        }
    }
    
    if (tableView == self.eventSponsors) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"sponsorCell"];
        
        if (sponsors.count > indexPath.row) {
            Sponsor *sponsor = [sponsors objectAtIndex:indexPath.row];
            cell.textLabel.text = sponsor.name;
            [cell.imageView setImageWithURL:[NSURL URLWithString:sponsor.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        } else {
            cell.textLabel.text = @"no sponsors for event";
            cell.imageView.image = nil;
            [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        }
    }
    
    return cell;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (collectionView == self.eventContacts) {
        ContactCollectionCell *cell = (ContactCollectionCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"contactCell" forIndexPath:indexPath];
        
        if (contacts.count > indexPath.row) {
            Contact *contact = [contacts objectAtIndex:indexPath.row];
            NSMutableString * nameSurname = [[NSMutableString alloc] init];
            [nameSurname appendString:contact.name];
            [nameSurname appendString:@" "];
            [nameSurname appendString:contact.surname];
            
            cell.contactEmail.text = contact.email;
            cell.contactNameSurname.text = nameSurname;
            cell.contactPhone.text = contact.telephone;
            
            [cell.contactEmail addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openMail:)]];
            [cell.contactPhone addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone:)]];
        } else {
            cell.contactNameSurname.text = @"No contacts";
            cell.contactPhone.text = nil;
            cell.contactEmail.text = nil;
        }

        return cell;
    } else {
        UICollectionViewCell * cell;
        NSLog(@"empty cell");
        return cell;
    }
    
}

- (void)openMail:(UITapGestureRecognizer *)recognizer
{
    UITextView *contactEmail = (UITextView *)recognizer.view;
    [NavigationHelper openMail:contactEmail.text];
}

- (void)callPhone:(UITapGestureRecognizer *)recognizer
{
    UITextView *contactPhone = (UITextView *)recognizer.view;
    [NavigationHelper call:contactPhone.text];
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
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
    
    if (rowCount == 0)
        rowCount = 1;
    
    return rowCount;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger rowCount = 0;
    
    if (collectionView == self.eventContacts)
        rowCount = contacts.count;
    
    if (rowCount == 0)
        rowCount = 1;
    
    return rowCount;
}

/* these shitcode methods exist because i don't
 * know how to make parent UIScrollView and three
 * child UIScrollViews friends using autolayout.
 * todo refactor */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self adjustHeightOfScrollView:self.eventMaterials withHeight:self.eventMaterialsConstraint];
    [self adjustHeightOfScrollView:self.eventSponsors withHeight:self.eventSponsorsConstraint];
    [self adjustHeightOfScrollView:self.eventContacts withHeight:self.eventContactsConstraint];

}

- (void)adjustHeightOfScrollView:(UIScrollView *)current withHeight:(NSLayoutConstraint *)constraint
{
    CGFloat height = current.contentSize.height;
    [UIView animateWithDuration:0.25 animations:^{
        constraint.constant = height;
        [self.view needsUpdateConstraints];
    }];
}

@end
