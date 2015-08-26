//
//  WXParse.m
//  test网址解析
//
//  Created by qianfeng001 on 15/6/17.
//  Copyright (c) 2015年 qianfeng001. All rights reserved.
//

#import "WXParse.h"
#import "GDataXMLNode.h"

@implementation WXParse
- (NSString *)description
{
    return [NSString stringWithFormat:@"\n{\nname1:%@ name2:%@ name3:%@ name4:%@ name5:%@\n}\n", _name1,_name2,_name3,_name4,_name5];
}

+(void)testJson:(NSString *)file
{
    NSMutableArray*mary=[[NSMutableArray alloc]init];
    NSURL*url=[NSURL URLWithString:file];
    NSData*data=[NSData dataWithContentsOfURL:url];
    id sth=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    id items=[sth objectForKey:@"items"];
    for (id mesage in items) {
        WXParse*parse=[[WXParse alloc]init];
        parse.name1=[mesage objectForKey:@"wid"];
        parse.name2=[mesage objectForKey:@"update_time"];
        parse.name3=[mesage objectForKey:@"wpic_s_width"];
        parse.name4=[mesage objectForKey:@"wpic_m_height"];
        parse.name5=[mesage objectForKey:@"wpic_s_height"];
        [mary addObject:parse];
    }
    for (id mh in mary) {
        NSLog(@"%@",mh);
    }
}

+(void)testXml:(NSString *)file
{
    NSMutableArray*mary=[[NSMutableArray alloc]init];
    NSURL*url=[NSURL URLWithString:file];
    NSData*data=[NSData dataWithContentsOfURL:url];
    
    GDataXMLDocument*doc=[[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
    
//    NSArray* sth1=[doc nodesForXPath:@"//id | //starttime" error:nil];
//    NSArray* sth2=[doc nodesForXPath:@"// | //endtime" error:nil];
    NSArray* sth3=[doc nodesForXPath:@"//promotion " error:nil];
    for (int i=0; i<[sth3 count]; i++) {
        WXParse*parse=[[WXParse alloc]init];
        parse.name1=[[sth3[i] elementsForName:@"id"][0] stringValue];
        parse.name2=[[sth3[i] elementsForName:@"starttime"][0] stringValue];
        parse.name3=[[sth3[i] elementsForName:@"endtime"][0] stringValue];
        parse.name4=[[sth3[i] elementsForName:@"name"][0] stringValue];
        parse.name5=[[sth3[i] elementsForName:@"price"][0] stringValue];
        [mary addObject:parse];
    }
    for (id mh in mary) {
        NSLog(@"%@",mh);
    }
}
@end
