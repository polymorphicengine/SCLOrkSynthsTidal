/* Retrieved from
http://sccode.org/1-5aD

Original from SC Examples Folder some small pieces, Julian Rohrhuber, 2007

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\strings, {
	arg
	//Standard Definitions
	out = 0, freq = 440, gate_ = 1, pan = 0.5, freqLag = 0.2, att_ = 0.001, dec_ = 0.1, sus_ = 0.75, rel_ = 0.3,
	//Other Controls (mix ranges from 0 - 1)
	rq = 0.001, combHarmonic = 4, sawHarmonic = 1.5, mix = 0.33;

	var env, snd, combFreq, amp;

	amp = 1;

	combFreq = 1 / (Lag.kr(in: freq, lagTime: freqLag / 2) * combHarmonic);

	env = Env.adsr(att_, dec_, sus_, rel_, amp).kr(gate: gate_, doneAction: 2);

	snd = SyncSaw.ar(syncFreq: freq * WhiteNoise.kr().range(1/1.025, 1.025), sawFreq: freq * sawHarmonic, mul: 8);
	snd = (snd * (1 - mix)) + PinkNoise.ar(180 * mix);
	snd = CombL.ar(snd, combFreq, combFreq, -1); //Try positive 1 for decay time as well.
	snd = Resonz.ar(snd, Lag.kr(in: freq, lagTime: freqLag), rq).abs;
	snd = snd * env;
	snd = Limiter.ar(snd, amp);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "Original from Julian Rohrhuber, 2007",
	category: \strings,
	tags: [\pitched]
	)
).add;