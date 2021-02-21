/* Received from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/oneclap_thor.scd

published on the sc-users list 2009-01-08 by thor

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

//Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("oneclapThor", {
	arg
	//Standard Values
	out = 0, att_ = 0.003, rel_ = 0.00035, freq = 100, rq = 0.1, pan = 0.5,
	//Other Controls
	echohz1 = 33.333, echohz2 = 33.156, curve = -4, dec_ = 0.06, shelfFreq = 7000, rs = 0.5, db = -3,
	// Controls Ranging from 0 to 1
	size_ = 0.15, tone = 0.4, mix = 0.23, damp = 0.5;

	var env, snd, noise1, noise2, hpf1, hpf2, delay1, delay2, amp;

	amp = 0.1;

	noise1 = GrayNoise.ar(1 - tone) + WhiteNoise.ar(tone);

	noise1 = noise1 + SinOsc.ar(freq: [freq / 2, freq / 2 + 4 ]);

	noise2 = PinkNoise.ar;

	noise2 = noise2 + SinOsc.ar(freq: [freq, (freq * 1.04)] * XLine.kr(start: 1, end: 0.01, dur: 3));

	hpf1 = RLPF.ar(in: noise1, freq: freq, rq: rq);

	hpf2 = RHPF.ar(in: noise1, freq: freq/2, rq: rq/4);

	env = Env.perc(attackTime: att_, releaseTime: rel_, curve: curve).kr;

	snd = Mix.ar(hpf1 + hpf2) * env;

	delay1 = CombN.ar(in: snd, maxdelaytime: 1.1/echohz1, delaytime: 1/echohz1, decaytime: dec_ / 2);

	delay2 = CombN.ar(in: snd, maxdelaytime: 1.1/echohz2, delaytime: 1/echohz2, decaytime: dec_);

	snd = FreeVerb.ar(in: Mix.ar(delay1 + delay2), mix: mix, room: size_, damp: damp, mul: amp);

	snd = BHiShelf.ar(in: snd, freq: shelfFreq, rs: rs, db: db);

	DetectSilence.ar(snd, doneAction: 2);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "original by thor",
	tags: [\clap, \handclap]
	)
).add;
