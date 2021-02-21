//Edited by Martin Gius 02/21 to work with SuperDirt.

(
SynthDef("kick808", {

	arg out = 0, freq1 = 240, freq2 = 60, ringTime = 10, att_ = 0.001, rel_ = 1, dist = 0.5, pan = 0.5;
	var snd, env, amp;

	amp = 1;

	snd = Ringz.ar(
		in: Impulse.ar(0), // single impulse
		freq: XLine.ar(freq1, freq2, 0.1),
		decaytime: ringTime);
	env = Env.perc(att_, rel_, amp).kr(doneAction: 2);
	snd = (1.0 - dist) * snd + (dist * (snd.distort));
	snd = snd * env;
	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "unknown",
	category: \drums,
	tags: [\percussion, \kick, \808]
)
).add;
)