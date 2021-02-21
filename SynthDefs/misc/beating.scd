/*
A SynthDef by Bruno Ruviaro built around beats, an acoustic phenomenon created when
two oscillators at slightly different frequencies are combined. We hear the beating
frequency as the difference between these two frequencies.

For example, 455hz - 440hz = 15 beats per second.

Slightly modified by Josh Mitchell 8/19.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("beating", {
	arg freq = 440, out = 0, pan = 0.5, att_ = 0.01, dec_ = 1, crv = -4, beatFreq = 15;

	var env, snd, oscillator1, oscillator2, amp;

	amp = 0.1;

	env = Env.perc(att_, dec_, amp, crv).kr(doneAction: 2);

	oscillator1 = SinOsc.ar(freq); //Try other waveforms for the oscillators! Mix and match, collect them all!
	oscillator2 = SinOsc.ar(Line.kr(freq + beatFreq, freq, dec_));

	snd = Mix([oscillator1, oscillator2]);
	snd = snd * env;

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));

},
metadata: (
	credit: "Bruno Ruviaro",
	category: \misc,
	tags: [\pitched]
	)
).add