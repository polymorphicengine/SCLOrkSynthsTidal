/*
Original Author Unknown

Based on kik.scd and kick3.scd.^

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

//Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("kik3", {
	arg
	//Standard Values
	out = 0, pan = 0.5, freq = 66,
	//Amplitude Controls
	att_ = 0.01, dec_ = 0.1, decaylevel = 0.8, rel_ = 0.3, envCurve = -4,
	//Timbre Controls
	sweeptime = 0.08, sweepCurve = \exp, harmonic = 6, preamp = 3;

	var snd, env, fenv, amp;

	amp = 1;

	env = Env.new(levels: [0, amp, decaylevel * amp, 0], times: [att_, dec_, rel_], curve: envCurve).kr(doneAction: 2);

	fenv = Env.new(levels: [freq * harmonic, freq], times: [sweeptime], curve: sweepCurve).kr;

	snd = SinOsc.ar(freq: fenv, mul: preamp).distort;

    snd = Normalizer.ar(in: snd, level: env);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "Author Unknown",
	category: \drums,
	tags: [\unpitched, \bass]
	)
).add;