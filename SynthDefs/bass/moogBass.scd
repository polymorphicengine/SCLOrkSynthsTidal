/*
Mitchell Sigman (2011) Steal this Sound. Milwaukee, WI: Hal Leonard Books
pp. 18-19

Adapted for SuperCollider and elaborated by Nick Collins
http://www.sussex.ac.uk/Users/nc81/index.html
under GNU GPL 3 as per SuperCollider license

Minor SynthDef modifications by Bruno Ruviaro, June 2015.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("moogBass", {
	arg out = 0, pan = 0.5, freq = 440, gate_ = 1, cutoff_ = 1000, gain_ = 2.0, lagamount = 0.01, att_ = 0.001, dec_ = 0.3, sus_ = 0.9, rel_ = 0.2, chorus = 0.7;

	var osc, filter, env, filterenv, snd, chorusfx, amp;

	amp = 0.1;

	osc = Mix(VarSaw.ar(
		freq: freq.lag(lagamount) * [1.0, 1.001, 2.0],
		iphase: Rand(0.0,1.0) ! 3,
		width: Rand(0.5,0.75) ! 3,
		mul: 0.5));

	filterenv = EnvGen.ar(
		envelope: Env.asr(0.2, 1, 0.2),
		gate: gate_);

	filter =  MoogFF.ar(
		in: osc,
		freq: cutoff_ * (1.0 + (0.5 * filterenv)),
		gain: gain_);

	env = EnvGen.ar(
		envelope: Env.adsr(att_, dec_, sus_, rel_, amp),
		gate: gate_,
		doneAction: 2);

	snd = (0.7 * filter + (0.3 * filter.distort)) * env;

	chorusfx = Mix.fill(7, {

		var maxdelaytime = rrand(0.005, 0.02);
		DelayC.ar(
			in: snd,
			maxdelaytime: maxdelaytime,
			delaytime: LFNoise1.kr(
				freq: Rand(4.5, 10.5),
				mul: 0.25 * maxdelaytime,
				add: 0.75 * maxdelaytime)
		)
	});

	snd = snd + (chorusfx * chorus);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));

},
metadata: (
	credit: "Nick Collins",
	category: \bass,
	tags: [\pitched, \bass]
)
).add;