#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

int main(int argc,char** argv) {
  enum {
    kFlag_rate=1,
    kFlag_volume=2,
    kFlag_pitch=3,
    kFlag_who=4,
  } flags=0;
    float s_rate=0.53,s_volume=1,s_pitch=1,s_who=1;
  int opt;
  while((opt=getopt(argc,argv,"r:V:p:w:"))!=-1){
    if(!optarg){return 1;}
    switch(opt){
      case 'r':flags|=kFlag_rate;
        if(sscanf(optarg,"%f",&s_rate)==1){continue;}
        break;
      case 'V':flags|=kFlag_volume;
        if(sscanf(optarg,"%f",&s_volume)==1){continue;}
        break;
      case 'p':flags|=kFlag_pitch;
        if(sscanf(optarg,"%f",&s_pitch)==1){continue;}
        break;
      case 'w':flags|=kFlag_who;
        if(sscanf(optarg,"%f",&s_who)==1){continue;}
        break;
      default:
        fprintf(stderr,"W: Ignoring option -%c\n",opt);
        continue;
    }
    fprintf(stderr,"-%c: Invalid argument\n",opt);
    return 1;
  }
  if(optind>=argc && isatty(fileno(stdin))){
    fprintf(stderr,"Usage: %s [-r <rate>] [-V <volume>] [-p <pitch>] [-w <women0/men1>] [<string>]\n",argv[0]);
    return 1;
  }
  NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
  AVAudioSession* session=[AVAudioSession sharedInstance];
  NSError* error;
  if(![session setCategory:AVAudioSessionCategoryPlayback error:&error]){
    fprintf(stderr,"E[AVAudioSession]: %s\n",error.localizedDescription.UTF8String);
  }
  if(![session setActive:YES error:&error]){
    fprintf(stderr,"E[AVAudioSession]: %s\n",error.localizedDescription.UTF8String);
  }
  NSString* string=nil;
  if(optind!=argc-1 || strcmp(argv[optind],"-")!=0){
    NSMutableString* buffer=[NSMutableString string];
    for (opt=optind;opt<argc;opt++){[buffer appendFormat:@"%s ",argv[opt]];}
    if(buffer.length){string=buffer;}
  }
  if(!string){
    string=[[[NSString alloc] initWithData:[[NSFileHandle
     fileHandleWithStandardInput] readDataToEndOfFile]
     encoding:NSUTF8StringEncoding] autorelease];
  }
  AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:string];
  AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];

  if(flags&kFlag_rate){utterance.rate=s_rate;}
  if(flags&kFlag_volume){utterance.volume=s_volume;}
  if(flags&kFlag_pitch){utterance.pitchMultiplier=s_pitch;}
  if(flags&kFlag_who){
      if (s_who==0){
          utterance.voice = [AVSpeechSynthesisVoice voiceWithIdentifier:@"com.apple.ttsbundle.Amelie-compact"];
      } else if (s_who==1){
          utterance.voice = [AVSpeechSynthesisVoice voiceWithIdentifier:@"com.apple.ttsbundle.Thomas-compact"];
      }
  } else utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"fr-FR"];

  [synth speakUtterance:utterance];
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, 5.0, FALSE);
    //CFRunLoopRun();
  //[synth stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
  //CFRunLoopStop(CFRunLoopGetMain());
  printf("Rate = %f; Volume = %f; Pitch = %f;\n",s_rate,s_volume,s_pitch);
  [synth release];
  [pool drain];
}
 
