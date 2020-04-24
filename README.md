# Say

Utilise la fonction TextToSpeech de son iPad/iPhone.
Réglage possible de la vitesse de lecture, du niveau sonore, du pitch et de la voix H/F.

```
iPad:~ root# say 
Usage: say [-r <rate>] [-V <volume>] [-p <pitch>] [-w <women0/men1>] [<string>]
iPad:~ root# say Bonjour, GitHub. 
Rate = 0.530000; Volume = 1.000000; Pitch = 1.000000;

iPad:~ root# say -r 0.53 -V 2 -p 1.1 -w 1 Bonjour, GitHub.
Voix : 1.000000 (com.apple.ttsbundle.Thomas-compact)
Rate = 0.530000; Volume = 2.000000; Pitch = 1.100000;

iPad:~ root# say -w 2 Je suis Thomas.
Voix : 2.000000 (com.apple.ttsbundle.Thomas-premium)
Rate = 0.530000; Volume = 1.000000; Pitch = 1.000000;

iPad:~ root# say -w 3 Je m\'appelle Siri.
Voix : 3.000000 (com.apple.ttsbundle.siri_male_fr-FR_compact)
Rate = 0.530000; Volume = 1.000000; Pitch = 1.000000;
```

# Paramètres :

- -r rate => `Mini: 0.5 - Max: 1 - Default: 0.53`
- -V volume => `Mini: 0 - Max: 2 - Default: 2`
- -p pitch => `Mini: 0.5 - Max: 2 - Default: 1`
- -w women0/men1 => </br>
            `0: Amelie-compact`,</br>
            `1: Thomas-compact`,</br>
            `2: Thomas-premium`,</br>
            `3: Siri male compact`,</br>
            `4: Siri female compact`,</br>
            `Default: défaut fr-FR (en général Thomas compact)`

 /!\ Si votre appareil n'a pas téléchargé les voix selectionnées, la voix par défaut anglaise sera utilisée.
 Pour les télécharger : 
 - (iOS 12) : Réglages > Général > Accessibilité > VoiceOver > Parole > Voix > et télécharger les voix désirées.
 - (iOS 13) : Réglages > Accessibilité > VoiceOver > Parole > Voix > et télécharger les voix désirées.
 
