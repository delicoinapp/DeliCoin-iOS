//
//  ViewController.m
//  DeliCoin
//
//  Created by Fabiola Ramirez on 17/10/15.
//  Copyright (c) 2015 Fabiola Ramirez. All rights reserved.
//

#import "ViewController.h"
#import "Food.h"
#import <Parse/Parse.h>

@interface ViewController ()
{
    NSArray * foods;
    int index;
}

@property (weak, nonatomic) IBOutlet ZLSwipeableView *swipeableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
    navigationBar.backgroundColor = [UIColor whiteColor];
    
    
    self.swipeableView.dataSource = self;
    
    index = 0;
    
    Food * food1 = [[Food alloc] init];
    food1.name = @"food1";
    food1.imageName = @"food1.jpg";
    food1.descripcion = @"descripcion1";
    
    Food * food2 = [[Food alloc] init];
    food2.name = @"food2";
    food2.imageName = @"food2.jpg";
    food2.descripcion = @"descripcion2";
    
    Food * food3 = [[Food alloc] init];
    food3.name = @"food3";
    food3.imageName = @"food3.jpg";
    food3.descripcion = @"descripcion3";
    
    //foods = [[NSArray alloc] initWithObjects:food1,food2,food3, nil];
    
    PFQuery * query = [PFQuery queryWithClassName:@"Food"];
    //[query whereKey:@"name" equalTo:@"Dan Stemkoski"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            
            // dispatch_sync(dispatch_get_main_queue(), ^ {
            
            foods = objects;
            [self viewDidLayoutSubviews];
            //});
            
            NSLog(@"count foods dentro del block : %lu",(unsigned long)foods.count);
            //showing
            for (PFObject *object in foods) {
                NSLog(@"%@", object.objectId);
            }
            
        } else {
            
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    NSLog(@" count despues de cargar %lu",(unsigned long)foods.count);
    
    
    
    
}

- (void)viewDidLayoutSubviews {
    // Required Data Source
    self.swipeableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    NSLog(@"nextViewForSwipeableView");
    NSLog(@"foods count: -------: %lu",(unsigned long)foods.count);
    
    if (index < foods.count) {
        
        NSLog(@"entra if");
        CardView * view = [[CardView alloc] initWithFrame:swipeableView.bounds];
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *contentView = [[[NSBundle mainBundle] loadNibNamed:@"CardContentView" owner:self options:nil] objectAtIndex:0];
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        //********************************************
    
        NSLog(@"index:%i",index);
        NSLog(@" contador en en index block: %lu",(unsigned long)foods.count);
        
        PFObject * food = [foods objectAtIndex:index];
        
        NSLog(@"name desde block: %@",food[@"name"]);
        //NSLog(@"descripcion: %@",food[@"description"]);
        
        UILabel * nameLabel = (UILabel *) [contentView viewWithTag:1];
        //UILabel * descripcionLabel = (UILabel *) [contentView viewWithTag:2];
        UIImageView * imageNameView = (UIImageView *) [contentView viewWithTag:3];
        
        NSLog(@"tag 1: %@",[contentView viewWithTag:1]);
        //NSLog(@"tag 1: %@",[contentView viewWithTag:2]);
        NSLog(@"tag 1: %@",[contentView viewWithTag:3]);
        
        nameLabel.text =  food[@"name"];
        //descripcionLabel.text =  food[@"description"];
        //imageNameView.image =[UIImage imageNamed:food.imageName];
        
        //getting image
        PFFile *imageFile=[food objectForKey:@"imageFile"];
        
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if(!error){
                imageNameView.image=[UIImage imageWithData:data];
                
            }
            else{
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
            
        }];
        
        //*********************************************
        [view addSubview:contentView];
        
        NSDictionary *metrics = @{
                                  @"height" : @(view.bounds.size.height),
                                  @"width" : @(view.bounds.size.width)
                                  };
        
        NSDictionary * views = NSDictionaryOfVariableBindings(contentView);
        [view addConstraints:
         [NSLayoutConstraint
          constraintsWithVisualFormat:@"H:|[contentView(width)]"
          options:0
          metrics:metrics
          views:views]];
        [view addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:
                              @"V:|[contentView(height)]"
                              options:0
                              metrics:metrics
                              views:views]];
        index = index + 1;
        return view;
        
        
        
    }
    
    
    NSLog(@"no entra if");
    return nil;
    
}




- (IBAction)goLeft:(UIButton *)sender {
    
    [self.swipeableView swipeTopViewToLeft];
}

- (IBAction)goRight:(UIButton *)sender {
    
    [self.swipeableView swipeTopViewToRight];
}


@end
