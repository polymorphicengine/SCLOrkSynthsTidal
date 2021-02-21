/*
A SynthDef by Josh Mitchell, August 2019.
SCLOrk, Santa Clara University

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("steelDrum", {
	arg freq = 440, out = 0, pan = 0.5, att_ = 0.01, dec_ = 1.5, crv = -6, filterHarmonic = 6;

	var resFreqArray, resAmpArray, resDecArray, enva, envb, envc, snda, sndb, sndc, snd, amp;

	amp = 0.1;

	//Arrays for the bank of resonators, mostly harmonics near 5ths and 9ths, and random amplitudes:
	resFreqArray = [2, 2.98, 4.75, 6.21, 9, 9.15, 11.87];
	resAmpArray = [0.35, 0.23, 0.10, 0.06, 0.07, 0.05, 0.01];
	resDecArray = [0.86, 0.72, 0.37, 0.55, 0.32, 0.21, 0.16];

	//Custom envelope shapes attempting to capture the aparrent "bloom" of a note:
	enva = Env.pairs([[0, 0], [att_, 1], [(att_ + dec_), 0]], crv).kr;
	envb = Env.pairs([[0, 0], [(att_ * 5), 0.25], [(att_ * 6), 0.75], [((att_ * 6) + (dec_ / 2)), 0]], crv).kr;
	envc = Env.pairs([[0, 0], [(att_ * 5), 0.1], [(att_ * 8), 0.5], [((att_ * 8) + (dec_ / 3)), 0]], crv).kr;

	//Fundamental, octave up, and a bank of enharmonic resonators excited by a metalic sound:
	snda = SinOsc.ar(freq: freq, mul: enva);
	sndb = SinOsc.ar(freq: freq * 2.015, mul: envb);
	sndc = DynKlank.ar(
		specificationsArrayRef:
		    Ref.new([
		    	resFreqArray * freq,
		    	resAmpArray,
			    resDecArray * dec_
		    ]),
		input:
		LPF.ar(HPF.ar(CombN.ar(PinkNoise.ar(1), 1/freq, 1/freq, -1, envc), freq * 2), freq * filterHarmonic)
	);

	//Output stages with a tiny bit of compression to smooth things out:

	snd = Mix.ar([snda, sndb, sndc]) * (amp / 3);
	snd = Limiter.ar(snd, amp);
	DetectSilence.ar(in: snd, amp: 0.0001, time: 0.5, doneAction: 2);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));

},
metadata: (
	credit: "Josh Mitchell",
	category: \percussion,
	tags: [\pitched, \steelDrum, \steelPan]
	)
).add
