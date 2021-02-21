//Edited by Martin Gius 02/21 to work with SuperDirt.

(
SynthDef("hihat1", {

	arg out = 0, att_ = 0.01, rel_ = 0.2, ffreq = 6000, pan = 0.5;
	var snd, env, amp;

	amp = 0.1;

	snd = WhiteNoise.ar(amp);
	env = Env.perc(att_, rel_).kr(doneAction: 2);
	snd = HPF.ar(snd * env, ffreq);
	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Bruno Tucunduva Ruviaro",
	category: \drums,
	tags: [\percussion, \hihat]
)
).add;
)