+++
date = "2017-06-20T12:11:09+05:30"
title = "Measuring flash durations - Digitek DFL-003 and Nikon SB-500"
draft = true
+++

Flash duration becomes very imortant aspect, especially in high speed photography. 

TODO: xxxxxxxxxxxxxxxxxxxxxx


## Optical pulse recorder

One can easily build light sensing device using a simple photo-diode and 3.5mm audio jack. Connect -ve terminal of photo diode to ground and +ve terminal to center pin of audio jack. Plug it into mic input port of your PC and you are ready to record any optical pulses as an audio recording. I used 'Audacity', a free audio recording software, for recording optical pulses. Ensure to disable any type of microphone enhancement settings in the Windows sound settings. E.g. Realtek sound card drivers have enhancement setting called 'DTS clear voice', which pre-processes microphone signals by default. We need clear input signal from microphone jack without any digital enhancements.

{{< figure src="/images/posts/measure-flash-durations/photo-diode-1.jpg" link="/images/posts/measure-flash-durations/photo-diode-1.jpg">}}

In order to get best possible visual presentation of optical pulses, use sampling rate of 96000 or more while recording in Audacity.

## Nikon SB-500

* Guide number (ISO 100) - 24m
* Power source - 2 AA batteries
* Flash Duration (Full Power) - 1/1100 Sec, i.e. 0.9 ms
* Flash Duration (lowest Power) - Not provided 

{{< figure src="/images/posts/measure-flash-durations/SB-500-1.png" link="/images/posts/measure-flash-durations/SB-500-1.png">}}

<br />
Following table shows actual flash duration readings taken for different flash powers. You can notice that Nikon official specs mention 0.9 ms duration for full power, but in reality my DIY setup finds it close to 2 ms. I measured full pulse duration right from zero level. Maybe Nikon using some specific formula to calculate flash duration. But at the end what you get in reality is what matter.

Surprisingly I find lowest power (i.e. 1 / 128) flash duration to be on higher side if compared to other third party flashes available in market. Even my Digitek DFL-003, which is one of the cheapest flash available in market, surpassed low power flash duration tests with Nikon.


| Manual flash power 	| Flash duration 	|
|:--------------------- |:----------------- |
| Full               	| 2 ms           	|
| 1 / 1.3              	| 1.9 ms         	|
| 1 / 1.7              	| 830 μs         	|
| 1 / 2                	| 500 μs         	|
| 1 / 4                	| 225 μs           	|
| 1 / 8                	| 160 μs           	|
| 1 / 16               	| 100 μs           	|
| 1 / 40               	| 75 μs            	|
| 1 / 80               	| 60 μs            	|
| 1 / 128              	| 50 μs            	|


## Digitek DFL-003

One of the cheapest and in-demand flash available in market today. I bought this as backup flash for occassional in-house photography experiments. Even though it's limited in functionality, it surprises me with value we get for such low cost. 

Some of the official specs:

* Guide number (ISO 100) - 38m
* Power source - 4 AA batteries
* Flash Duration (Full Power) - 1/200 Sec, i.e. 5 ms
* Flash Duration (lowest Power) - 1/20000 Sec, i.e. 50 μs
