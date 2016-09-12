//
//  ArticlesTableViewController.m
//  Task
//
//  Created by Petko Todorov on 9/10/16.
//  Copyright © 2016 Petko Todorov. All rights reserved.
//

#import "ArticlesTableViewController.h"
#import "DataManager.h"
#import "Article.h"
#import "APIClient.h"
#import "DetailsViewController.h"
#import "ArticleTableViewCell.h"
#import "AlertManager.h"

@interface ArticlesTableViewController () {
    DataManager *dataManager;
    BOOL isFiltrated;
    UIBarButtonItem *barButton;
}

@end

@implementation ArticlesTableViewController

static NSString* articleCellIdentifier = @"ArticleCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    isFiltrated = NO;
    dataManager = [DataManager sharedManager];
    barButton = [[UIBarButtonItem alloc]initWithTitle:@"Favourites" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonTapped)];
    self.navigationItem.rightBarButtonItem = barButton;
    [self.tableView registerClass:[ArticleTableViewCell class] forCellReuseIdentifier:articleCellIdentifier];
     self.clearsSelectionOnViewWillAppear = NO;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (dataManager.articles.count == 0 ) {
        [self fetchArticles];
    }
}

#pragma mark - Helper methods

-(void) fetchArticles {
    self.tableView.hidden = YES;
    ArticlesTableViewController * __weak weakSelf = self;
    [[APIClient sharedClient] getArticlesWithSuccess:^(NSDictionary *result) {
        [[DataManager sharedManager] parseJson:result withCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                weakSelf.tableView.hidden = NO;
            });
        }];
    }];
 
}

-(void)reloadCell:(ArticleTableViewCell *)cell expanded:(BOOL)isExpanded {
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:cell];
    if (isFiltrated) {
        ((Article*)dataManager.favouriteArticles[selectedIndexPath.row]).isExpanded = isExpanded;
    } else {
        ((Article*)dataManager.articles[selectedIndexPath.row]).isExpanded = isExpanded;
    }
    [self.tableView reloadRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}



#pragma mark - Actions

- (void) likeArticle: (UIButton*) sender {
    sender.selected = !sender.selected;
    ArticlesTableViewController * __weak weakSelf = self;
    if (isFiltrated) {
        Article *selectedArticle = dataManager.favouriteArticles[sender.tag];
        [dataManager removeArticleFromFavorites:selectedArticle withComplitionHandler:^{
            [AlertManager showAlert:@"Article removed from favorites!" withTitle:@"Success" fromViewController:weakSelf];
        }];
        if (dataManager.favouriteArticles.count == 0) {
            isFiltrated = NO;
            [barButton setTitle:@"Favourites"];
        }
        [self.tableView reloadData];
    } else {
        Article *selectedArticle = dataManager.articles[sender.tag];
        if (sender.selected) {
            [dataManager addArticleToFavorites:selectedArticle withComplitionHandler:^{
                [AlertManager showAlert:@"Article added to favorites!" withTitle:@"Success" fromViewController:weakSelf];
            }];
        } else {
            [dataManager removeArticleFromFavorites:selectedArticle withComplitionHandler:^{
                [AlertManager showAlert:@"Article removed from favorites!" withTitle:@"Success" fromViewController:weakSelf];
            }];
        }
        
    }
}

-(void) barButtonTapped {
    if (!isFiltrated) {
        if (dataManager.favouriteArticles.count == 0) {
            [AlertManager showAlert:@"There are no favorite articles!" withTitle:@"" fromViewController:self];
        } else {
            isFiltrated = YES;
            [barButton setTitle:@"All articles"];
        }
    } else {
        isFiltrated = NO;
        [barButton setTitle:@"Favourites"];
    }
    [self.tableView reloadData];
}



#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isFiltrated) {
        Article *currentArticle = dataManager.favouriteArticles[indexPath.row];
        return currentArticle.isExpanded ? 150 : 120;
    } else {
        Article *currentArticle = dataManager.articles[indexPath.row];
        return currentArticle.isExpanded ? 150 : 120;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger arrCount = dataManager.articles.count;
    if (arrCount > 0) {
        return isFiltrated ? dataManager.favouriteArticles.count : arrCount;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:articleCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    NSUInteger arrCount = dataManager.articles.count;
    if (arrCount > 0) {
        NSMutableArray *articles = [NSMutableArray array];
        if (isFiltrated) {
            articles = dataManager.favouriteArticles;
        } else {
            articles = dataManager.articles;
        }
        Article *article = articles[indexPath.row];
        cell.lblTitle.text = article.title;
        cell.txtDescription.text = article.abstractInfo;
        [cell.btnFavourite addTarget:self action:@selector(likeArticle:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnFavourite.selected = article.isFavourite;
        cell.btnFavourite.tag = indexPath.row;
        cell.isExpanded = article.isExpanded;
        [[APIClient sharedClient] setImageFromUrl:article.thumbnail toImageView:cell.imgAvatar];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableArray *articles = [NSMutableArray array];
    if (isFiltrated) {
        articles = dataManager.favouriteArticles;
    } else {
        articles = dataManager.articles;
    }
    Article *selectedArticle = articles[indexPath.row];
    DetailsViewController *dvc = [[DetailsViewController alloc] init];
    dvc.title = @"Details";
    dvc.selectedArticle = selectedArticle;
    ArticleTableViewCell *selectedCell = (ArticleTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    dataManager.selectedImage = selectedCell.imgAvatar.image;
    [self.navigationController pushViewController:dvc animated:NO];
}



@end
