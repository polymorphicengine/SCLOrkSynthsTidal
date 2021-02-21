/*
Original author unknown, original used SinOsc.ar instead of Pulse.ar

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("trig_demo", {
	arg out = 0, pan = 0.5, freq = 440, gate_ = 1, t_trig = 1, att_ = 0.01, sus_ = 1, rel_ = 0.25;

    var env, snd;

	env = Decay2.kr(in: t_trig, attackTime: att_, decayTime: rel_);

	env = env * Linen.kr(gate: gate_, attackTime: att_, susLevel: sus_, releaseTime: rel_, doneAction: 2);

    snd = Pulse.ar(freq: freq, mul: env);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));

},
metadata: (
	credit: "Unknown",
	category: \misc,
	tags: [\pitched]
	)
).add;