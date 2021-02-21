/* Retrieved from
http://sccode.org/1-5aD

Original by Nick Collins, from Mitchell Sigman (2011) Steal this Sound
http://www.sussex.ac.uk/Users/nc81/index.html

Subtractive tonewheel organ from Steal this Sound example.

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\organTonewheel4,{
	arg
	//Standard Values
	out = 0, pan = 0.5, freq = 440, gate_ = 1, att_ = 0.0, dec_ = 0.0, sus_ = 1, rel_ = 0.1,
	//Other controls (blend goes from 0 to 1)
	lforate = 4.85, lfodepth = 0.006, cutoff_ = 5000, rq = 0.25, parfreq = 500, parrq = 1, pardb = 3, blend = 0.6;

	var lfo, pulse, filter, env, snd, amp;

	amp = 0.1;

	lfo = LFTri.kr(freq: lforate * [1, 1.01], iphase: Rand(0, 2.0) ! 2).range(1 / (1 + lfodepth), (1 + lfodepth));

	pulse = Pulse.ar(freq: freq * [1, 3] * lfo, width: [0.5, 0.51], mul: [(1 - blend), blend]);

	env = Env.adsr(attackTime: att_, decayTime: dec_, sustainLevel: sus_ * amp, releaseTime: rel_).kr(gate: gate_, doneAction: 2);

	filter = BLowPass4.ar(in: pulse, freq: cutoff_, rq: rq);

	filter = BPeakEQ.ar(in: filter, freq: parfreq, rq: parrq, db: pardb);

	snd = Mix.ar(filter) * env;

    Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));

},
metadata: (
	credit: "Nick Collins",
	category: \organ,
	tags: [\pitched]
	)
).add;