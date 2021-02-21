// Edited by Martin Gius 02/21 to work with SuperDirt.

SynthDef("noisy", {

	arg out = 0, freq = 440, pan = 0.5;
	var snd, env, amp;

	amp = 0.2;

	env = Env.perc(0.02, 0.1).kr(doneAction: 2);
	snd = Mix(LFPulse.ar(
		freq: freq * [1, 5/2],
		iphase: 0.0,
		width: 0.5,
		mul: amp));
	snd = snd * env ;
	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
}).add;