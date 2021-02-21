/*
Based on acid_oto309.scd

This version uses percussive envelopes for both amp and filter sweep.
Filter sweep is calculated in octaves

Modified by Bruno Ruviaro and Josh Mitchell, August 2019.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("acidOto3092", {
	arg
	// Standard Arguments
	out = 0, freq = 440, pan = 0.5, att_ = 0.001, rel_ = 0.5,
	// Other Controls
	// width is 0 to 1
	// filterRange is in octaves
	lagTime = 0.12, filterRange = 6, width = 0.51, rq = 0.3;

	var ampEnv, filterEnv, snd, pitch,amp;

	amp = 0.1;

	pitch = freq.cpsmidi; // Lag only useful if synth is played with Pmono

	ampEnv = Env.perc(
		attackTime: att_,
		releaseTime: rel_,
		level: amp
	).kr(doneAction: 2);

	filterEnv = Env.perc(
		attackTime: att_,
		releaseTime: rel_,
		level: filterRange * 12, // octaves to semitones
	).kr;

	snd = LFPulse.ar(freq: pitch.midicps, width: width).range(-1, 1);

	// filter sweeps from current pitch all the way up to <filterRange> octaves above and back down.
	snd = RLPF.ar(snd, (pitch + filterEnv).midicps, rq).distort;

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan, ampEnv));
},
metadata: (
	credit: "based on 08091500Acid309 by otophilia",
	category: \bass,
	tags: [\pitched, \acid, \phat, \subtractive]
	)
).add;