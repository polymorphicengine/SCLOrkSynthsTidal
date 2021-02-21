/*
Mitchell Sigman (2011) Steal this Sound. Milwaukee, WI: Hal Leonard Books
pp. 14-15

Adapted for SuperCollider and elaborated by Nick Collins
http://www.sussex.ac.uk/Users/nc81/index.html
under GNU GPL 3 as per SuperCollider license

Minor modifications by Bruno Ruviaro, June 2015.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

x = SynthDef("werkit2", {
	arg out = 0, freq = 440, gate_ = 1, rq = 0.1, att_ = 0.01, dec_ = 0, sus_ = 1, rel_ = 0.1, pan = 0.5;

	var source, filter, env, snd, amp;

	amp = 0.1;

	source = LFSaw.ar(Array.fill(16, { Rand(100, 200) }));
	filter = BLowPass4.ar(source, freq, rq) * 0.1;
	env = EnvGen.ar(
		envelope: Env.adsr(att_, dec_, sus_, rel_, amp),
		gate: gate_,
		doneAction: 2);
	snd = (0.7 * filter + (0.3 * filter.distort)) * env;
	snd = HPF.ar(snd, 100);
	snd = Splay.ar(snd);
	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
}).add;

