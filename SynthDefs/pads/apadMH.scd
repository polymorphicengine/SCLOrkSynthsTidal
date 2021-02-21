/*Retrieved from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/apad_mh.scd

"A simple sustained sound with vibrato" --Mike Hairston

FreeVerb.ar added by Josh Mitchell.

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

// Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\apadMH, {
	arg
	//Standard Values:
	out = 0, pan = 0.5, freq = 880, att_ = 0.4, dec_ = 0.5, sus_ = 0.8, rel_ = 1.0, gate_ = 1,
	//Other Controls:
	vibratoRate = 4, vibratoDepth = 0.015, tremoloRate = 5,
	//These controls go from 0 to 1:
	tremoloDepth = 0.5, reverbMix = 0.5, roomSize = 1, damp = 0.5;

	var env, snd, vibrato, tremolo, mod2, mod3, amp;

	amp = 0.5;

	env = Env.adsr(att_, dec_, sus_, rel_).kr(gate: gate_);
	vibrato = SinOsc.kr(vibratoRate).range(freq * (1 - vibratoDepth), freq * (1 + vibratoDepth));
	tremolo = LFNoise2.kr(1).range(0.2, 1) * SinOsc.kr(tremoloRate).range((1 - tremoloDepth), 1);

	snd = SinOsc.ar(freq: [freq, vibrato], mul:(env * tremolo * amp)).distort;
	snd = Mix.ar([snd]);
	snd = FreeVerb.ar(snd, reverbMix, roomSize, damp);

	DetectSilence.ar(snd, 0.0001, 0.2, doneAction: 2);
	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata:(
	credit: "Mike Hairston",
	tags: [\pad, \vibrato, \sustained]
	)
).add