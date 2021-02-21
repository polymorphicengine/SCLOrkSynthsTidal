/*
James Harkins
http://doc.sccode.org/Tutorials/A-Practical-Guide/PG_04_Words_to_Phrases.html

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("bassWarsaw", {
	arg
	//Standard Values:
	out = 0, freq = 440, gate_ = 1, pan = 0.5, att_ = 0.01, dec_ = 0.3, sus_ = 0.4, rel_ = 0.1,
	//Other Controls:
	slideTime = 0.17, cutoff = 1100, width = 0.15, detune = 1.005, preamp = 4;

	var snd, env,amp;

	amp = 0.5;

	env = Env.adsr(att_, dec_, sus_, rel_).kr(gate: gate_, doneAction: 2);
	freq = Lag.kr(freq, slideTime);
	snd = VarSaw.ar(freq: [freq, freq * detune], width: width, mul: preamp);
	snd = Mix(snd).distort;
	snd = snd * env;
	snd = LPF.ar(snd, cutoff, amp);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "James Harkins",
	category: \bass,
	tags: [\bass, \synth, \pitched]
	)
).add;