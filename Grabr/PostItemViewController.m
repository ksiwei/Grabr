//
//  PostItemViewController.m
//  Grabr
//
//  Created by Siwei Kang on 5/30/15.
//  Copyright (c) 2015 swayy. All rights reserved.
//

#import "PostItemViewController.h"

@interface PostItemViewController ()
@property (strong, nonatomic) UIImage *itemPhoto;

@property (weak, nonatomic) IBOutlet UIImageView *itemPhotoView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation PostItemViewController

- (void)configureWithImage:(UIImage *)image {
    self.itemPhoto = image;
}

- (void)viewDidLoad {
    self.title = @"Edit Item";

    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.itemPhotoView.image = self.itemPhoto;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
