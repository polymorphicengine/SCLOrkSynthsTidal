//Edited by Martin Gius 02/21 to work with SuperDirt.

SynthDef("pluck", {

	arg out= 0, freq = 440, dec_ = 5, coef = 0.1, pan = 0.5;
	var env, snd, amp;

	amp = 0.1;

	env = EnvGen.kr(Env.linen(0, dec_, 0), doneAction: 2);
	snd = Pluck.ar(
		in: WhiteNoise.ar(amp),
		trig: Impulse.kr(0),
		maxdelaytime: 0.1,
		delaytime: freq.reciprocal,
		decaytime: dec_,
		coef: coef);
	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
}).add;