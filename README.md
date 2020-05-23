# Say

Utilise la fonction TextToSpeech de son iPad/iPhone.
Réglage possible de la vitesse de lecture, du niveau sonore, du pitch et de la voix H/F.

# Utilisation :
## Utilisation basique avec valeurs par défaut. (voix fr-FR, en général Thomas)
```
iPad:~ root# say 
Usage: say [-o <output.wav>] [-r <rate>] [-V <volume>] [-p <pitch>] [-v <voice>] [<string>]

iPad:~ root# say Bonjour, GitHub. 
Rate = 0.53;
Volume = 1.00;
Pitch = 1.00;
Voix = fr-FR;
String = Bonjour, GitHub.;
```

## Lister les voix installées sur l'appareil :
```
iPad:~ root# say -v ?
Maged			ar-SA	# com.apple.ttsbundle.Maged-compact
Zuzana			cs-CZ	# com.apple.ttsbundle.Zuzana-compact
Sara			da-DK	# com.apple.ttsbundle.Sara-compact
Anna			de-DE	# com.apple.ttsbundle.Anna-compact
Helena			de-DE	# com.apple.ttsbundle.siri_female_de-DE_compact
Martin			de-DE	# com.apple.ttsbundle.siri_male_de-DE_compact
Melina			el-GR	# com.apple.ttsbundle.Melina-compact
Catherine		en-AU	# com.apple.ttsbundle.siri_female_en-AU_compact
Gordon			en-AU	# com.apple.ttsbundle.siri_male_en-AU_compact
Karen			en-AU	# com.apple.ttsbundle.Karen-compact
Arthur			en-GB	# com.apple.ttsbundle.siri_male_en-GB_compact
Daniel			en-GB	# com.apple.ttsbundle.Daniel-compact
Martha			en-GB	# com.apple.ttsbundle.siri_female_en-GB_compact
Moira			en-IE	# com.apple.ttsbundle.Moira-compact
Rishi			en-IN	# com.apple.ttsbundle.Rishi-compact
Aaron			en-US	# com.apple.ttsbundle.siri_male_en-US_compact
Fred			en-US	# com.apple.speech.synthesis.voice.Fred
Nicky			en-US	# com.apple.ttsbundle.siri_female_en-US_compact
Samantha		en-US	# com.apple.ttsbundle.Samantha-compact
Tessa			en-ZA	# com.apple.ttsbundle.Tessa-compact
Mónica			es-ES	# com.apple.ttsbundle.Monica-compact
Satu			fi-FI	# com.apple.ttsbundle.Satu-compact
Amélie			fr-CA	# com.apple.ttsbundle.Amelie-compact
Aurelie(Enhanced)	fr-FR	# com.apple.ttsbundle.Aurelie-premium
Thomas(Enhanced)	fr-FR	# com.apple.ttsbundle.Thomas-premium
Daniel			fr-FR	# com.apple.ttsbundle.siri_male_fr-FR_compact
Marie			fr-FR	# com.apple.ttsbundle.siri_female_fr-FR_compact
Thomas			fr-FR	# com.apple.ttsbundle.Thomas-compact
Carmit			he-IL	# com.apple.ttsbundle.Carmit-compact
Lekha			hi-IN	# com.apple.ttsbundle.Lekha-compact
Damayanti		id-ID	# com.apple.ttsbundle.Damayanti-compact
Alice			it-IT	# com.apple.ttsbundle.Alice-compact
Kyoko			ja-JP	# com.apple.ttsbundle.Kyoko-compact
O-ren			ja-JP	# com.apple.ttsbundle.siri_female_ja-JP_compact
Yuna			ko-KR	# com.apple.ttsbundle.Yuna-compact
Ellen			nl-BE	# com.apple.ttsbundle.Ellen-compact
Xander			nl-NL	# com.apple.ttsbundle.Xander-compact
Nora			no-NO	# com.apple.ttsbundle.Nora-compact
Zosia			pl-PL	# com.apple.ttsbundle.Zosia-compact
Joana			pt-PT	# com.apple.ttsbundle.Joana-compact
Ioana			ro-RO	# com.apple.ttsbundle.Ioana-compact
Milena			ru-RU	# com.apple.ttsbundle.Milena-compact
Laura			sk-SK	# com.apple.ttsbundle.Laura-compact
Alva			sv-SE	# com.apple.ttsbundle.Alva-compact
Kanya			th-TH	# com.apple.ttsbundle.Kanya-compact
Yelda			tr-TR	# com.apple.ttsbundle.Yelda-compact
Li-mu			zh-CN	# com.apple.ttsbundle.siri_male_zh-CN_compact
Tian-Tian		zh-CN	# com.apple.ttsbundle.Ting-Ting-compact
Yu-shu			zh-CN	# com.apple.ttsbundle.siri_female_zh-CN_compact
Sin-Ji			zh-HK	# com.apple.ttsbundle.Sin-Ji-compact
Alex			en-US	# com.apple.speech.voice.Alex
```

## Utilisation personnalisée :
```
iPad:~ root# say -r 0.53 -V 2 -p 1.1 -v Amélie "Bonjour, Github. Je m'appelle Amélie."
Rate = 0.53;
Volume = 2.00;
Pitch = 1.10;
Voix = Amélie;
String = Bonjour, Github. Je m'appelle Amélie.;

iPad:~ root# say -r 0.53 -V 2 -p 1.1 -v Thomas\(Enhanced\) "Bonjour, Github. Moi, c'est Thomas premium."
Rate = 0.53;
Volume = 2.00;
Pitch = 1.10;
Voix = Thomas(Enhanced);
String = Bonjour, Github. Moi, c'est Thomas premium.;

iPad:~ root# say -r 0.53 -V 2 -p 1.1 -v "Thomas(Enhanced)" "Bonjour, Github. Moi, c'est Thomas premium."
Rate = 0.53;
Volume = 2.00;
Pitch = 1.10;
Voix = Thomas(Enhanced);
String = Bonjour, Github. Moi, c'est Thomas premium.;
```

## Enregistrement dans un fichier :
```
iPad:~ root# say -o output.wav "Bonjour, je m'appelle Jordan, et toi tu t'appelles comment ?"
File = output.wav;
Rate = 0.53;
Volume = 1.00;
Pitch = 1.00;
Voix = fr-FR;
String = Bonjour, je mappelle Jordan, et toi tu t'appelles comment ?";
```

# Paramètres :

- -r rate => `Mini: 0.5 - Max: 1 - Default: 0.53`
- -V volume => `Mini: 0 - Max: 2 - Default: 2`
- -p pitch => `Mini: 0.5 - Max: 2 - Default: 1`
- -v voix => `mettez le nom de la voix que vous désirez (ex: Thomas)` listez les voix installées avec la commande `say -v ?`
- -o output => `nom du fichier audio dans lequel le TTS sera enregistré`. 
                       - Pour iOS 13 et +, la fonction d'enregistrement est implémentée directement, le lancement de la commande `-o` redirige le TTS directement vers le fichier, il n'y a pas de son en sortie des hauts-parleurs.  
                       - Pour les versions antérieures, la fonction d'enregistrement n'est pas implémentée, le lancement de la commande `-o` redirige le TTS vers les haut-parleurs, et le micro enregistre le son. Attention aux milieu bruyants, le son se verra affecté.

 /!\ Si votre appareil n'a pas téléchargé les voix selectionnées, la voix par défaut anglaise sera utilisée.
 Pour les télécharger :  
 - (iOS 12) : Réglages > Général > Accessibilité > VoiceOver > Parole > Voix > et télécharger les voix désirées.  
 - (iOS 13) : Réglages > Accessibilité > VoiceOver > Parole > Voix > et télécharger les voix désirées.  
 Pensez à redémarrer votre appareil après avoir téléchargé une nouvelle voix, sans quoi, elle ne fonctionnera pas.
