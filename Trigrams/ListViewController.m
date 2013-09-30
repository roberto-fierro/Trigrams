//
//  ListViewController.m
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/29/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import "ListViewController.h"
#import "TrigramsTableViewCell.h"
#import "TextViewController.h"
#import "TextReader.h"
#import "TrigramsGenerator.h"
#import "Trigram.h"
#import "TextGenerator.h"

@interface ListViewController ()


@end

@implementation ListViewController

@synthesize textsArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ( [[segue identifier] isEqualToString:@"GenerateText"] ){
        TextViewController *tvc = (TextViewController *)[segue destinationViewController];
        NSString *fileName = @"";
        if([[self.tableView indexPathForSelectedRow] row] == 0){
            fileName = @"test kata";
        }
        if([[self.tableView indexPathForSelectedRow] row] == 1){
            fileName = @"book1";
        }
        if([[self.tableView indexPathForSelectedRow] row] == 2){
            fileName = @"book2";
        }
        tvc.generatedText = [self generateTextFromBookOrText:fileName];
        
    }
}

//generate text from the selected book option
-(NSString*) generateTextFromBookOrText:(NSString*) fileName{
    //read the txt file and obtain array of paragraphs
    TextReader *reader = [[TextReader alloc] init];
    NSArray *paragraphs = [reader readTextFromFileName:fileName];
    //obtains the trigrams from the text 
    TrigramsGenerator *parser = [[TrigramsGenerator alloc] init];
    [paragraphs enumerateObjectsUsingBlock:^(id anObject, NSUInteger idx, BOOL *stop) {
        NSString *paragraph = (NSString*)anObject;
        //the populates the trigram dictionary
        [parser generateTrigramsWithParagraph:paragraph];
    }];
    //generate the text
    TextGenerator *generator = [[TextGenerator alloc] init];
    //obtain starter key from parser
    generator.starterKey = [parser getStarterKey];
    //obtaion the text
    NSString *generatedText = [generator generateTextWithTrigramsDictionary:parser.trigramsDictionary];
    
    
    return generatedText;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //fixed options
    self.textsArray = [[NSMutableArray alloc] initWithObjects:
                      @"Generate text from kata 14 example",
                      @"Generate text from \"Tom Swift and his Airship\"",
                      @"Generate text from \"Faust: Der Tragödie erster Teil\"", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.textsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TrigramsCell";
    TrigramsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[TrigramsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.bookTextLabel.text = [self.textsArray objectAtIndex:indexPath.row];
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
