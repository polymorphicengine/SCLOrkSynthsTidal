/*
Mitchell Sigman (2011) Steal this Sound. Milwaukee, WI: Hal Leonard Books
pp. 2-3

Adapted for SuperCollider and elaborated by Nick Collins
http://www.sussex.ac.uk/Users/nc81/index.html
under GNU GPL 3 as per SuperCollider license

Minor modifications by Bruno Ruviaro, June 2015.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("prophet5pwmStrings", {
	arg out = 0, pan = 0.5, freq = 440, gate_ = 1, att_ = 0.01, rel_ = 0, sus_ = 1, dec_ = 0.5, lforate = 10, lfowidth = 0.5, cutoff_ = 12000, rq = 0.5;

	var lfo, pulse, filter, env, snd, amp;

	amp = 1;

	lfo = LFTri.kr(lforate * [1, 1.01], Rand(0, 2.0) ! 2);
	pulse = Pulse.ar(freq * [1, 1.01], lfo * lfowidth + 0.5);
	filter = RLPF.ar(pulse, cutoff_, rq);
	env = EnvGen.ar(
		envelope: Env.adsr(att_, dec_, sus_, rel_, amp),
		gate: gate_,
		doneAction: 2);

	snd = Mix(filter) * env * 0.5;
	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
}).add;