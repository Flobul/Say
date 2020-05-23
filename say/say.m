#import <AVFoundation/AVFoundation.h>

#define IGNORE_MSG "W: Ignoring option -%c\n"
#define ERROR_MSG "-%c: Invalid argument\n"
#define USAGE_MSG "Usage: %s [-o <output.wav>] [-r <rate>] [-V <volume>] [-p <pitch>] [-v <voice>] [<string>]\n"

int main(int argc,char** argv) {
    int opt_mono=0;
    int opt_srate=0;
    int time_loop=5.0;
    float nb_carac=0;
    float srate=0;
    enum {
        kFlag_rate=1,
        kFlag_volume=2,
        kFlag_pitch=3,
        kFlag_voice=4,
    } flags=0;
    char s_voice = '\0';
    char* voicefn=NULL;
    char* audiofn=NULL;
    float s_rate=0.53,s_volume=1,s_pitch=1;
    int opt;

    NSArray *allVoices = [AVSpeechSynthesisVoice speechVoices];

    while((opt=getopt(argc,argv,"o:r:V:p:v:"))!=-1){
        if(!optarg){return 1;}
        switch(opt){
            case 'o':audiofn=optarg;continue;
            case 'r':flags|=kFlag_rate;
                if(sscanf(optarg,"%f",&s_rate)==1){continue;}
                break;
            case 'V':flags|=kFlag_volume;
                if(sscanf(optarg,"%f",&s_volume)==1){continue;}
                break;
            case 'p':flags|=kFlag_pitch;
                if(sscanf(optarg,"%f",&s_pitch)==1){continue;}
                break;
            case 'v':voicefn=optarg;
                sscanf(optarg,"%s",&s_voice);
                    if (strcmp(optarg, "?")==0) {
                        for (AVSpeechSynthesisVoice *voice in allVoices) {
                            NSString *Name = [voice.name stringByReplacingOccurrencesOfString:@" " withString:@""];
                            NSUInteger Prems = [Name length];
                            if(Prems<7){
                            printf("%s\t\t\t%s\t# %s\n", [Name UTF8String], [voice.language UTF8String], [voice.identifier UTF8String]);
                            }if(Prems>7 && Prems<15){
                            printf("%s\t\t%s\t# %s\n", [Name UTF8String], [voice.language UTF8String], [voice.identifier UTF8String]);
                            }if(Prems>15){
                            printf("%s\t%s\t# %s\n", [Name UTF8String], [voice.language UTF8String], [voice.identifier UTF8String]);
                            }
                        }
                        return 1;
                    }
                    continue;
            default:fprintf(stderr,IGNORE_MSG,opt);continue;
        }
        fprintf(stderr,ERROR_MSG,opt);
        return 1;
    }

    if(optind>=argc && isatty(fileno(stdin))){
        fprintf(stderr,USAGE_MSG,argv[0]);
        return 1;
    }
    NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
    AVAudioRecorder* recorder;
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
      NSString* bufferstring=[NSString string];
      for (opt=optind;opt<argc;opt++){bufferstring=[NSString stringWithUTF8String:argv[opt]];}
      if(bufferstring.length){string=bufferstring;}
    }
    if(!string){
        string=[[[NSString alloc] initWithData:[[NSFileHandle fileHandleWithStandardInput] readDataToEndOfFile]
                                      encoding:NSUTF8StringEncoding] autorelease];
    }
    nb_carac=string.length;
    while(nb_carac>16) {
        time_loop=time_loop+1.0;
        nb_carac=nb_carac-16;
        //printf("Longueur de string = %lu; time_loop = %d\n",(unsigned long)string.length,time_loop);
    }

    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:string];
    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
    NSString* voix=nil;

    if(flags&kFlag_rate){utterance.rate=s_rate;}
    if(flags&kFlag_volume){utterance.volume=s_volume;}
    if(flags&kFlag_pitch){utterance.pitchMultiplier=s_pitch;}
    if(!voicefn){
        utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"fr-FR"];
        voix=@"fr-FR";
    } else {
        for (AVSpeechSynthesisVoice *voice in allVoices) {
            NSString *Name = [voice.name stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString *Identifier = voice.identifier;
            if (strcmp(&s_voice,[Name UTF8String])==0){
                utterance.voice = [AVSpeechSynthesisVoice voiceWithIdentifier:Identifier];
                voix=Name;
            }
        }
    }

    if(audiofn){
        if (@available(iOS 13, *)) {//utilise writeUtterance uniquement pour iOS 13
            __block AVAudioFile *output = nil;
            NSURL* URL=[NSURL fileURLWithPath:[[NSFileManager defaultManager]
            stringWithFileSystemRepresentation:audiofn length:strlen(audiofn)]];
            
            [synth writeUtterance:utterance toBufferCallback:^(AVAudioBuffer * _Nonnull buffer) {
                AVAudioPCMBuffer *pcmBuffer = (AVAudioPCMBuffer*)buffer;
                if (!pcmBuffer) {
                    NSLog(@"Error");
                    return;
                }
                if (pcmBuffer.frameLength != 0) {
                    if (output == nil) {
                        output = [[AVAudioFile alloc] initForWriting:URL
                                                            settings:pcmBuffer.format.settings
                                                        commonFormat:AVAudioPCMFormatInt16
                                                         interleaved:NO error:nil];
                    }
                    [output writeFromBuffer:pcmBuffer error:nil];
                }
            }];
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, time_loop, FALSE);
            printf("File = %s;\n",audiofn);
        } else {//utilise le microphone pour les autres version d'iOS
            [synth speakUtterance:utterance];
            AVAudioSession* session=[AVAudioSession sharedInstance];
            [session setCategory:AVAudioSessionCategoryPlayAndRecord error:NULL];
            [session setActive:YES error:NULL];
            CFURLRef URL=CFURLCreateFromFileSystemRepresentation(NULL, (const UInt8*)audiofn,strlen(audiofn),false);
            NSError* error;
            recorder=[[AVAudioRecorder alloc] initWithURL:(NSURL*)URL
                                                 settings:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           [NSNumber numberWithInt:opt_mono?1:2],AVNumberOfChannelsKey,
                                                           [NSNumber numberWithFloat:opt_srate?srate:44100],AVSampleRateKey,nil] error:&error];
            if(!recorder){
                fprintf(stderr,"E[AVAudioRecorder]: %s\n", error.localizedDescription.UTF8String);
                return 1;
            }
            CFRelease(URL);
            [recorder record];
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, time_loop, FALSE);
            printf("File = %s;\n",audiofn);
            [recorder stop];
            [recorder release];
        }
    } else {
        [synth speakUtterance:utterance];
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, time_loop, FALSE);
    }
    printf("Rate = %0.2f;\n",s_rate);
    printf("Volume = %0.2f;\n",s_volume);
    printf("Pitch = %0.2f;\n",s_pitch);
    printf("Voix = %s;\n",voix.UTF8String);
    printf("String = %s;\n",string.UTF8String);
    [synth release];
    [pool drain];
}

