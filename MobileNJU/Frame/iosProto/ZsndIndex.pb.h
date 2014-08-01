// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class MFocus;
@class MFocus_Builder;
@class MIndex;
@class MIndex_Builder;
@class MMdoule;
@class MMdoule_Builder;
@class MUnread;
@class MUnread_Builder;

@interface ZsndIndexRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface MIndex : PBGeneratedMessage {
@private
  NSMutableArray* mutableFocusList;
  NSMutableArray* mutableModuleList;
}
- (NSArray*) focusList;
- (MFocus*) focusAtIndex:(int32_t) index;
- (NSArray*) moduleList;
- (MMdoule*) moduleAtIndex:(int32_t) index;

+ (MIndex*) defaultInstance;
- (MIndex*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MIndex_Builder*) builder;
+ (MIndex_Builder*) builder;
+ (MIndex_Builder*) builderWithPrototype:(MIndex*) prototype;

+ (MIndex*) parseFromData:(NSData*) data;
+ (MIndex*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MIndex*) parseFromInputStream:(NSInputStream*) input;
+ (MIndex*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MIndex*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MIndex*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MIndex_Builder : PBGeneratedMessage_Builder {
@private
  MIndex* result;
}

- (MIndex*) defaultInstance;

- (MIndex_Builder*) clear;
- (MIndex_Builder*) clone;

- (MIndex*) build;
- (MIndex*) buildPartial;

- (MIndex_Builder*) mergeFrom:(MIndex*) other;
- (MIndex_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MIndex_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (NSArray*) focusList;
- (MFocus*) focusAtIndex:(int32_t) index;
- (MIndex_Builder*) replaceFocusAtIndex:(int32_t) index with:(MFocus*) value;
- (MIndex_Builder*) addFocus:(MFocus*) value;
- (MIndex_Builder*) addAllFocus:(NSArray*) values;
- (MIndex_Builder*) clearFocusList;

- (NSArray*) moduleList;
- (MMdoule*) moduleAtIndex:(int32_t) index;
- (MIndex_Builder*) replaceModuleAtIndex:(int32_t) index with:(MMdoule*) value;
- (MIndex_Builder*) addModule:(MMdoule*) value;
- (MIndex_Builder*) addAllModule:(NSArray*) values;
- (MIndex_Builder*) clearModuleList;
@end

@interface MFocus : PBGeneratedMessage {
@private
  BOOL hasId_:1;
  BOOL hasImg_:1;
  NSString* id;
  NSString* img;
}
- (BOOL) hasId;
- (BOOL) hasImg;
@property (readonly, retain) NSString* id;
@property (readonly, retain) NSString* img;

+ (MFocus*) defaultInstance;
- (MFocus*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MFocus_Builder*) builder;
+ (MFocus_Builder*) builder;
+ (MFocus_Builder*) builderWithPrototype:(MFocus*) prototype;

+ (MFocus*) parseFromData:(NSData*) data;
+ (MFocus*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MFocus*) parseFromInputStream:(NSInputStream*) input;
+ (MFocus*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MFocus*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MFocus*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MFocus_Builder : PBGeneratedMessage_Builder {
@private
  MFocus* result;
}

- (MFocus*) defaultInstance;

- (MFocus_Builder*) clear;
- (MFocus_Builder*) clone;

- (MFocus*) build;
- (MFocus*) buildPartial;

- (MFocus_Builder*) mergeFrom:(MFocus*) other;
- (MFocus_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MFocus_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasId;
- (NSString*) id;
- (MFocus_Builder*) setId:(NSString*) value;
- (MFocus_Builder*) clearId;

- (BOOL) hasImg;
- (NSString*) img;
- (MFocus_Builder*) setImg:(NSString*) value;
- (MFocus_Builder*) clearImg;
@end

@interface MMdoule : PBGeneratedMessage {
@private
  BOOL hasIsRecommend_:1;
  BOOL hasId_:1;
  BOOL hasImg_:1;
  BOOL hasName_:1;
  BOOL hasDesc_:1;
  BOOL hasCode_:1;
  int32_t isRecommend;
  NSString* id;
  NSString* img;
  NSString* name;
  NSString* desc;
  NSString* code;
}
- (BOOL) hasId;
- (BOOL) hasImg;
- (BOOL) hasName;
- (BOOL) hasDesc;
- (BOOL) hasCode;
- (BOOL) hasIsRecommend;
@property (readonly, retain) NSString* id;
@property (readonly, retain) NSString* img;
@property (readonly, retain) NSString* name;
@property (readonly, retain) NSString* desc;
@property (readonly, retain) NSString* code;
@property (readonly) int32_t isRecommend;

+ (MMdoule*) defaultInstance;
- (MMdoule*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MMdoule_Builder*) builder;
+ (MMdoule_Builder*) builder;
+ (MMdoule_Builder*) builderWithPrototype:(MMdoule*) prototype;

+ (MMdoule*) parseFromData:(NSData*) data;
+ (MMdoule*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MMdoule*) parseFromInputStream:(NSInputStream*) input;
+ (MMdoule*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MMdoule*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MMdoule*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MMdoule_Builder : PBGeneratedMessage_Builder {
@private
  MMdoule* result;
}

- (MMdoule*) defaultInstance;

- (MMdoule_Builder*) clear;
- (MMdoule_Builder*) clone;

- (MMdoule*) build;
- (MMdoule*) buildPartial;

- (MMdoule_Builder*) mergeFrom:(MMdoule*) other;
- (MMdoule_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MMdoule_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasId;
- (NSString*) id;
- (MMdoule_Builder*) setId:(NSString*) value;
- (MMdoule_Builder*) clearId;

- (BOOL) hasImg;
- (NSString*) img;
- (MMdoule_Builder*) setImg:(NSString*) value;
- (MMdoule_Builder*) clearImg;

- (BOOL) hasName;
- (NSString*) name;
- (MMdoule_Builder*) setName:(NSString*) value;
- (MMdoule_Builder*) clearName;

- (BOOL) hasDesc;
- (NSString*) desc;
- (MMdoule_Builder*) setDesc:(NSString*) value;
- (MMdoule_Builder*) clearDesc;

- (BOOL) hasCode;
- (NSString*) code;
- (MMdoule_Builder*) setCode:(NSString*) value;
- (MMdoule_Builder*) clearCode;

- (BOOL) hasIsRecommend;
- (int32_t) isRecommend;
- (MMdoule_Builder*) setIsRecommend:(int32_t) value;
- (MMdoule_Builder*) clearIsRecommend;
@end

@interface MUnread : PBGeneratedMessage {
@private
  BOOL hasModule1_:1;
  BOOL hasModule2_:1;
  BOOL hasModule3_:1;
  BOOL hasModule4_:1;
  BOOL hasModule5_:1;
  BOOL hasModule6_:1;
  int32_t module1;
  int32_t module2;
  int32_t module3;
  int32_t module4;
  int32_t module5;
  int32_t module6;
}
- (BOOL) hasModule1;
- (BOOL) hasModule2;
- (BOOL) hasModule3;
- (BOOL) hasModule4;
- (BOOL) hasModule5;
- (BOOL) hasModule6;
@property (readonly) int32_t module1;
@property (readonly) int32_t module2;
@property (readonly) int32_t module3;
@property (readonly) int32_t module4;
@property (readonly) int32_t module5;
@property (readonly) int32_t module6;

+ (MUnread*) defaultInstance;
- (MUnread*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MUnread_Builder*) builder;
+ (MUnread_Builder*) builder;
+ (MUnread_Builder*) builderWithPrototype:(MUnread*) prototype;

+ (MUnread*) parseFromData:(NSData*) data;
+ (MUnread*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MUnread*) parseFromInputStream:(NSInputStream*) input;
+ (MUnread*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MUnread*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MUnread*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MUnread_Builder : PBGeneratedMessage_Builder {
@private
  MUnread* result;
}

- (MUnread*) defaultInstance;

- (MUnread_Builder*) clear;
- (MUnread_Builder*) clone;

- (MUnread*) build;
- (MUnread*) buildPartial;

- (MUnread_Builder*) mergeFrom:(MUnread*) other;
- (MUnread_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MUnread_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasModule1;
- (int32_t) module1;
- (MUnread_Builder*) setModule1:(int32_t) value;
- (MUnread_Builder*) clearModule1;

- (BOOL) hasModule2;
- (int32_t) module2;
- (MUnread_Builder*) setModule2:(int32_t) value;
- (MUnread_Builder*) clearModule2;

- (BOOL) hasModule3;
- (int32_t) module3;
- (MUnread_Builder*) setModule3:(int32_t) value;
- (MUnread_Builder*) clearModule3;

- (BOOL) hasModule4;
- (int32_t) module4;
- (MUnread_Builder*) setModule4:(int32_t) value;
- (MUnread_Builder*) clearModule4;

- (BOOL) hasModule5;
- (int32_t) module5;
- (MUnread_Builder*) setModule5:(int32_t) value;
- (MUnread_Builder*) clearModule5;

- (BOOL) hasModule6;
- (int32_t) module6;
- (MUnread_Builder*) setModule6:(int32_t) value;
- (MUnread_Builder*) clearModule6;
@end

