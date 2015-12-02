//
//  SchoolViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/8.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import "SchoolViewController.h"
#import "GDataXMLNode.h"
#import "ChineseString.h"

@interface SchoolViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)NSMutableArray *dataArray;
@property (strong,nonatomic)NSMutableArray *indexArray;
@property (strong,nonatomic)NSMutableArray *letterSortArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *headLable;

@end

@implementation SchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.tableHeaderView=self.headView;
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:animated];
    [NSThread detachNewThreadSelector:@selector(threadClick) toTarget:self withObject:nil];
}
- (IBAction)backClick:(UIButton *)sender
{
    if (self.indexArray) {
        self.indexArray=nil;
        self.headLable.text=@"请选择学校";
        [self.tableView reloadData];
    }else
    {
        self.back(YES,nil);
    }
}
- (void)threadClick
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"bx_school_province2" ofType:@"xml"];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:path];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray *users = [rootElement elementsForName:@"BXS"];
    self.dataArray=[NSMutableArray array];
    for (GDataXMLElement *user in users) {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        
        //User节点的id属性
        
        GDataXMLElement *idElement= [[user elementsForName:@"id"]objectAtIndex:0];
        
        //        NSLog(@"User id is:%@",userId);
        NSString *idString=@"";
        idString= [idElement stringValue];
        [dict setValue:idString forKey:@"id"];
        
        
        //获取name节点的值
        
        GDataXMLElement *nameElement = [[user elementsForName:@"title"]objectAtIndex:0];
        
        NSString *name=@"";
        name= [nameElement stringValue];
        [dict setValue:name forKey:@"name"];
        
        NSLog(@"User name is:%@",name);
        
        
        
        //获取age节点的值
        
//        GDataXMLElement *ageElement = [[user elementsForName:@"school"]objectAtIndex:0];
//        NSString *age=@"";
//        age= [ageElement stringValue];
        GDataXMLElement *schoolElement = [[user elementsForName:@"school"]objectAtIndex:0];
        NSMutableArray *array=[NSMutableArray array];
        for (GDataXMLElement *sl in [schoolElement elementsForName:@"BXS"]) {
            NSMutableDictionary *dict=[NSMutableDictionary dictionary];
            GDataXMLElement *idElement= [[sl elementsForName:@"id"]objectAtIndex:0];
            NSString *idString=@"";
            idString= [idElement stringValue];
            [dict setValue:idString forKey:@"id"];
            
            GDataXMLElement *nameElement= [[sl elementsForName:@"name"]objectAtIndex:0];
            NSString *nameString=@"";
            nameString= [nameElement stringValue];
            [dict setValue:nameString forKey:@"name"];
            [array addObject:dict];
        }
        [dict setValue:array forKey:@"province"];
        [self.dataArray addObject:dict];
        NSLog(@"-------------------");
    }
//    self.indexArray=[ChineseString IndexArray:self.dataArray];
//    self.letterSortArray=[ChineseString LetterSortArray:self.dataArray];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.indexArray) {
        return self.indexArray.count;
    }
    return self.dataArray.count;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return self.headView;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return self.headView.frame.size.height;
//}
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    NSArray *array=self.indexArray;
//    return array;
//}
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    NSLog(@"%ld",(long)index);
//    return index;
//}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return self.indexArray[section];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
    }
    NSDictionary *dict;
    if (self.indexArray)    {
        dict=self.indexArray[indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryNone;
    }else
    {
        dict=self.dataArray[indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
//    for (NSDictionary *dic in self.dataArray) {
//        if ([dic[@"name"] isEqualToString:self.letterSortArray[indexPath.section][indexPath.row]]) {
//            dict=dic;
//        }
//    }
    cell.textLabel.text=dict[@"name"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%@",self.dataArray[indexPath.row]);
    if (self.indexArray) {
        self.back(YES,self.indexArray[indexPath.row]);
    }else
    {
        self.headLable.text=self.dataArray[indexPath.row][@"name"];
        self.indexArray=self.dataArray[indexPath.row][@"province"];
        [self.tableView reloadData];
    }
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
