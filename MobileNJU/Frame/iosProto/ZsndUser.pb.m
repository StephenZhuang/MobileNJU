// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ZsndUser.pb.h"

@implementation ZsndUserRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [ZsndUserRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface MUser ()
@property (retain) NSString* id;
@property (retain) NSString* account;
@property (retain) NSString* headImg;
@property (retain) NSString* nickname;
@property (retain) NSString* verify;
@property int32_t sex;
@property (retain) NSString* birthday;
@property (retain) NSMutableArray* mutableTagsList;
@property int32_t flower;
@property (retain) NSString* belong;
@property int32_t isV;
@end

@implementation MUser

- (BOOL) hasId {
  return !!hasId_;
}
- (void) setHasId:(BOOL) value {
  hasId_ = !!value;
}
@synthesize id;
- (BOOL) hasAccount {
  return !!hasAccount_;
}
- (void) setHasAccount:(BOOL) value {
  hasAccount_ = !!value;
}
@synthesize account;
- (BOOL) hasHeadImg {
  return !!hasHeadImg_;
}
- (void) setHasHeadImg:(BOOL) value {
  hasHeadImg_ = !!value;
}
@synthesize headImg;
- (BOOL) hasNickname {
  return !!hasNickname_;
}
- (void) setHasNickname:(BOOL) value {
  hasNickname_ = !!value;
}
@synthesize nickname;
- (BOOL) hasVerify {
  return !!hasVerify_;
}
- (void) setHasVerify:(BOOL) value {
  hasVerify_ = !!value;
}
@synthesize verify;
- (BOOL) hasSex {
  return !!hasSex_;
}
- (void) setHasSex:(BOOL) value {
  hasSex_ = !!value;
}
@synthesize sex;
- (BOOL) hasBirthday {
  return !!hasBirthday_;
}
- (void) setHasBirthday:(BOOL) value {
  hasBirthday_ = !!value;
}
@synthesize birthday;
@synthesize mutableTagsList;
- (BOOL) hasFlower {
  return !!hasFlower_;
}
- (void) setHasFlower:(BOOL) value {
  hasFlower_ = !!value;
}
@synthesize flower;
- (BOOL) hasBelong {
  return !!hasBelong_;
}
- (void) setHasBelong:(BOOL) value {
  hasBelong_ = !!value;
}
@synthesize belong;
- (BOOL) hasIsV {
  return !!hasIsV_;
}
- (void) setHasIsV:(BOOL) value {
  hasIsV_ = !!value;
}
@synthesize isV;
- (void) dealloc {
  self.id = nil;
  self.account = nil;
  self.headImg = nil;
  self.nickname = nil;
  self.verify = nil;
  self.birthday = nil;
  self.mutableTagsList = nil;
  self.belong = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.id = @"";
    self.account = @"";
    self.headImg = @"";
    self.nickname = @"";
    self.verify = @"";
    self.sex = 0;
    self.birthday = @"";
    self.flower = 0;
    self.belong = @"";
    self.isV = 0;
  }
  return self;
}
static MUser* defaultMUserInstance = nil;
+ (void) initialize {
  if (self == [MUser class]) {
    defaultMUserInstance = [[MUser alloc] init];
  }
}
+ (MUser*) defaultInstance {
  return defaultMUserInstance;
}
- (MUser*) defaultInstance {
  return defaultMUserInstance;
}
- (NSArray*) tagsList {
  return mutableTagsList;
}
- (NSString*) tagsAtIndex:(int32_t) index {
  id value = [mutableTagsList objectAtIndex:index];
  return value;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasId) {
    [output writeString:1 value:self.id];
  }
  if (self.hasAccount) {
    [output writeString:2 value:self.account];
  }
  if (self.hasHeadImg) {
    [output writeString:3 value:self.headImg];
  }
  if (self.hasNickname) {
    [output writeString:4 value:self.nickname];
  }
  if (self.hasVerify) {
    [output writeString:5 value:self.verify];
  }
  if (self.hasSex) {
    [output writeInt32:6 value:self.sex];
  }
  if (self.hasBirthday) {
    [output writeString:7 value:self.birthday];
  }
  for (NSString* element in self.mutableTagsList) {
    [output writeString:8 value:element];
  }
  if (self.hasFlower) {
    [output writeInt32:9 value:self.flower];
  }
  if (self.hasBelong) {
    [output writeString:10 value:self.belong];
  }
  if (self.hasIsV) {
    [output writeInt32:11 value:self.isV];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size = memoizedSerializedSize;
  if (size != -1) {
    return size;
  }

  size = 0;
  if (self.hasId) {
    size += computeStringSize(1, self.id);
  }
  if (self.hasAccount) {
    size += computeStringSize(2, self.account);
  }
  if (self.hasHeadImg) {
    size += computeStringSize(3, self.headImg);
  }
  if (self.hasNickname) {
    size += computeStringSize(4, self.nickname);
  }
  if (self.hasVerify) {
    size += computeStringSize(5, self.verify);
  }
  if (self.hasSex) {
    size += computeInt32Size(6, self.sex);
  }
  if (self.hasBirthday) {
    size += computeStringSize(7, self.birthday);
  }
  {
    int32_t dataSize = 0;
    for (NSString* element in self.mutableTagsList) {
      dataSize += computeStringSizeNoTag(element);
    }
    size += dataSize;
    size += 1 * self.mutableTagsList.count;
  }
  if (self.hasFlower) {
    size += computeInt32Size(9, self.flower);
  }
  if (self.hasBelong) {
    size += computeStringSize(10, self.belong);
  }
  if (self.hasIsV) {
    size += computeInt32Size(11, self.isV);
  }
  size += self.unknownFields.serializedSize;
  memoizedSerializedSize = size;
  return size;
}
+ (MUser*) parseFromData:(NSData*) data {
  return (MUser*)[[[MUser builder] mergeFromData:data] build];
}
+ (MUser*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (MUser*)[[[MUser builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (MUser*) parseFromInputStream:(NSInputStream*) input {
  return (MUser*)[[[MUser builder] mergeFromInputStream:input] build];
}
+ (MUser*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (MUser*)[[[MUser builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (MUser*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (MUser*)[[[MUser builder] mergeFromCodedInputStream:input] build];
}
+ (MUser*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (MUser*)[[[MUser builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (MUser_Builder*) builder {
  return [[[MUser_Builder alloc] init] autorelease];
}
+ (MUser_Builder*) builderWithPrototype:(MUser*) prototype {
  return [[MUser builder] mergeFrom:prototype];
}
- (MUser_Builder*) builder {
  return [MUser builder];
}
@end

@interface MUser_Builder()
@property (retain) MUser* result;
@end

@implementation MUser_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[MUser alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (MUser_Builder*) clear {
  self.result = [[[MUser alloc] init] autorelease];
  return self;
}
- (MUser_Builder*) clone {
  return [MUser builderWithPrototype:result];
}
- (MUser*) defaultInstance {
  return [MUser defaultInstance];
}
- (MUser*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (MUser*) buildPartial {
  MUser* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (MUser_Builder*) mergeFrom:(MUser*) other {
  if (other == [MUser defaultInstance]) {
    return self;
  }
  if (other.hasId) {
    [self setId:other.id];
  }
  if (other.hasAccount) {
    [self setAccount:other.account];
  }
  if (other.hasHeadImg) {
    [self setHeadImg:other.headImg];
  }
  if (other.hasNickname) {
    [self setNickname:other.nickname];
  }
  if (other.hasVerify) {
    [self setVerify:other.verify];
  }
  if (other.hasSex) {
    [self setSex:other.sex];
  }
  if (other.hasBirthday) {
    [self setBirthday:other.birthday];
  }
  if (other.mutableTagsList.count > 0) {
    if (result.mutableTagsList == nil) {
      result.mutableTagsList = [NSMutableArray array];
    }
    [result.mutableTagsList addObjectsFromArray:other.mutableTagsList];
  }
  if (other.hasFlower) {
    [self setFlower:other.flower];
  }
  if (other.hasBelong) {
    [self setBelong:other.belong];
  }
  if (other.hasIsV) {
    [self setIsV:other.isV];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (MUser_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (MUser_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  PBUnknownFieldSet_Builder* unknownFields = [PBUnknownFieldSet builderWithUnknownFields:self.unknownFields];
  while (YES) {
    int32_t tag = [input readTag];
    switch (tag) {
      case 0:
        [self setUnknownFields:[unknownFields build]];
        return self;
      default: {
        if (![self parseUnknownField:input unknownFields:unknownFields extensionRegistry:extensionRegistry tag:tag]) {
          [self setUnknownFields:[unknownFields build]];
          return self;
        }
        break;
      }
      case 10: {
        [self setId:[input readString]];
        break;
      }
      case 18: {
        [self setAccount:[input readString]];
        break;
      }
      case 26: {
        [self setHeadImg:[input readString]];
        break;
      }
      case 34: {
        [self setNickname:[input readString]];
        break;
      }
      case 42: {
        [self setVerify:[input readString]];
        break;
      }
      case 48: {
        [self setSex:[input readInt32]];
        break;
      }
      case 58: {
        [self setBirthday:[input readString]];
        break;
      }
      case 66: {
        [self addTags:[input readString]];
        break;
      }
      case 72: {
        [self setFlower:[input readInt32]];
        break;
      }
      case 82: {
        [self setBelong:[input readString]];
        break;
      }
      case 88: {
        [self setIsV:[input readInt32]];
        break;
      }
    }
  }
}
- (BOOL) hasId {
  return result.hasId;
}
- (NSString*) id {
  return result.id;
}
- (MUser_Builder*) setId:(NSString*) value {
  result.hasId = YES;
  result.id = value;
  return self;
}
- (MUser_Builder*) clearId {
  result.hasId = NO;
  result.id = @"";
  return self;
}
- (BOOL) hasAccount {
  return result.hasAccount;
}
- (NSString*) account {
  return result.account;
}
- (MUser_Builder*) setAccount:(NSString*) value {
  result.hasAccount = YES;
  result.account = value;
  return self;
}
- (MUser_Builder*) clearAccount {
  result.hasAccount = NO;
  result.account = @"";
  return self;
}
- (BOOL) hasHeadImg {
  return result.hasHeadImg;
}
- (NSString*) headImg {
  return result.headImg;
}
- (MUser_Builder*) setHeadImg:(NSString*) value {
  result.hasHeadImg = YES;
  result.headImg = value;
  return self;
}
- (MUser_Builder*) clearHeadImg {
  result.hasHeadImg = NO;
  result.headImg = @"";
  return self;
}
- (BOOL) hasNickname {
  return result.hasNickname;
}
- (NSString*) nickname {
  return result.nickname;
}
- (MUser_Builder*) setNickname:(NSString*) value {
  result.hasNickname = YES;
  result.nickname = value;
  return self;
}
- (MUser_Builder*) clearNickname {
  result.hasNickname = NO;
  result.nickname = @"";
  return self;
}
- (BOOL) hasVerify {
  return result.hasVerify;
}
- (NSString*) verify {
  return result.verify;
}
- (MUser_Builder*) setVerify:(NSString*) value {
  result.hasVerify = YES;
  result.verify = value;
  return self;
}
- (MUser_Builder*) clearVerify {
  result.hasVerify = NO;
  result.verify = @"";
  return self;
}
- (BOOL) hasSex {
  return result.hasSex;
}
- (int32_t) sex {
  return result.sex;
}
- (MUser_Builder*) setSex:(int32_t) value {
  result.hasSex = YES;
  result.sex = value;
  return self;
}
- (MUser_Builder*) clearSex {
  result.hasSex = NO;
  result.sex = 0;
  return self;
}
- (BOOL) hasBirthday {
  return result.hasBirthday;
}
- (NSString*) birthday {
  return result.birthday;
}
- (MUser_Builder*) setBirthday:(NSString*) value {
  result.hasBirthday = YES;
  result.birthday = value;
  return self;
}
- (MUser_Builder*) clearBirthday {
  result.hasBirthday = NO;
  result.birthday = @"";
  return self;
}
- (NSArray*) tagsList {
  if (result.mutableTagsList == nil) {
    return [NSArray array];
  }
  return result.mutableTagsList;
}
- (NSString*) tagsAtIndex:(int32_t) index {
  return [result tagsAtIndex:index];
}
- (MUser_Builder*) replaceTagsAtIndex:(int32_t) index with:(NSString*) value {
  [result.mutableTagsList replaceObjectAtIndex:index withObject:value];
  return self;
}
- (MUser_Builder*) addTags:(NSString*) value {
  if (result.mutableTagsList == nil) {
    result.mutableTagsList = [NSMutableArray array];
  }
  [result.mutableTagsList addObject:value];
  return self;
}
- (MUser_Builder*) addAllTags:(NSArray*) values {
  if (result.mutableTagsList == nil) {
    result.mutableTagsList = [NSMutableArray array];
  }
  [result.mutableTagsList addObjectsFromArray:values];
  return self;
}
- (MUser_Builder*) clearTagsList {
  result.mutableTagsList = nil;
  return self;
}
- (BOOL) hasFlower {
  return result.hasFlower;
}
- (int32_t) flower {
  return result.flower;
}
- (MUser_Builder*) setFlower:(int32_t) value {
  result.hasFlower = YES;
  result.flower = value;
  return self;
}
- (MUser_Builder*) clearFlower {
  result.hasFlower = NO;
  result.flower = 0;
  return self;
}
- (BOOL) hasBelong {
  return result.hasBelong;
}
- (NSString*) belong {
  return result.belong;
}
- (MUser_Builder*) setBelong:(NSString*) value {
  result.hasBelong = YES;
  result.belong = value;
  return self;
}
- (MUser_Builder*) clearBelong {
  result.hasBelong = NO;
  result.belong = @"";
  return self;
}
- (BOOL) hasIsV {
  return result.hasIsV;
}
- (int32_t) isV {
  return result.isV;
}
- (MUser_Builder*) setIsV:(int32_t) value {
  result.hasIsV = YES;
  result.isV = value;
  return self;
}
- (MUser_Builder*) clearIsV {
  result.hasIsV = NO;
  result.isV = 0;
  return self;
}
@end

