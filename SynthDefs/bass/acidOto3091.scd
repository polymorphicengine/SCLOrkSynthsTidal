/*
Retrieved from acid_oto309.scd
Envelopes from original changed to ADSR, filterRange calculated in octaves
Modified by Bruno Ruviaro and Josh Mitchell 8/19.

Edited by Martin Gius 02/21 to work with SuperDirt.

*/

SynthDef("acidOto3091", {
	arg
	// Standard Arguments
	out = 0, gate_ = 1, freq = 440, pan = 0.5, att_ = 0.001, dec_ = 0.5, sus_ = 0.1, rel_ = 0.5, curve = -4,
	// Other Controls
	// width is 0 - 1
	// filterRange is in octaves
	lagTime = 0.12, filterRange = 6, width = 0.51, rq = 0.3;

	var ampEnv, filterEnv, snd, amp;

	amp = 0.1;

	freq = Lag.kr(freq, lagTime);

	ampEnv = Env.adsr(
		attackTime: att_,
		decayTime: dec_,
		sustainLevel: sus_,
		releaseTime: rel_,
		peakLevel: amp,
		curve: [0, curve, curve, curve]
	).kr(gate: gate_);

	filterEnv = Env.adsr(
		attackTime: att_,
		decayTime: dec_ * 2,
		sustainLevel: sus_ / 2,
		releaseTime: rel_ * 2,
		peakLevel: 2.pow(filterRange), // octaves multiplier
		curve: [-1 * curve, curve, curve, curve],
		bias: 1 // env sweeps from 1 to 2.pow(filterRange) and back
	).kr(gate: gate_, doneAction: 2);

	snd = LFPulse.ar(freq: freq, width: width).range(-1, 1);

	snd = RLPF.ar(snd, freq * filterEnv, rq);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan, ampEnv));
},
metadata: (
	credit: "08091500Acid309 by otophilia",
	category: \bass,
	tags: [\pitched, \acid, \phat, \subtractive]
	)
).add;
