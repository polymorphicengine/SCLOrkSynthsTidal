// Edited by Martin Gius 02/21 to work with SuperDirt.

SynthDef("harpsichord1", {

	arg out = 0, freq = 440, pan = 0.5;
    var env, snd, amp;

	amp = 0.1;

	env = Env.perc(level: amp).kr(doneAction: 2);
	snd = Pulse.ar(freq, 0.25, 0.75);
	snd = snd * env;
	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "unknown",
	category: \keyboards,
	tags: [\pitched, \harpsichord]
)
).add;