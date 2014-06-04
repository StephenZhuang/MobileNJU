// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class MChat;
@class MChatIndex;
@class MChatIndex_Builder;
@class MChatList;
@class MChatList_Builder;
@class MChat_Builder;
@class MChats;
@class MChats_Builder;
@class MMatch;
@class MMatch_Builder;

@interface ZsndChatRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface MChatList : PBGeneratedMessage {
@private
  NSMutableArray* mutableChatList;
}
- (NSArray*) chatList;
- (MChatIndex*) chatAtIndex:(int32_t) index;

+ (MChatList*) defaultInstance;
- (MChatList*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MChatList_Builder*) builder;
+ (MChatList_Builder*) builder;
+ (MChatList_Builder*) builderWithPrototype:(MChatList*) prototype;

+ (MChatList*) parseFromData:(NSData*) data;
+ (MChatList*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MChatList*) parseFromInputStream:(NSInputStream*) input;
+ (MChatList*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MChatList*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MChatList*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MChatList_Builder : PBGeneratedMessage_Builder {
@private
  MChatList* result;
}

- (MChatList*) defaultInstance;

- (MChatList_Builder*) clear;
- (MChatList_Builder*) clone;

- (MChatList*) build;
- (MChatList*) buildPartial;

- (MChatList_Builder*) mergeFrom:(MChatList*) other;
- (MChatList_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MChatList_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (NSArray*) chatList;
- (MChatIndex*) chatAtIndex:(int32_t) index;
- (MChatList_Builder*) replaceChatAtIndex:(int32_t) index with:(MChatIndex*) value;
- (MChatList_Builder*) addChat:(MChatIndex*) value;
- (MChatList_Builder*) addAllChat:(NSArray*) values;
- (MChatList_Builder*) clearChatList;
@end

@interface MChatIndex : PBGeneratedMessage {
@private
  BOOL hasHeadImg_:1;
  BOOL hasTotal_:1;
  BOOL hasId_:1;
  BOOL hasTargetid_:1;
  BOOL hasContent_:1;
  BOOL hasTime_:1;
  BOOL hasSpeaker_:1;
  int32_t headImg;
  int32_t total;
  NSString* id;
  NSString* targetid;
  NSString* content;
  NSString* time;
  NSString* speaker;
}
- (BOOL) hasId;
- (BOOL) hasTargetid;
- (BOOL) hasHeadImg;
- (BOOL) hasTotal;
- (BOOL) hasContent;
- (BOOL) hasTime;
- (BOOL) hasSpeaker;
@property (readonly, retain) NSString* id;
@property (readonly, retain) NSString* targetid;
@property (readonly) int32_t headImg;
@property (readonly) int32_t total;
@property (readonly, retain) NSString* content;
@property (readonly, retain) NSString* time;
@property (readonly, retain) NSString* speaker;

+ (MChatIndex*) defaultInstance;
- (MChatIndex*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MChatIndex_Builder*) builder;
+ (MChatIndex_Builder*) builder;
+ (MChatIndex_Builder*) builderWithPrototype:(MChatIndex*) prototype;

+ (MChatIndex*) parseFromData:(NSData*) data;
+ (MChatIndex*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MChatIndex*) parseFromInputStream:(NSInputStream*) input;
+ (MChatIndex*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MChatIndex*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MChatIndex*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MChatIndex_Builder : PBGeneratedMessage_Builder {
@private
  MChatIndex* result;
}

- (MChatIndex*) defaultInstance;

- (MChatIndex_Builder*) clear;
- (MChatIndex_Builder*) clone;

- (MChatIndex*) build;
- (MChatIndex*) buildPartial;

- (MChatIndex_Builder*) mergeFrom:(MChatIndex*) other;
- (MChatIndex_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MChatIndex_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasId;
- (NSString*) id;
- (MChatIndex_Builder*) setId:(NSString*) value;
- (MChatIndex_Builder*) clearId;

- (BOOL) hasTargetid;
- (NSString*) targetid;
- (MChatIndex_Builder*) setTargetid:(NSString*) value;
- (MChatIndex_Builder*) clearTargetid;

- (BOOL) hasHeadImg;
- (int32_t) headImg;
- (MChatIndex_Builder*) setHeadImg:(int32_t) value;
- (MChatIndex_Builder*) clearHeadImg;

- (BOOL) hasTotal;
- (int32_t) total;
- (MChatIndex_Builder*) setTotal:(int32_t) value;
- (MChatIndex_Builder*) clearTotal;

- (BOOL) hasContent;
- (NSString*) content;
- (MChatIndex_Builder*) setContent:(NSString*) value;
- (MChatIndex_Builder*) clearContent;

- (BOOL) hasTime;
- (NSString*) time;
- (MChatIndex_Builder*) setTime:(NSString*) value;
- (MChatIndex_Builder*) clearTime;

- (BOOL) hasSpeaker;
- (NSString*) speaker;
- (MChatIndex_Builder*) setSpeaker:(NSString*) value;
- (MChatIndex_Builder*) clearSpeaker;
@end

@interface MChats : PBGeneratedMessage {
@private
  BOOL hasHeadImg_:1;
  BOOL hasTargetid_:1;
  int32_t headImg;
  NSString* targetid;
  NSMutableArray* mutableChatList;
}
- (BOOL) hasTargetid;
- (BOOL) hasHeadImg;
@property (readonly, retain) NSString* targetid;
@property (readonly) int32_t headImg;
- (NSArray*) chatList;
- (MChat*) chatAtIndex:(int32_t) index;

+ (MChats*) defaultInstance;
- (MChats*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MChats_Builder*) builder;
+ (MChats_Builder*) builder;
+ (MChats_Builder*) builderWithPrototype:(MChats*) prototype;

+ (MChats*) parseFromData:(NSData*) data;
+ (MChats*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MChats*) parseFromInputStream:(NSInputStream*) input;
+ (MChats*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MChats*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MChats*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MChats_Builder : PBGeneratedMessage_Builder {
@private
  MChats* result;
}

- (MChats*) defaultInstance;

- (MChats_Builder*) clear;
- (MChats_Builder*) clone;

- (MChats*) build;
- (MChats*) buildPartial;

- (MChats_Builder*) mergeFrom:(MChats*) other;
- (MChats_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MChats_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (NSArray*) chatList;
- (MChat*) chatAtIndex:(int32_t) index;
- (MChats_Builder*) replaceChatAtIndex:(int32_t) index with:(MChat*) value;
- (MChats_Builder*) addChat:(MChat*) value;
- (MChats_Builder*) addAllChat:(NSArray*) values;
- (MChats_Builder*) clearChatList;

- (BOOL) hasTargetid;
- (NSString*) targetid;
- (MChats_Builder*) setTargetid:(NSString*) value;
- (MChats_Builder*) clearTargetid;

- (BOOL) hasHeadImg;
- (int32_t) headImg;
- (MChats_Builder*) setHeadImg:(int32_t) value;
- (MChats_Builder*) clearHeadImg;
@end

@interface MChat : PBGeneratedMessage {
@private
  BOOL hasId_:1;
  BOOL hasUserid_:1;
  BOOL hasContent_:1;
  BOOL hasImg_:1;
  BOOL hasTime_:1;
  BOOL hasCreatetime_:1;
  NSString* id;
  NSString* userid;
  NSString* content;
  NSString* img;
  NSString* time;
  NSString* createtime;
}
- (BOOL) hasId;
- (BOOL) hasUserid;
- (BOOL) hasContent;
- (BOOL) hasImg;
- (BOOL) hasTime;
- (BOOL) hasCreatetime;
@property (readonly, retain) NSString* id;
@property (readonly, retain) NSString* userid;
@property (readonly, retain) NSString* content;
@property (readonly, retain) NSString* img;
@property (readonly, retain) NSString* time;
@property (readonly, retain) NSString* createtime;

+ (MChat*) defaultInstance;
- (MChat*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MChat_Builder*) builder;
+ (MChat_Builder*) builder;
+ (MChat_Builder*) builderWithPrototype:(MChat*) prototype;

+ (MChat*) parseFromData:(NSData*) data;
+ (MChat*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MChat*) parseFromInputStream:(NSInputStream*) input;
+ (MChat*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MChat*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MChat*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MChat_Builder : PBGeneratedMessage_Builder {
@private
  MChat* result;
}

- (MChat*) defaultInstance;

- (MChat_Builder*) clear;
- (MChat_Builder*) clone;

- (MChat*) build;
- (MChat*) buildPartial;

- (MChat_Builder*) mergeFrom:(MChat*) other;
- (MChat_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MChat_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasId;
- (NSString*) id;
- (MChat_Builder*) setId:(NSString*) value;
- (MChat_Builder*) clearId;

- (BOOL) hasUserid;
- (NSString*) userid;
- (MChat_Builder*) setUserid:(NSString*) value;
- (MChat_Builder*) clearUserid;

- (BOOL) hasContent;
- (NSString*) content;
- (MChat_Builder*) setContent:(NSString*) value;
- (MChat_Builder*) clearContent;

- (BOOL) hasImg;
- (NSString*) img;
- (MChat_Builder*) setImg:(NSString*) value;
- (MChat_Builder*) clearImg;

- (BOOL) hasTime;
- (NSString*) time;
- (MChat_Builder*) setTime:(NSString*) value;
- (MChat_Builder*) clearTime;

- (BOOL) hasCreatetime;
- (NSString*) createtime;
- (MChat_Builder*) setCreatetime:(NSString*) value;
- (MChat_Builder*) clearCreatetime;
@end

@interface MMatch : PBGeneratedMessage {
@private
  BOOL hasHeadImg_:1;
  BOOL hasFlower_:1;
  BOOL hasUserid_:1;
  BOOL hasSchool_:1;
  BOOL hasBelong_:1;
  int32_t headImg;
  int32_t flower;
  NSString* userid;
  NSString* school;
  NSString* belong;
}
- (BOOL) hasUserid;
- (BOOL) hasHeadImg;
- (BOOL) hasFlower;
- (BOOL) hasSchool;
- (BOOL) hasBelong;
@property (readonly, retain) NSString* userid;
@property (readonly) int32_t headImg;
@property (readonly) int32_t flower;
@property (readonly, retain) NSString* school;
@property (readonly, retain) NSString* belong;

+ (MMatch*) defaultInstance;
- (MMatch*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MMatch_Builder*) builder;
+ (MMatch_Builder*) builder;
+ (MMatch_Builder*) builderWithPrototype:(MMatch*) prototype;

+ (MMatch*) parseFromData:(NSData*) data;
+ (MMatch*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MMatch*) parseFromInputStream:(NSInputStream*) input;
+ (MMatch*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MMatch*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MMatch*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MMatch_Builder : PBGeneratedMessage_Builder {
@private
  MMatch* result;
}

- (MMatch*) defaultInstance;

- (MMatch_Builder*) clear;
- (MMatch_Builder*) clone;

- (MMatch*) build;
- (MMatch*) buildPartial;

- (MMatch_Builder*) mergeFrom:(MMatch*) other;
- (MMatch_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MMatch_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasUserid;
- (NSString*) userid;
- (MMatch_Builder*) setUserid:(NSString*) value;
- (MMatch_Builder*) clearUserid;

- (BOOL) hasHeadImg;
- (int32_t) headImg;
- (MMatch_Builder*) setHeadImg:(int32_t) value;
- (MMatch_Builder*) clearHeadImg;

- (BOOL) hasFlower;
- (int32_t) flower;
- (MMatch_Builder*) setFlower:(int32_t) value;
- (MMatch_Builder*) clearFlower;

- (BOOL) hasSchool;
- (NSString*) school;
- (MMatch_Builder*) setSchool:(NSString*) value;
- (MMatch_Builder*) clearSchool;

- (BOOL) hasBelong;
- (NSString*) belong;
- (MMatch_Builder*) setBelong:(NSString*) value;
- (MMatch_Builder*) clearBelong;
@end

