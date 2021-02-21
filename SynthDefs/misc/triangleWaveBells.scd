/*
Mitchell Sigman (2011) Steal this Sound. Milwaukee, WI: Hal Leonard Books
pp. 10-11

Adapted for SuperCollider and elaborated by Nick Collins
http://www.sussex.ac.uk/Users/nc81/index.html
under GNU GPL 3 as per SuperCollider license

Minor modifications by Bruno Ruviaro, June 2015.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("triangleWaveBells",{
	arg out = 0, pan = 0.5, freq = 440, gate_ = 1, att_ = 0.01, dec_ = 0.1, sus_ = 1, rel_ = 0.5, lforate = 10, lfowidth = 0.0, cutoff = 100, rq = 0.5;

	var osc1, osc2, vibrato, filter, env, snd, amp;

	amp = 1;

	vibrato = SinOsc.ar(lforate, Rand(0, 2.0));
	osc1 = Saw.ar(freq * (1.0 + (lfowidth * vibrato)), 0.75);
	osc2 = Mix(LFTri.ar((freq.cpsmidi + [11.9, 12.1]).midicps));
	filter = RHPF.ar((osc1 + (osc2 * 0.5)) * 0.5, cutoff, rq);
	env = EnvGen.ar(
		envelope: Env.adsr(att_, dec_, sus_, rel_, amp),
		gate: gate_,
		doneAction: 2);

	snd = filter* env;

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
}).add;