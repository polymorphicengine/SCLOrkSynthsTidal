/*
Original Author Unknown

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

//Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("kraftySnare", {
	arg freq = 2000, rq = 3, att_ = 0.01, dec_ = 0.3, curve = -6, pan = 0.5, out = 0;

	var snd, env, amp;

	amp = 1;

	env = Env.perc(attackTime: att_, releaseTime: dec_, curve: curve).kr(doneAction: 2);

	snd = PinkNoise.ar(amp);

	snd = BPF.ar(snd, freq, rq, env * rq.reciprocal * 2);

	snd = Limiter.ar(snd);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "Author Unknown",
	category: \drums,
	tags: [\unpitched, \snare]
	)
).add;