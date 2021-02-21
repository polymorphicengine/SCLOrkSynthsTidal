/* Retrieved from
http://sccode.org/1-5aD

// Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("sawSynth", { arg out = 0, freq = 440, att_ = 0.1, rel_ = 2, lofreq = 1000, hifreq = 3000, pan = 0.5;
    var env, snd, amp;

	amp = 0.1;

    env = Env.perc(
		attackTime: att_,
		releaseTime: rel_,
		level: amp
	).kr(doneAction: 2);
    snd = Saw.ar(freq: freq * [0.99, 1, 1.001, 1.008], mul: env);
	snd = LPF.ar(
		in: snd,
		freq: LFNoise2.kr(1).range(lofreq, hifreq)
	);
    snd = Mix.ar(snd);
	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
// Basic saw synth
//By Bruno Ruviaro
//http://sccode.org/1-54H
}).add;
