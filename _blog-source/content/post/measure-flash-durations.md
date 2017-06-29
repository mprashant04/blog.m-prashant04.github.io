+++
date = "2017-06-20T12:11:09+05:30"
title = "Measuring flash durations - Digitek DFL-003 and Nikon SB-500"
draft = true
+++

Flash duration becomes very imortant aspect, especially in high speed photography. 

TODO: xxxxxxxxxxxxxxxxxxxxxx


## Optical pulse recorder

One can easily build light sensing device using a simple photo-diode and 3.5mm audio jack. Connect -ve terminal of photo diode to ground and +ve terminal to center pin of audio jack. Plug it into mic input port of your PC and you are ready to record any optical pulses as an audio recording. I used 'Audacity', a free audio recording software, for recording optical pulses. Ensure to disable any type of microphone enhancement settings in the Windows sound settings. E.g. Realtek sound card drivers have enhancement setting called 'DTS clear voice', which pre-processes microphone signals by default. We need clear input signal from microphone jack without any digital enhancements.

![Photo-diode sensor](http://blog.mprashant.com/images/posts/measure-flash-durations/photo-diode-1.jpg)

In order to get best possible visual presentation of optical pulses, use sampling rate of 96000 or more while recording in Audacity.

## Nikon SB-500

* Guide number (ISO 100) - 24m
* Power source - 2 AA batteries
* Flash Duration (Full Power) - 1/1100 Sec

