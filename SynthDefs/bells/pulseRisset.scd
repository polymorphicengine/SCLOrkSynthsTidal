//Edited by Martin Gius 02/21 to work with SuperDirt.

SynthDef("pulseRisset", {arg out = 0, freq = 440, att_ = 0.01, rel_ = 11, pan = 0.5, pulseFreq = 8;
    var partials, durs, amps, snd, env, amp;

	amp = 0.1;

 	partials = [246.4, 247.4, 404.8, 406.5, 523.6, 748, 880, 1206, 1320, 1654, 1791]; // original freqs
	partials = (partials / 440) * freq; // consider 440 the 'root'
	durs = [11, 10, 7, 6, 4, 3.4, 3, 2.2, 2, 1.1, 1] / 11;
	amps = durs.linlin(1, 11, 0.2, 1);

	env = Env.perc(
		attackTime: att_,
		releaseTime: durs * rel_,
		level: amps
	).kr(doneAction: [2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]); // only longest env gets doneAction: 2

	snd = Pulse.ar(partials) * env * amp / 11;

	snd = RLPF.ar(
		in: snd,
		freq: freq * LFPulse.ar(pulseFreq).range(2, 4),
		rq: SinOsc.ar(LFNoise2.kr(1).range(4, 9)).range(0.1, 0.3));

	snd = LPF.ar(snd, 12000);
	snd = Limiter.ar(Mix.ar(snd));

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "by Bruno Tucunduva Ruviaro, based on Jean-Claude Risset's bell",
	category: \bells,
	tags: [\percussion, \bell, \inharmonic]
)
).add;
