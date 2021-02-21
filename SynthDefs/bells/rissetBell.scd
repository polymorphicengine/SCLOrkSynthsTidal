//Edited by Martin Gius 02/21 to work with SuperDirt.

SynthDef("rissetBell", { arg out = 0, pan = 0.5, freq = 400, att_ = 0.005, rel_ = 2, gate = 1;
	var amps, durs, frqs, dets, doneActionEnv, snd, env, amp;

	amp = 0.1;

	amps = #[1, 0.67, 1, 1.8, 2.67, 1.67, 1.46, 1.33, 1.33, 1, 1.33];
	durs = #[1, 0.9, 0.65, 0.55, 0.325, 0.35, 0.25, 0.2, 0.15, 0.1, 0.075];
	frqs = #[0.56, 0.56, 0.92, 0.92, 1.19, 1.7, 2, 2.74, 3, 3.76, 4.07];
	dets = #[0, 1, 0, 1.7, 0, 0, 0, 0, 0, 0, 0];
	doneActionEnv = Env.linen(0, att_+rel_, 0).ar(gate: gate, doneAction: 2);
	snd = Mix.fill(11, {arg i;
	env = Env.perc(
			attackTime: att_,
			releaseTime: rel_ * durs[i],
			level: amps[i],
			curve: att_.explin(0.005, 4, -4.5, 0)
	).ar(gate: gate);
		SinOsc.ar(
			freq: freq * frqs[i] + dets[i],
			mul: amp * env
		);
	});
	snd = snd * doneActionEnv * 0.5;
	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "based on Jean-Claude Risset's bell",
	category: \bells,
	tags: [\percussion, \bell, \inharmonic]
)
).add;