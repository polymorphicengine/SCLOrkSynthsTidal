/*
Author Unknown

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("pmCrotales", {
	arg out = 0, freq = 261, tone = 3, att_ = 0, rel_ = 2, crv = -6, pan = 0.5, modLo = 5.25, modHi = 5.5;

	var env, snd, mod, amp;

	amp = 0.8;

	env = Env.perc(attackTime: 0, releaseTime: rel_, curve: crv).kr(doneAction: 2);

	mod = Rand(modLo, modHi);

	snd = PMOsc.ar(
	    	carfreq: freq,
	    	modfreq: mod * freq,
	    	pmindex: env * tone,
	    	mul: env * amp
	    );

	snd = HPF.ar(snd, freq / 2);

	snd = Mix.ar(snd) * 0.1;

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "Author Unknown",
	category: \percussion,
	tags: [\pitched, \bell]
	)
).add;