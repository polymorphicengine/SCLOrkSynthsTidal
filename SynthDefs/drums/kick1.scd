//Edited by Martin Gius 02/21 to work with SuperDirt.

SynthDef("kick1", {

	arg out = 0, freq = 60, glissf = 0.9, att_ = 0.01, rel_ = 0.45, pan = 0.5;
	var gliss, snd, env, amp;

	amp = 0.3;

	gliss = XLine.kr(freq, freq*glissf, rel_);
	snd = SinOsc.ar(gliss);
	env = Env.perc(att_, rel_).kr(doneAction: 2);
	snd = snd * env * amp;
	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "Bruno Tucunduva Ruviaro",
	category: \drums,
	tags: [\percussion, \kick]
)
).add;