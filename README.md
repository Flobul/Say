# Say

Utilise la fonction TextToSpeech de son iPad/iPhone.
Réglage possible de la vitesse de lecture, du niveau sonore, du pitch et de la voix H/F.

```
iPad:~ root# say 
Usage: say [-r <rate>] [-V <volume>] [-p <pitch>] [-w <women0/men1>] [<string>]
iPad:~ root# say Bonjour, GitHub. 
...
Rate = 0.530000; Volume = 1.000000; Pitch = 1.000000;

iPad:~ root# say -r 0.53 -V 2 -p 1.1 -w 1 Bonjour, GitHub.
...
Rate = 0.530000; Volume = 2.000000; Pitch = 1.100000;


```

# Paramètres :

- -r rate => `Mini: 0.5 - Max: 1 - Default: 0.53`
- -V volume => `Mini: 0 - Max: 2 - Default: 2`
- -p pitch => `Mini: 0.5 - Max: 2 - Default: 1`
- -w women0/men1 => `0: Amelie - 1: Thomas - Default: défaut fr-FR (en général Thomas)`
