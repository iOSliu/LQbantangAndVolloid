//
//  LQAttriViewController.m
//  NBDemo
//
//  Created by 刘强强 on 2017/3/11.
//  Copyright © 2017年 刘强强. All rights reserved.
//

#import "LQAttriViewController.h"

#import "LQHuaTiCell.h"
#import "LQImgCell.h"

#import "ACEExpandableTextCell.h"
#import "UIViewController+KeyboardCorver.h"

@interface LQAttriViewController ()<UITableViewDelegate, UITableViewDataSource, ACEExpandableTableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LQImgCellDelegate>
{
//    CGFloat _cellHeight;
//    NSInteger _imgIndex;
}

@property (nonatomic, strong) NSMutableArray *cellData;

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIToolbar *kbToolbar;

@property(nonatomic, strong) NSMutableArray *cellType;

@property(nonatomic, strong) NSMutableArray *contentCellH;

@property(nonatomic, strong) NSMutableArray *contentText;

@property(nonatomic, strong) NSMutableArray *imgArr;

@property(nonatomic, strong) NSIndexPath *indexPath;

@end

typedef NS_ENUM(NSUInteger, CellType) {
    CellTypeTitle,
    CellTypeHuaTi,
    CellTypeImg,
    CellTypeContent,
};

@implementation LQAttriViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"===hsjhja==");
    self.title = @"发布";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.cellData = [NSMutableArray arrayWithArray:@[ @"Existing text", @""]];
    
    [self addNotification];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellType.count;
}

-(__kindof UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellType type = [self.cellType[indexPath.row] integerValue];
    if (type == CellTypeTitle) {
        return [LQHuaTiCell huaTiCellWithIndexPath:indexPath tableView:tableView];
        
    }else if(type == CellTypeContent){
        ACEExpandableTextCell *cell = [tableView expandableTextCellWithId:@"cellId"];
        cell.textView.placeholder = @"正文...";
        cell.textView.inputAccessoryView = self.kbToolbar;
        cell.textView.text = self.contentText[indexPath.row];
        return cell;
    }else if (type == CellTypeImg){
        LQImgCell *cell = [LQImgCell imgCellWithIndexPath:indexPath tableView:tableView];
        cell.img = self.imgArr[indexPath.row];
        cell.delegate = self;
        return cell;
    }else {
        return [LQHuaTiCell huaTiCellWithIndexPath:indexPath tableView:tableView];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellType type = [self.cellType[indexPath.row] integerValue];
    if (type == CellTypeImg) {
        UIImage *img = self.imgArr[indexPath.row];
        CGSize size = img.size;
        
        CGFloat height = size.height;
        
        if (size.height >= KHeight) {
            height = KHeight;
        }
        return height + 20;
    }else if (type == CellTypeTitle) {
        return 44;
    }else if (type == CellTypeContent){

        return MAX(50.0, [self.contentCellH[indexPath.row] floatValue]);
    }else {
        return 44;
    }
    
}

- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath
{
    CellType type = [self.cellType[indexPath.row] integerValue];
    if (type == CellTypeContent) {

        self.contentCellH[indexPath.row] = [NSNumber numberWithFloat:height];;
    }
    
}

- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath {
    CellType type = [self.cellType[indexPath.row] integerValue];
    if (type == CellTypeContent) {
        [_cellData replaceObjectAtIndex:indexPath.section withObject:text];
        
        self.contentText[indexPath.row] = text;
    }
    
}

-(void)tableView:(UITableView *)tableView updatedContexAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    
}

-(void)tableView:(UITableView *)tableView deleteContexAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 1) {
        if ([self.cellType[indexPath.row -1] integerValue] == CellTypeContent) {
            self.contentText[indexPath.row - 1] = [NSString stringWithFormat:@"%@%@",self.contentText[indexPath.row - 1],self.contentText[indexPath.row]];
            [self.contentText removeObjectAtIndex:indexPath.row];
            [self.contentCellH removeObjectAtIndex:indexPath.row];
            [self.cellType removeObjectAtIndex:indexPath.row];
            [self.imgArr removeObjectAtIndex:indexPath.row];
            
            [self.tableView reloadData];
        }
    }
}

#pragma mark -键盘bar
- (UIToolbar *) kbToolbar {
    if (_kbToolbar == nil) {
        _kbToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        UIBarButtonItem *imgItem = [[UIBarButtonItem alloc] initWithTitle:@"图片" style:UIBarButtonItemStylePlain target:self action:@selector(closeKeyboard)];
        UIBarButtonItem *goodsItem = [[UIBarButtonItem alloc] initWithTitle:@"添加商品" style:UIBarButtonItemStylePlain target:self action:@selector(closeKeyboard)];
        UIBarButtonItem *huatiItem = [[UIBarButtonItem alloc] initWithTitle:@"添加话题" style:UIBarButtonItemStylePlain target:self action:@selector(closeKeyboard)];
        _kbToolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], imgItem,[self barButtonSystemItem:UIBarButtonSystemItemFlexibleSpace],goodsItem,[self barButtonSystemItem:UIBarButtonSystemItemFlexibleSpace],huatiItem];
    }
    return _kbToolbar;
    
}

-(UIBarButtonItem*)barButtonSystemItem :(UIBarButtonSystemItem)systemItem {
    
    UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem target:nil action:nil];
    
    return button;
    
}

- (void)closeKeyboard {
    [self.view endEditing:YES];
    
    UIImagePickerController *pickerContro = [[UIImagePickerController alloc] init];
    pickerContro.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerContro.delegate = self;
    [self presentViewController:pickerContro animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self.cellType addObject:[NSNumber numberWithInteger:CellTypeImg]];
    
    [self.cellType addObject:[NSNumber numberWithInteger:CellTypeContent]];
    
    //图片cell控制
    [self.imgArr addObject:info[@"UIImagePickerControllerOriginalImage"]];
    [self.imgArr addObject:@""];
    //输入框高度控制
    [self.contentCellH addObject:@""];
    [self.contentCellH addObject:[NSNumber numberWithFloat:50.0]];
    
    //输入框内容控制
    [self.contentText addObject:@""];
    [self.contentText addObject:@""];
    
    [self.tableView reloadData];
}

#pragma mark LQImgCellDelegate
-(void)imgCellDeleteToIndexPathRow:(NSIndexPath *)indexPath {
    
    NSString *cellText = self.contentText[indexPath.row + 1];
    
    if (cellText.length == 0) {
        [self.cellType removeObjectAtIndex:indexPath.row + 1];
        [self.contentText removeObjectAtIndex:indexPath.row + 1];
        [self.contentCellH removeObjectAtIndex:indexPath.row + 1];
        [self.imgArr removeObjectAtIndex:indexPath.row + 1];
    }
    //位置不能变
    [self.contentText removeObjectAtIndex:indexPath.row];
    [self.contentCellH removeObjectAtIndex:indexPath.row];
    [self.imgArr removeObjectAtIndex:indexPath.row];
    [self.cellType removeObjectAtIndex:indexPath.row];
    
    [self.tableView reloadData];
    
}


-(NSMutableArray *)cellType {
    if (!_cellType) {
        _cellType = [NSMutableArray array];
        [_cellType addObject:[NSNumber numberWithInteger:CellTypeTitle]];
        [_cellType addObject:[NSNumber numberWithInteger:CellTypeContent]];
    }
    return _cellType;
}

-(NSMutableArray *)contentCellH {
    if(!_contentCellH){
        _contentCellH = [NSMutableArray array];
        [_contentCellH addObject:@""];
        [_contentCellH addObject:[NSNumber numberWithFloat:50.0]];
    }
    return _contentCellH;
}

-(NSMutableArray *)contentText {
    if (!_contentText) {
        _contentText = [NSMutableArray array];
        [_contentText addObject:@""];
        [_contentText addObject:@""];
    }
    return _contentText;
}

-(NSMutableArray *)imgArr {
    if (!_imgArr) {
        _imgArr = [NSMutableArray array];
        [_imgArr addObject:@""];
        [_imgArr addObject:@""];
    }
    return _imgArr;
}

@end
