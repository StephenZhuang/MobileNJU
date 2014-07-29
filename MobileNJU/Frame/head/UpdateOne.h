//
//  UpdateOne.h
//  protobufTest
//
//  Created by lu liu on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateOne : NSObject{
@public
    IntenetRead *mIntenetRead;
    NSString *muserId;
    NSString *mnamespace;
    NSString *md5str;
    NSString *murl;
    NSObject *mpostdata;
    NSObject *mpostparams;
    NSStringEncoding mEncode;
    NSStringEncoding mUpEncode;
    SEL mselector;
    BOOL showLoading;
    BOOL showLoadingAble;
    int mtype;
    PBGeneratedMessage_Builder *mbuild;
    id mdelegate;
    int merrortype;
    Class delegateClass;
}

@property(strong,nonatomic) NSString *mid;
@property(strong,nonatomic) NSString *mlid;

-(id)init;

-(id)init:(NSString*)nid params:(NSObject*)postdata type:(int)type selecter:(SEL) selecter;

-(id)init:(NSString*)nid params:(NSObject*)postdata type:(int)type;

-(id)init:(NSString*)nid params:(NSObject*)postdata type:(int)type delegate:(id)ndelegate selecter:(SEL) selecter;

-(id)init:(NSString*)nid params:(NSObject*)postdata type:(int)type delegate:(id)ndelegate;

-(id)init:(NSString*)nid params:(NSObject*)postdata postparams:(NSObject*)postData type:(int)type build:(PBGeneratedMessage_Builder*)build selecter:(SEL) selecter;

-(id)init:(NSString*)nid params:(NSObject*)postdata postparams:(NSObject*)postData  delegate:(id)ndelegate selecter:(SEL) selecter;

-(id)init:(NSString*)nid params:(NSObject*)postdata postparams:(NSObject*)postData type:(int)type build:(PBGeneratedMessage_Builder*)build;

-(id)init:(NSString*)nid params:(NSObject*)postdata postparams:(NSObject*)postData type:(int)type build:(PBGeneratedMessage_Builder*)build delegate:(id)ndelegate selecter:(SEL) selecter;

-(id)init:(NSString*)nid params:(NSObject*)postdata postparams:(NSObject*)postData type:(int)type build:(PBGeneratedMessage_Builder*)build delegate:(id)ndelegate;

-(id)init:(NSString*)nid params:(NSObject*)postdata type:(int)type build:(PBGeneratedMessage_Builder*)build selecter:(SEL) selecter;

-(id)init:(NSString*)nid params:(NSObject*)postdata type:(int)type build:(PBGeneratedMessage_Builder*)build;

-(id)init:(NSString*)nid params:(NSObject*)postdata type:(int)type build:(PBGeneratedMessage_Builder*)build delegate:(id)ndelegate selecter:(SEL) selecter;

-(id)init:(NSString*)nid params:(NSObject*)postdata type:(int)type build:(PBGeneratedMessage_Builder*)build delegate:(id)ndelegate;

-(id)init:(NSString*)nid params:(NSObject*)postdata selecter:(SEL) selecter;

-(id)init:(NSString*)nid params:(NSObject*)postdata delegate:(id)ndelegate selecter:(SEL) selecter;

-(id)init:(NSString*)nid params:(NSObject*)postdata;

-(id)init:(NSString*)nid params:(NSObject*)postdata delegate:(id)ndelegate;

-(void)getSon;

-(void) addParam:(NSString*)key value:(NSString*)value;

-(UpdateOne*)setType:(int)type;

-(UpdateOne*)setShowLoading:(BOOL)showla;

-(UpdateOne*)setDelegate:(id)ndelegate;

-(UpdateOne*)setId:(NSString*)nid;

-(UpdateOne*)setUserId:(NSString*)userid;

-(UpdateOne*)setNamespace:(NSString*)namespac;

-(UpdateOne*)setSelecter:(SEL) selecter;

-(id)getDelegate;

-(void)disposMessage:(Son*)son;

-(void)closeLoading:(BOOL)delegateisRelease isrelease:(BOOL)release;

-(void)showLoading;

-(void)cancel;


-(Boolean)checkType;

-(IntenetRead*)readData;

@end
