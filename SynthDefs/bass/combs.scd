/*
A SynthDef by Josh Mitchell, 8/19.

The core sound comes from brown noise being sent through two comb filters in series.
The first comb filter randomly fluctuates around the root frequency, creating an effect
halfway between vibrato and a flanger. The second filter is set to a harmonic of the
root frequency. After that, a tiny bit of runaway low end gets filtered out and the
sound is sent through an envelope filter for a vocal sort of sound.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("combs", {
	arg
	//Standard Arguments
	out = 0, pan = 0.5, freq = 440, gate_ = 1, att_ = 0.01, dec_ = 0.1, sus_ = 0.7, rel_ = 0.5,
	//Other Controls
	rate = 6, depth = 0.2, regen = -3, sweep = 16, rq = 0.5, harmonic = 1.5;

	var max, min, vibrato, snd, env, filterenv, amp;

	amp = 0.1;

	//Setting some values for the filters:
	max = ((1 + depth) / freq);
	min = (1 / (freq * (1 + depth)));
	vibrato = LFNoise1.ar(rate).range(min, max);

	//Amplitude and filter cutoff envelopes
	env = Env.adsr(att_, dec_, sus_, rel_).kr(gate: gate_, doneAction: 2);
	filterenv = Env.perc(att_, rel_).kr;
	filterenv = ((filterenv * sweep) + 1) * freq;

	//The core noise:
	snd = BrownNoise.ar(1);
	snd = CombL.ar(snd, max, vibrato, regen);
	snd = CombN.ar(snd, harmonic / freq, harmonic / freq, regen, env);

	//More filters and output stuff:
	snd = RHPF.ar(snd, freq * 4, rq);
	snd = RLPF.ar(snd, filterenv, rq, amp);
	snd = Limiter.ar(snd, amp);
	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "Josh Mitchell",
	category: \bass,
	tags: [\metallic, \bass, \synth, \pitched]
	)
).add