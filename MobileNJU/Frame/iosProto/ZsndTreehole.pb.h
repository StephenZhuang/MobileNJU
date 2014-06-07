// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class MAddTopic;
@class MAddTopic_Builder;
@class MComment;
@class MComment_Builder;
@class MNewComments;
@class MNewComments_Builder;
@class MTopic;
@class MTopic_Builder;
@class MTreeHole;
@class MTreeHole_Builder;

@interface ZsndTreeholeRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface MTreeHole : PBGeneratedMessage {
@private
  NSMutableArray* mutableTopicsList;
}
- (NSArray*) topicsList;
- (MTopic*) topicsAtIndex:(int32_t) index;

+ (MTreeHole*) defaultInstance;
- (MTreeHole*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MTreeHole_Builder*) builder;
+ (MTreeHole_Builder*) builder;
+ (MTreeHole_Builder*) builderWithPrototype:(MTreeHole*) prototype;

+ (MTreeHole*) parseFromData:(NSData*) data;
+ (MTreeHole*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MTreeHole*) parseFromInputStream:(NSInputStream*) input;
+ (MTreeHole*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MTreeHole*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MTreeHole*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MTreeHole_Builder : PBGeneratedMessage_Builder {
@private
  MTreeHole* result;
}

- (MTreeHole*) defaultInstance;

- (MTreeHole_Builder*) clear;
- (MTreeHole_Builder*) clone;

- (MTreeHole*) build;
- (MTreeHole*) buildPartial;

- (MTreeHole_Builder*) mergeFrom:(MTreeHole*) other;
- (MTreeHole_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MTreeHole_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (NSArray*) topicsList;
- (MTopic*) topicsAtIndex:(int32_t) index;
- (MTreeHole_Builder*) replaceTopicsAtIndex:(int32_t) index with:(MTopic*) value;
- (MTreeHole_Builder*) addTopics:(MTopic*) value;
- (MTreeHole_Builder*) addAllTopics:(NSArray*) values;
- (MTreeHole_Builder*) clearTopicsList;
@end

@interface MTopic : PBGeneratedMessage {
@private
  BOOL hasPraiseCnt_:1;
  BOOL hasCommentCnt_:1;
  BOOL hasHasPraise_:1;
  BOOL hasId_:1;
  BOOL hasTitle_:1;
  BOOL hasContent_:1;
  BOOL hasTime_:1;
  BOOL hasImgs_:1;
  BOOL hasCreateTime_:1;
  BOOL hasAuthor_:1;
  int32_t praiseCnt;
  int32_t commentCnt;
  int32_t hasPraise;
  NSString* id;
  NSString* title;
  NSString* content;
  NSString* time;
  NSString* imgs;
  NSString* createTime;
  NSString* author;
  NSMutableArray* mutableCommentList;
}
- (BOOL) hasId;
- (BOOL) hasTitle;
- (BOOL) hasContent;
- (BOOL) hasTime;
- (BOOL) hasImgs;
- (BOOL) hasPraiseCnt;
- (BOOL) hasCommentCnt;
- (BOOL) hasHasPraise;
- (BOOL) hasCreateTime;
- (BOOL) hasAuthor;
@property (readonly, retain) NSString* id;
@property (readonly, retain) NSString* title;
@property (readonly, retain) NSString* content;
@property (readonly, retain) NSString* time;
@property (readonly, retain) NSString* imgs;
@property (readonly) int32_t praiseCnt;
@property (readonly) int32_t commentCnt;
@property (readonly) int32_t hasPraise;
@property (readonly, retain) NSString* createTime;
@property (readonly, retain) NSString* author;
- (NSArray*) commentList;
- (MComment*) commentAtIndex:(int32_t) index;

+ (MTopic*) defaultInstance;
- (MTopic*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MTopic_Builder*) builder;
+ (MTopic_Builder*) builder;
+ (MTopic_Builder*) builderWithPrototype:(MTopic*) prototype;

+ (MTopic*) parseFromData:(NSData*) data;
+ (MTopic*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MTopic*) parseFromInputStream:(NSInputStream*) input;
+ (MTopic*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MTopic*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MTopic*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MTopic_Builder : PBGeneratedMessage_Builder {
@private
  MTopic* result;
}

- (MTopic*) defaultInstance;

- (MTopic_Builder*) clear;
- (MTopic_Builder*) clone;

- (MTopic*) build;
- (MTopic*) buildPartial;

- (MTopic_Builder*) mergeFrom:(MTopic*) other;
- (MTopic_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MTopic_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasId;
- (NSString*) id;
- (MTopic_Builder*) setId:(NSString*) value;
- (MTopic_Builder*) clearId;

- (BOOL) hasTitle;
- (NSString*) title;
- (MTopic_Builder*) setTitle:(NSString*) value;
- (MTopic_Builder*) clearTitle;

- (BOOL) hasContent;
- (NSString*) content;
- (MTopic_Builder*) setContent:(NSString*) value;
- (MTopic_Builder*) clearContent;

- (BOOL) hasTime;
- (NSString*) time;
- (MTopic_Builder*) setTime:(NSString*) value;
- (MTopic_Builder*) clearTime;

- (BOOL) hasImgs;
- (NSString*) imgs;
- (MTopic_Builder*) setImgs:(NSString*) value;
- (MTopic_Builder*) clearImgs;

- (BOOL) hasPraiseCnt;
- (int32_t) praiseCnt;
- (MTopic_Builder*) setPraiseCnt:(int32_t) value;
- (MTopic_Builder*) clearPraiseCnt;

- (BOOL) hasCommentCnt;
- (int32_t) commentCnt;
- (MTopic_Builder*) setCommentCnt:(int32_t) value;
- (MTopic_Builder*) clearCommentCnt;

- (BOOL) hasHasPraise;
- (int32_t) hasPraise;
- (MTopic_Builder*) setHasPraise:(int32_t) value;
- (MTopic_Builder*) clearHasPraise;

- (NSArray*) commentList;
- (MComment*) commentAtIndex:(int32_t) index;
- (MTopic_Builder*) replaceCommentAtIndex:(int32_t) index with:(MComment*) value;
- (MTopic_Builder*) addComment:(MComment*) value;
- (MTopic_Builder*) addAllComment:(NSArray*) values;
- (MTopic_Builder*) clearCommentList;

- (BOOL) hasCreateTime;
- (NSString*) createTime;
- (MTopic_Builder*) setCreateTime:(NSString*) value;
- (MTopic_Builder*) clearCreateTime;

- (BOOL) hasAuthor;
- (NSString*) author;
- (MTopic_Builder*) setAuthor:(NSString*) value;
- (MTopic_Builder*) clearAuthor;
@end

@interface MComment : PBGeneratedMessage {
@private
  BOOL hasId_:1;
  BOOL hasUserid1_:1;
  BOOL hasNickname1_:1;
  BOOL hasUserid2_:1;
  BOOL hasNickname2_:1;
  BOOL hasContent_:1;
  BOOL hasTime_:1;
  BOOL hasPid_:1;
  BOOL hasTitle_:1;
  BOOL hasAuthor_:1;
  NSString* id;
  NSString* userid1;
  NSString* nickname1;
  NSString* userid2;
  NSString* nickname2;
  NSString* content;
  NSString* time;
  NSString* pid;
  NSString* title;
  NSString* author;
}
- (BOOL) hasId;
- (BOOL) hasUserid1;
- (BOOL) hasNickname1;
- (BOOL) hasUserid2;
- (BOOL) hasNickname2;
- (BOOL) hasContent;
- (BOOL) hasTime;
- (BOOL) hasPid;
- (BOOL) hasTitle;
- (BOOL) hasAuthor;
@property (readonly, retain) NSString* id;
@property (readonly, retain) NSString* userid1;
@property (readonly, retain) NSString* nickname1;
@property (readonly, retain) NSString* userid2;
@property (readonly, retain) NSString* nickname2;
@property (readonly, retain) NSString* content;
@property (readonly, retain) NSString* time;
@property (readonly, retain) NSString* pid;
@property (readonly, retain) NSString* title;
@property (readonly, retain) NSString* author;

+ (MComment*) defaultInstance;
- (MComment*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MComment_Builder*) builder;
+ (MComment_Builder*) builder;
+ (MComment_Builder*) builderWithPrototype:(MComment*) prototype;

+ (MComment*) parseFromData:(NSData*) data;
+ (MComment*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MComment*) parseFromInputStream:(NSInputStream*) input;
+ (MComment*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MComment*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MComment*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MComment_Builder : PBGeneratedMessage_Builder {
@private
  MComment* result;
}

- (MComment*) defaultInstance;

- (MComment_Builder*) clear;
- (MComment_Builder*) clone;

- (MComment*) build;
- (MComment*) buildPartial;

- (MComment_Builder*) mergeFrom:(MComment*) other;
- (MComment_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MComment_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasId;
- (NSString*) id;
- (MComment_Builder*) setId:(NSString*) value;
- (MComment_Builder*) clearId;

- (BOOL) hasUserid1;
- (NSString*) userid1;
- (MComment_Builder*) setUserid1:(NSString*) value;
- (MComment_Builder*) clearUserid1;

- (BOOL) hasNickname1;
- (NSString*) nickname1;
- (MComment_Builder*) setNickname1:(NSString*) value;
- (MComment_Builder*) clearNickname1;

- (BOOL) hasUserid2;
- (NSString*) userid2;
- (MComment_Builder*) setUserid2:(NSString*) value;
- (MComment_Builder*) clearUserid2;

- (BOOL) hasNickname2;
- (NSString*) nickname2;
- (MComment_Builder*) setNickname2:(NSString*) value;
- (MComment_Builder*) clearNickname2;

- (BOOL) hasContent;
- (NSString*) content;
- (MComment_Builder*) setContent:(NSString*) value;
- (MComment_Builder*) clearContent;

- (BOOL) hasTime;
- (NSString*) time;
- (MComment_Builder*) setTime:(NSString*) value;
- (MComment_Builder*) clearTime;

- (BOOL) hasPid;
- (NSString*) pid;
- (MComment_Builder*) setPid:(NSString*) value;
- (MComment_Builder*) clearPid;

- (BOOL) hasTitle;
- (NSString*) title;
- (MComment_Builder*) setTitle:(NSString*) value;
- (MComment_Builder*) clearTitle;

- (BOOL) hasAuthor;
- (NSString*) author;
- (MComment_Builder*) setAuthor:(NSString*) value;
- (MComment_Builder*) clearAuthor;
@end

@interface MNewComments : PBGeneratedMessage {
@private
  NSMutableArray* mutableNewsList;
}
- (NSArray*) newsList;
- (MComment*) newsAtIndex:(int32_t) index;

+ (MNewComments*) defaultInstance;
- (MNewComments*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MNewComments_Builder*) builder;
+ (MNewComments_Builder*) builder;
+ (MNewComments_Builder*) builderWithPrototype:(MNewComments*) prototype;

+ (MNewComments*) parseFromData:(NSData*) data;
+ (MNewComments*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MNewComments*) parseFromInputStream:(NSInputStream*) input;
+ (MNewComments*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MNewComments*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MNewComments*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MNewComments_Builder : PBGeneratedMessage_Builder {
@private
  MNewComments* result;
}

- (MNewComments*) defaultInstance;

- (MNewComments_Builder*) clear;
- (MNewComments_Builder*) clone;

- (MNewComments*) build;
- (MNewComments*) buildPartial;

- (MNewComments_Builder*) mergeFrom:(MNewComments*) other;
- (MNewComments_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MNewComments_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (NSArray*) newsList;
- (MComment*) newsAtIndex:(int32_t) index;
- (MNewComments_Builder*) replaceNewsAtIndex:(int32_t) index with:(MComment*) value;
- (MNewComments_Builder*) addNews:(MComment*) value;
- (MNewComments_Builder*) addAllNews:(NSArray*) values;
- (MNewComments_Builder*) clearNewsList;
@end

@interface MAddTopic : PBGeneratedMessage {
@private
  BOOL hasTitle_:1;
  BOOL hasContent_:1;
  NSString* title;
  NSString* content;
  NSMutableArray* mutableImgsList;
}
- (BOOL) hasTitle;
- (BOOL) hasContent;
@property (readonly, retain) NSString* title;
@property (readonly, retain) NSString* content;
- (NSArray*) imgsList;
- (NSData*) imgsAtIndex:(int32_t) index;

+ (MAddTopic*) defaultInstance;
- (MAddTopic*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MAddTopic_Builder*) builder;
+ (MAddTopic_Builder*) builder;
+ (MAddTopic_Builder*) builderWithPrototype:(MAddTopic*) prototype;

+ (MAddTopic*) parseFromData:(NSData*) data;
+ (MAddTopic*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MAddTopic*) parseFromInputStream:(NSInputStream*) input;
+ (MAddTopic*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MAddTopic*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MAddTopic*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MAddTopic_Builder : PBGeneratedMessage_Builder {
@private
  MAddTopic* result;
}

- (MAddTopic*) defaultInstance;

- (MAddTopic_Builder*) clear;
- (MAddTopic_Builder*) clone;

- (MAddTopic*) build;
- (MAddTopic*) buildPartial;

- (MAddTopic_Builder*) mergeFrom:(MAddTopic*) other;
- (MAddTopic_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MAddTopic_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasTitle;
- (NSString*) title;
- (MAddTopic_Builder*) setTitle:(NSString*) value;
- (MAddTopic_Builder*) clearTitle;

- (BOOL) hasContent;
- (NSString*) content;
- (MAddTopic_Builder*) setContent:(NSString*) value;
- (MAddTopic_Builder*) clearContent;

- (NSArray*) imgsList;
- (NSData*) imgsAtIndex:(int32_t) index;
- (MAddTopic_Builder*) replaceImgsAtIndex:(int32_t) index with:(NSData*) value;
- (MAddTopic_Builder*) addImgs:(NSData*) value;
- (MAddTopic_Builder*) addAllImgs:(NSArray*) values;
- (MAddTopic_Builder*) clearImgsList;
@end
