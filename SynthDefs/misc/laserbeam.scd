/*
Mitchell Sigman (2011) Steal this Sound. Milwaukee, WI: Hal Leonard Books

Adapted for SuperCollider and elaborated by Nick Collins
http://www.sussex.ac.uk/Users/nc81/index.html
under GNU GPL 3 as per SuperCollider license

Minor modifications by Bruno Ruviaro, June 2015.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("laserbeam", {
	arg out = 0, pan = 0.5, freq = 440, att_ = 0.01;
	var snd, freqenv, ampenv, amp;

	amp = 0.1;

	// frequency envelope
	freqenv = EnvGen.ar(Env([4, 0.5, 1, 1], [att_, 0.01, 1.0]));
	// amplitude envelope
	// no gate: fixed-time envelope, self-terminating.
	ampenv = EnvGen.ar(
		envelope: Env([0, 1, 0.5, 0.0], [0.02, 0.2, 0.1]),
		levelScale: amp,
		doneAction: 2);
	snd = LFTri.ar(freq: freq * freqenv, mul: ampenv);
	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
}).add;