// Edited by Martin Gius 02/21 to work with SuperDirt.


SynthDef("blip1", {

	arg out = 0, freq = 25, numharm = 10, att_ = 0.01, rel_ = 1, pan = 0.5;
	var snd, env, amp;

	amp = 0.1;

	env = Env.perc(att_, rel_, amp).kr(doneAction: 2);
	snd = Blip.ar(
		freq: freq * [1, 1.01],
		numharm: numharm,
		mul: env
	);
	snd = LeakDC.ar(snd);
	snd = Mix.ar(snd);
	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},

metadata: (
	credit: "unknown",
	category: \pads,
	tags: [\pitched]
)
).add;




