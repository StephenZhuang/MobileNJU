// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ZsndLost.pb.h"

@implementation ZsndLostRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [ZsndLostRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface MLostAndFoundList ()
@property (retain) NSMutableArray* mutableLfList;
@end

@implementation MLostAndFoundList

@synthesize mutableLfList;
- (void) dealloc {
  self.mutableLfList = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
  }
  return self;
}
static MLostAndFoundList* defaultMLostAndFoundListInstance = nil;
+ (void) initialize {
  if (self == [MLostAndFoundList class]) {
    defaultMLostAndFoundListInstance = [[MLostAndFoundList alloc] init];
  }
}
+ (MLostAndFoundList*) defaultInstance {
  return defaultMLostAndFoundListInstance;
}
- (MLostAndFoundList*) defaultInstance {
  return defaultMLostAndFoundListInstance;
}
- (NSArray*) lfList {
  return mutableLfList;
}
- (MLostAndFound*) lfAtIndex:(int32_t) index {
  id value = [mutableLfList objectAtIndex:index];
  return value;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  for (MLostAndFound* element in self.lfList) {
    [output writeMessage:1 value:element];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size = memoizedSerializedSize;
  if (size != -1) {
    return size;
  }

  size = 0;
  for (MLostAndFound* element in self.lfList) {
    size += computeMessageSize(1, element);
  }
  size += self.unknownFields.serializedSize;
  memoizedSerializedSize = size;
  return size;
}
+ (MLostAndFoundList*) parseFromData:(NSData*) data {
  return (MLostAndFoundList*)[[[MLostAndFoundList builder] mergeFromData:data] build];
}
+ (MLostAndFoundList*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (MLostAndFoundList*)[[[MLostAndFoundList builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (MLostAndFoundList*) parseFromInputStream:(NSInputStream*) input {
  return (MLostAndFoundList*)[[[MLostAndFoundList builder] mergeFromInputStream:input] build];
}
+ (MLostAndFoundList*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (MLostAndFoundList*)[[[MLostAndFoundList builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (MLostAndFoundList*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (MLostAndFoundList*)[[[MLostAndFoundList builder] mergeFromCodedInputStream:input] build];
}
+ (MLostAndFoundList*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (MLostAndFoundList*)[[[MLostAndFoundList builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (MLostAndFoundList_Builder*) builder {
  return [[[MLostAndFoundList_Builder alloc] init] autorelease];
}
+ (MLostAndFoundList_Builder*) builderWithPrototype:(MLostAndFoundList*) prototype {
  return [[MLostAndFoundList builder] mergeFrom:prototype];
}
- (MLostAndFoundList_Builder*) builder {
  return [MLostAndFoundList builder];
}
@end

@interface MLostAndFoundList_Builder()
@property (retain) MLostAndFoundList* result;
@end

@implementation MLostAndFoundList_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[MLostAndFoundList alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (MLostAndFoundList_Builder*) clear {
  self.result = [[[MLostAndFoundList alloc] init] autorelease];
  return self;
}
- (MLostAndFoundList_Builder*) clone {
  return [MLostAndFoundList builderWithPrototype:result];
}
- (MLostAndFoundList*) defaultInstance {
  return [MLostAndFoundList defaultInstance];
}
- (MLostAndFoundList*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (MLostAndFoundList*) buildPartial {
  MLostAndFoundList* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (MLostAndFoundList_Builder*) mergeFrom:(MLostAndFoundList*) other {
  if (other == [MLostAndFoundList defaultInstance]) {
    return self;
  }
  if (other.mutableLfList.count > 0) {
    if (result.mutableLfList == nil) {
      result.mutableLfList = [NSMutableArray array];
    }
    [result.mutableLfList addObjectsFromArray:other.mutableLfList];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (MLostAndFoundList_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (MLostAndFoundList_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        MLostAndFound_Builder* subBuilder = [MLostAndFound builder];
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self addLf:[subBuilder buildPartial]];
        break;
      }
    }
  }
}
- (NSArray*) lfList {
  if (result.mutableLfList == nil) { return [NSArray array]; }
  return result.mutableLfList;
}
- (MLostAndFound*) lfAtIndex:(int32_t) index {
  return [result lfAtIndex:index];
}
- (MLostAndFoundList_Builder*) replaceLfAtIndex:(int32_t) index with:(MLostAndFound*) value {
  [result.mutableLfList replaceObjectAtIndex:index withObject:value];
  return self;
}
- (MLostAndFoundList_Builder*) addAllLf:(NSArray*) values {
  if (result.mutableLfList == nil) {
    result.mutableLfList = [NSMutableArray array];
  }
  [result.mutableLfList addObjectsFromArray:values];
  return self;
}
- (MLostAndFoundList_Builder*) clearLfList {
  result.mutableLfList = nil;
  return self;
}
- (MLostAndFoundList_Builder*) addLf:(MLostAndFound*) value {
  if (result.mutableLfList == nil) {
    result.mutableLfList = [NSMutableArray array];
  }
  [result.mutableLfList addObject:value];
  return self;
}
@end

@interface MLostAndFound ()
@property (retain) NSString* id;
@property (retain) NSString* address;
@property (retain) NSString* desc;
@property (retain) NSString* userid;
@property (retain) NSString* nickname;
@property (retain) NSString* contact;
@property (retain) NSString* time;
@property (retain) NSMutableArray* mutableImgList;
@end

@implementation MLostAndFound

- (BOOL) hasId {
  return !!hasId_;
}
- (void) setHasId:(BOOL) value {
  hasId_ = !!value;
}
@synthesize id;
- (BOOL) hasAddress {
  return !!hasAddress_;
}
- (void) setHasAddress:(BOOL) value {
  hasAddress_ = !!value;
}
@synthesize address;
- (BOOL) hasDesc {
  return !!hasDesc_;
}
- (void) setHasDesc:(BOOL) value {
  hasDesc_ = !!value;
}
@synthesize desc;
- (BOOL) hasUserid {
  return !!hasUserid_;
}
- (void) setHasUserid:(BOOL) value {
  hasUserid_ = !!value;
}
@synthesize userid;
- (BOOL) hasNickname {
  return !!hasNickname_;
}
- (void) setHasNickname:(BOOL) value {
  hasNickname_ = !!value;
}
@synthesize nickname;
- (BOOL) hasContact {
  return !!hasContact_;
}
- (void) setHasContact:(BOOL) value {
  hasContact_ = !!value;
}
@synthesize contact;
- (BOOL) hasTime {
  return !!hasTime_;
}
- (void) setHasTime:(BOOL) value {
  hasTime_ = !!value;
}
@synthesize time;
@synthesize mutableImgList;
- (void) dealloc {
  self.id = nil;
  self.address = nil;
  self.desc = nil;
  self.userid = nil;
  self.nickname = nil;
  self.contact = nil;
  self.time = nil;
  self.mutableImgList = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.id = @"";
    self.address = @"";
    self.desc = @"";
    self.userid = @"";
    self.nickname = @"";
    self.contact = @"";
    self.time = @"";
  }
  return self;
}
static MLostAndFound* defaultMLostAndFoundInstance = nil;
+ (void) initialize {
  if (self == [MLostAndFound class]) {
    defaultMLostAndFoundInstance = [[MLostAndFound alloc] init];
  }
}
+ (MLostAndFound*) defaultInstance {
  return defaultMLostAndFoundInstance;
}
- (MLostAndFound*) defaultInstance {
  return defaultMLostAndFoundInstance;
}
- (NSArray*) imgList {
  return mutableImgList;
}
- (NSString*) imgAtIndex:(int32_t) index {
  id value = [mutableImgList objectAtIndex:index];
  return value;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasId) {
    [output writeString:1 value:self.id];
  }
  if (self.hasAddress) {
    [output writeString:2 value:self.address];
  }
  if (self.hasDesc) {
    [output writeString:3 value:self.desc];
  }
  if (self.hasUserid) {
    [output writeString:4 value:self.userid];
  }
  if (self.hasNickname) {
    [output writeString:5 value:self.nickname];
  }
  if (self.hasContact) {
    [output writeString:6 value:self.contact];
  }
  if (self.hasTime) {
    [output writeString:7 value:self.time];
  }
  for (NSString* element in self.mutableImgList) {
    [output writeString:8 value:element];
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
  if (self.hasAddress) {
    size += computeStringSize(2, self.address);
  }
  if (self.hasDesc) {
    size += computeStringSize(3, self.desc);
  }
  if (self.hasUserid) {
    size += computeStringSize(4, self.userid);
  }
  if (self.hasNickname) {
    size += computeStringSize(5, self.nickname);
  }
  if (self.hasContact) {
    size += computeStringSize(6, self.contact);
  }
  if (self.hasTime) {
    size += computeStringSize(7, self.time);
  }
  {
    int32_t dataSize = 0;
    for (NSString* element in self.mutableImgList) {
      dataSize += computeStringSizeNoTag(element);
    }
    size += dataSize;
    size += 1 * self.mutableImgList.count;
  }
  size += self.unknownFields.serializedSize;
  memoizedSerializedSize = size;
  return size;
}
+ (MLostAndFound*) parseFromData:(NSData*) data {
  return (MLostAndFound*)[[[MLostAndFound builder] mergeFromData:data] build];
}
+ (MLostAndFound*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (MLostAndFound*)[[[MLostAndFound builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (MLostAndFound*) parseFromInputStream:(NSInputStream*) input {
  return (MLostAndFound*)[[[MLostAndFound builder] mergeFromInputStream:input] build];
}
+ (MLostAndFound*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (MLostAndFound*)[[[MLostAndFound builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (MLostAndFound*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (MLostAndFound*)[[[MLostAndFound builder] mergeFromCodedInputStream:input] build];
}
+ (MLostAndFound*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (MLostAndFound*)[[[MLostAndFound builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (MLostAndFound_Builder*) builder {
  return [[[MLostAndFound_Builder alloc] init] autorelease];
}
+ (MLostAndFound_Builder*) builderWithPrototype:(MLostAndFound*) prototype {
  return [[MLostAndFound builder] mergeFrom:prototype];
}
- (MLostAndFound_Builder*) builder {
  return [MLostAndFound builder];
}
@end

@interface MLostAndFound_Builder()
@property (retain) MLostAndFound* result;
@end

@implementation MLostAndFound_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[MLostAndFound alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (MLostAndFound_Builder*) clear {
  self.result = [[[MLostAndFound alloc] init] autorelease];
  return self;
}
- (MLostAndFound_Builder*) clone {
  return [MLostAndFound builderWithPrototype:result];
}
- (MLostAndFound*) defaultInstance {
  return [MLostAndFound defaultInstance];
}
- (MLostAndFound*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (MLostAndFound*) buildPartial {
  MLostAndFound* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (MLostAndFound_Builder*) mergeFrom:(MLostAndFound*) other {
  if (other == [MLostAndFound defaultInstance]) {
    return self;
  }
  if (other.hasId) {
    [self setId:other.id];
  }
  if (other.hasAddress) {
    [self setAddress:other.address];
  }
  if (other.hasDesc) {
    [self setDesc:other.desc];
  }
  if (other.hasUserid) {
    [self setUserid:other.userid];
  }
  if (other.hasNickname) {
    [self setNickname:other.nickname];
  }
  if (other.hasContact) {
    [self setContact:other.contact];
  }
  if (other.hasTime) {
    [self setTime:other.time];
  }
  if (other.mutableImgList.count > 0) {
    if (result.mutableImgList == nil) {
      result.mutableImgList = [NSMutableArray array];
    }
    [result.mutableImgList addObjectsFromArray:other.mutableImgList];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (MLostAndFound_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (MLostAndFound_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self setAddress:[input readString]];
        break;
      }
      case 26: {
        [self setDesc:[input readString]];
        break;
      }
      case 34: {
        [self setUserid:[input readString]];
        break;
      }
      case 42: {
        [self setNickname:[input readString]];
        break;
      }
      case 50: {
        [self setContact:[input readString]];
        break;
      }
      case 58: {
        [self setTime:[input readString]];
        break;
      }
      case 66: {
        [self addImg:[input readString]];
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
- (MLostAndFound_Builder*) setId:(NSString*) value {
  result.hasId = YES;
  result.id = value;
  return self;
}
- (MLostAndFound_Builder*) clearId {
  result.hasId = NO;
  result.id = @"";
  return self;
}
- (BOOL) hasAddress {
  return result.hasAddress;
}
- (NSString*) address {
  return result.address;
}
- (MLostAndFound_Builder*) setAddress:(NSString*) value {
  result.hasAddress = YES;
  result.address = value;
  return self;
}
- (MLostAndFound_Builder*) clearAddress {
  result.hasAddress = NO;
  result.address = @"";
  return self;
}
- (BOOL) hasDesc {
  return result.hasDesc;
}
- (NSString*) desc {
  return result.desc;
}
- (MLostAndFound_Builder*) setDesc:(NSString*) value {
  result.hasDesc = YES;
  result.desc = value;
  return self;
}
- (MLostAndFound_Builder*) clearDesc {
  result.hasDesc = NO;
  result.desc = @"";
  return self;
}
- (BOOL) hasUserid {
  return result.hasUserid;
}
- (NSString*) userid {
  return result.userid;
}
- (MLostAndFound_Builder*) setUserid:(NSString*) value {
  result.hasUserid = YES;
  result.userid = value;
  return self;
}
- (MLostAndFound_Builder*) clearUserid {
  result.hasUserid = NO;
  result.userid = @"";
  return self;
}
- (BOOL) hasNickname {
  return result.hasNickname;
}
- (NSString*) nickname {
  return result.nickname;
}
- (MLostAndFound_Builder*) setNickname:(NSString*) value {
  result.hasNickname = YES;
  result.nickname = value;
  return self;
}
- (MLostAndFound_Builder*) clearNickname {
  result.hasNickname = NO;
  result.nickname = @"";
  return self;
}
- (BOOL) hasContact {
  return result.hasContact;
}
- (NSString*) contact {
  return result.contact;
}
- (MLostAndFound_Builder*) setContact:(NSString*) value {
  result.hasContact = YES;
  result.contact = value;
  return self;
}
- (MLostAndFound_Builder*) clearContact {
  result.hasContact = NO;
  result.contact = @"";
  return self;
}
- (BOOL) hasTime {
  return result.hasTime;
}
- (NSString*) time {
  return result.time;
}
- (MLostAndFound_Builder*) setTime:(NSString*) value {
  result.hasTime = YES;
  result.time = value;
  return self;
}
- (MLostAndFound_Builder*) clearTime {
  result.hasTime = NO;
  result.time = @"";
  return self;
}
- (NSArray*) imgList {
  if (result.mutableImgList == nil) {
    return [NSArray array];
  }
  return result.mutableImgList;
}
- (NSString*) imgAtIndex:(int32_t) index {
  return [result imgAtIndex:index];
}
- (MLostAndFound_Builder*) replaceImgAtIndex:(int32_t) index with:(NSString*) value {
  [result.mutableImgList replaceObjectAtIndex:index withObject:value];
  return self;
}
- (MLostAndFound_Builder*) addImg:(NSString*) value {
  if (result.mutableImgList == nil) {
    result.mutableImgList = [NSMutableArray array];
  }
  [result.mutableImgList addObject:value];
  return self;
}
- (MLostAndFound_Builder*) addAllImg:(NSArray*) values {
  if (result.mutableImgList == nil) {
    result.mutableImgList = [NSMutableArray array];
  }
  [result.mutableImgList addObjectsFromArray:values];
  return self;
}
- (MLostAndFound_Builder*) clearImgList {
  result.mutableImgList = nil;
  return self;
}
@end

@interface MAddLostOrFound ()
@property int32_t type;
@property (retain) NSString* address;
@property (retain) NSString* desc;
@property (retain) NSString* contact;
@property (retain) NSString* time;
@property (retain) NSData* img1;
@property (retain) NSData* img2;
@property (retain) NSData* img3;
@property (retain) NSData* img4;
@end

@implementation MAddLostOrFound

- (BOOL) hasType {
  return !!hasType_;
}
- (void) setHasType:(BOOL) value {
  hasType_ = !!value;
}
@synthesize type;
- (BOOL) hasAddress {
  return !!hasAddress_;
}
- (void) setHasAddress:(BOOL) value {
  hasAddress_ = !!value;
}
@synthesize address;
- (BOOL) hasDesc {
  return !!hasDesc_;
}
- (void) setHasDesc:(BOOL) value {
  hasDesc_ = !!value;
}
@synthesize desc;
- (BOOL) hasContact {
  return !!hasContact_;
}
- (void) setHasContact:(BOOL) value {
  hasContact_ = !!value;
}
@synthesize contact;
- (BOOL) hasTime {
  return !!hasTime_;
}
- (void) setHasTime:(BOOL) value {
  hasTime_ = !!value;
}
@synthesize time;
- (BOOL) hasImg1 {
  return !!hasImg1_;
}
- (void) setHasImg1:(BOOL) value {
  hasImg1_ = !!value;
}
@synthesize img1;
- (BOOL) hasImg2 {
  return !!hasImg2_;
}
- (void) setHasImg2:(BOOL) value {
  hasImg2_ = !!value;
}
@synthesize img2;
- (BOOL) hasImg3 {
  return !!hasImg3_;
}
- (void) setHasImg3:(BOOL) value {
  hasImg3_ = !!value;
}
@synthesize img3;
- (BOOL) hasImg4 {
  return !!hasImg4_;
}
- (void) setHasImg4:(BOOL) value {
  hasImg4_ = !!value;
}
@synthesize img4;
- (void) dealloc {
  self.address = nil;
  self.desc = nil;
  self.contact = nil;
  self.time = nil;
  self.img1 = nil;
  self.img2 = nil;
  self.img3 = nil;
  self.img4 = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.type = 0;
    self.address = @"";
    self.desc = @"";
    self.contact = @"";
    self.time = @"";
    self.img1 = [NSData data];
    self.img2 = [NSData data];
    self.img3 = [NSData data];
    self.img4 = [NSData data];
  }
  return self;
}
static MAddLostOrFound* defaultMAddLostOrFoundInstance = nil;
+ (void) initialize {
  if (self == [MAddLostOrFound class]) {
    defaultMAddLostOrFoundInstance = [[MAddLostOrFound alloc] init];
  }
}
+ (MAddLostOrFound*) defaultInstance {
  return defaultMAddLostOrFoundInstance;
}
- (MAddLostOrFound*) defaultInstance {
  return defaultMAddLostOrFoundInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasType) {
    [output writeInt32:1 value:self.type];
  }
  if (self.hasAddress) {
    [output writeString:2 value:self.address];
  }
  if (self.hasDesc) {
    [output writeString:3 value:self.desc];
  }
  if (self.hasContact) {
    [output writeString:4 value:self.contact];
  }
  if (self.hasTime) {
    [output writeString:5 value:self.time];
  }
  if (self.hasImg1) {
    [output writeData:6 value:self.img1];
  }
  if (self.hasImg2) {
    [output writeData:7 value:self.img2];
  }
  if (self.hasImg3) {
    [output writeData:8 value:self.img3];
  }
  if (self.hasImg4) {
    [output writeData:9 value:self.img4];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size = memoizedSerializedSize;
  if (size != -1) {
    return size;
  }

  size = 0;
  if (self.hasType) {
    size += computeInt32Size(1, self.type);
  }
  if (self.hasAddress) {
    size += computeStringSize(2, self.address);
  }
  if (self.hasDesc) {
    size += computeStringSize(3, self.desc);
  }
  if (self.hasContact) {
    size += computeStringSize(4, self.contact);
  }
  if (self.hasTime) {
    size += computeStringSize(5, self.time);
  }
  if (self.hasImg1) {
    size += computeDataSize(6, self.img1);
  }
  if (self.hasImg2) {
    size += computeDataSize(7, self.img2);
  }
  if (self.hasImg3) {
    size += computeDataSize(8, self.img3);
  }
  if (self.hasImg4) {
    size += computeDataSize(9, self.img4);
  }
  size += self.unknownFields.serializedSize;
  memoizedSerializedSize = size;
  return size;
}
+ (MAddLostOrFound*) parseFromData:(NSData*) data {
  return (MAddLostOrFound*)[[[MAddLostOrFound builder] mergeFromData:data] build];
}
+ (MAddLostOrFound*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (MAddLostOrFound*)[[[MAddLostOrFound builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (MAddLostOrFound*) parseFromInputStream:(NSInputStream*) input {
  return (MAddLostOrFound*)[[[MAddLostOrFound builder] mergeFromInputStream:input] build];
}
+ (MAddLostOrFound*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (MAddLostOrFound*)[[[MAddLostOrFound builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (MAddLostOrFound*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (MAddLostOrFound*)[[[MAddLostOrFound builder] mergeFromCodedInputStream:input] build];
}
+ (MAddLostOrFound*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (MAddLostOrFound*)[[[MAddLostOrFound builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (MAddLostOrFound_Builder*) builder {
  return [[[MAddLostOrFound_Builder alloc] init] autorelease];
}
+ (MAddLostOrFound_Builder*) builderWithPrototype:(MAddLostOrFound*) prototype {
  return [[MAddLostOrFound builder] mergeFrom:prototype];
}
- (MAddLostOrFound_Builder*) builder {
  return [MAddLostOrFound builder];
}
@end

@interface MAddLostOrFound_Builder()
@property (retain) MAddLostOrFound* result;
@end

@implementation MAddLostOrFound_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[MAddLostOrFound alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (MAddLostOrFound_Builder*) clear {
  self.result = [[[MAddLostOrFound alloc] init] autorelease];
  return self;
}
- (MAddLostOrFound_Builder*) clone {
  return [MAddLostOrFound builderWithPrototype:result];
}
- (MAddLostOrFound*) defaultInstance {
  return [MAddLostOrFound defaultInstance];
}
- (MAddLostOrFound*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (MAddLostOrFound*) buildPartial {
  MAddLostOrFound* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (MAddLostOrFound_Builder*) mergeFrom:(MAddLostOrFound*) other {
  if (other == [MAddLostOrFound defaultInstance]) {
    return self;
  }
  if (other.hasType) {
    [self setType:other.type];
  }
  if (other.hasAddress) {
    [self setAddress:other.address];
  }
  if (other.hasDesc) {
    [self setDesc:other.desc];
  }
  if (other.hasContact) {
    [self setContact:other.contact];
  }
  if (other.hasTime) {
    [self setTime:other.time];
  }
  if (other.hasImg1) {
    [self setImg1:other.img1];
  }
  if (other.hasImg2) {
    [self setImg2:other.img2];
  }
  if (other.hasImg3) {
    [self setImg3:other.img3];
  }
  if (other.hasImg4) {
    [self setImg4:other.img4];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (MAddLostOrFound_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (MAddLostOrFound_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
      case 8: {
        [self setType:[input readInt32]];
        break;
      }
      case 18: {
        [self setAddress:[input readString]];
        break;
      }
      case 26: {
        [self setDesc:[input readString]];
        break;
      }
      case 34: {
        [self setContact:[input readString]];
        break;
      }
      case 42: {
        [self setTime:[input readString]];
        break;
      }
      case 50: {
        [self setImg1:[input readData]];
        break;
      }
      case 58: {
        [self setImg2:[input readData]];
        break;
      }
      case 66: {
        [self setImg3:[input readData]];
        break;
      }
      case 74: {
        [self setImg4:[input readData]];
        break;
      }
    }
  }
}
- (BOOL) hasType {
  return result.hasType;
}
- (int32_t) type {
  return result.type;
}
- (MAddLostOrFound_Builder*) setType:(int32_t) value {
  result.hasType = YES;
  result.type = value;
  return self;
}
- (MAddLostOrFound_Builder*) clearType {
  result.hasType = NO;
  result.type = 0;
  return self;
}
- (BOOL) hasAddress {
  return result.hasAddress;
}
- (NSString*) address {
  return result.address;
}
- (MAddLostOrFound_Builder*) setAddress:(NSString*) value {
  result.hasAddress = YES;
  result.address = value;
  return self;
}
- (MAddLostOrFound_Builder*) clearAddress {
  result.hasAddress = NO;
  result.address = @"";
  return self;
}
- (BOOL) hasDesc {
  return result.hasDesc;
}
- (NSString*) desc {
  return result.desc;
}
- (MAddLostOrFound_Builder*) setDesc:(NSString*) value {
  result.hasDesc = YES;
  result.desc = value;
  return self;
}
- (MAddLostOrFound_Builder*) clearDesc {
  result.hasDesc = NO;
  result.desc = @"";
  return self;
}
- (BOOL) hasContact {
  return result.hasContact;
}
- (NSString*) contact {
  return result.contact;
}
- (MAddLostOrFound_Builder*) setContact:(NSString*) value {
  result.hasContact = YES;
  result.contact = value;
  return self;
}
- (MAddLostOrFound_Builder*) clearContact {
  result.hasContact = NO;
  result.contact = @"";
  return self;
}
- (BOOL) hasTime {
  return result.hasTime;
}
- (NSString*) time {
  return result.time;
}
- (MAddLostOrFound_Builder*) setTime:(NSString*) value {
  result.hasTime = YES;
  result.time = value;
  return self;
}
- (MAddLostOrFound_Builder*) clearTime {
  result.hasTime = NO;
  result.time = @"";
  return self;
}
- (BOOL) hasImg1 {
  return result.hasImg1;
}
- (NSData*) img1 {
  return result.img1;
}
- (MAddLostOrFound_Builder*) setImg1:(NSData*) value {
  result.hasImg1 = YES;
  result.img1 = value;
  return self;
}
- (MAddLostOrFound_Builder*) clearImg1 {
  result.hasImg1 = NO;
  result.img1 = [NSData data];
  return self;
}
- (BOOL) hasImg2 {
  return result.hasImg2;
}
- (NSData*) img2 {
  return result.img2;
}
- (MAddLostOrFound_Builder*) setImg2:(NSData*) value {
  result.hasImg2 = YES;
  result.img2 = value;
  return self;
}
- (MAddLostOrFound_Builder*) clearImg2 {
  result.hasImg2 = NO;
  result.img2 = [NSData data];
  return self;
}
- (BOOL) hasImg3 {
  return result.hasImg3;
}
- (NSData*) img3 {
  return result.img3;
}
- (MAddLostOrFound_Builder*) setImg3:(NSData*) value {
  result.hasImg3 = YES;
  result.img3 = value;
  return self;
}
- (MAddLostOrFound_Builder*) clearImg3 {
  result.hasImg3 = NO;
  result.img3 = [NSData data];
  return self;
}
- (BOOL) hasImg4 {
  return result.hasImg4;
}
- (NSData*) img4 {
  return result.img4;
}
- (MAddLostOrFound_Builder*) setImg4:(NSData*) value {
  result.hasImg4 = YES;
  result.img4 = value;
  return self;
}
- (MAddLostOrFound_Builder*) clearImg4 {
  result.hasImg4 = NO;
  result.img4 = [NSData data];
  return self;
}
@end

