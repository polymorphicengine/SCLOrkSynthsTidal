//Edited by Martin Gius 02/21 to work with SuperDirt.

SynthDef("snare1", {

	arg out = 0, sinfreq = 180, att_ = 0.01, rel_ = 0.2, ffreq = 2000, pan = 0.5;
	var snd1, snd2, env, snd, amp;

	amp = 0.1;

	snd1 = WhiteNoise.ar(amp);
	snd2 = SinOsc.ar(sinfreq,0,amp);
	env = Env.perc(att_, rel_).kr(doneAction: 2);
	snd = HPF.ar(snd1, ffreq) + snd2;
	snd = snd * env;
	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "Bruno Tucunduva Ruviaro",
	category: \drums,
	tags: [\percussion, \snare]
)
).add;