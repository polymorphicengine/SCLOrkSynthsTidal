/*
Phasers are cool, here's a supercollider one:

By Josh Mitchell 11/19.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("phazer", {
    arg
	//Standard Values
	out = 0, pan = 0.5, freq = 440, gate_ = 1,
	att_ = 1, dec_ = 3, sus_ = 0, rel_ = 1.5, curve = -4,
    //Other controls
    rq = 0.5, rate = 1, minfreq = 100, maxfreq = 16000,
	drylevel = 1.5, fmdepth = 1.5, fmfreq = 432;

	var env, lfo, input, snd, amp;

	amp = 0.5;

	env = Env.adsr(
		    attackTime: att_,
	    	decayTime: dec_,
    		sustainLevel: sus_,
		    releaseTime: rel_,
	    	curve: curve
	    ).ar(doneAction: 2);

	//Controls the all pass freq; try an envelope here as well!
	lfo = LinExp.ar(LFTri.ar(rate), -1, 1, minfreq, maxfreq/8);
	//lfo = LinExp.ar(env, 0, 1, minfreq, maxfreq/8);

	//The input sound (Dense frequency content is better)
	input = LFSaw.ar(freq: SinOsc.ar(fmfreq).range(1, fmdepth) * freq, mul: env * amp);

	//All pass filter + dry sound = P H A Z E R
	snd = BAllPass.ar(input, [1, 2, 4, 8] * lfo, rq);
	snd = Mix.ar(snd);
	snd = snd + (input * -1 * drylevel);
	snd = Mix.ar(snd);

    Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));

},
metadata: (
	credit: "Josh Mitchell",
	category: \misc,
	tags: [\pitched, \effects]
	)
).add;