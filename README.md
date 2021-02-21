SCLOrkSynthsTidal
======================
 
Modified collection of SuperCollider SynthDefs from SCLOrkSynths to work with TidalCycles.

Since some SuperDirt modules already respond to common arguments (like att, rel, etc.) these parameters cannot be used to control custom synths on the server. Thus I added an underscore to the end of these parameters.

## Installation

For the SynthDefs to work you need to install SuperDirt:
https://github.com/musikinformatik/SuperDirt

To load the SynthDefs on SuperDirt startup you need to copy them in the directory "~/.local/share/SuperCollider/downloaded-quarks/SuperDirt/synths". You can also create symbolic links and copy them in that directory.

## Sources

https://github.com/SCLOrkHub/SCLOrkSynths

## Some conventions

Most SynthDefs have the following arguments:

* out = 0,
* pan = 0, 
* freq = 440, for pitched synths
* att_ = 0.01, attack time of the main amplitude envelope
* rel_ = 1, release time of amplitude envelope
* sus_ = 1, sustain level (as in a typical ADSR)
* dec_ = 0.1, decay time (as in typical ADSR)
* gate_ = 1, if using envelopes like ADSR (not needed if using self terminating envs such as Env.perc)


