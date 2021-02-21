/* Retrieved from
http://sccode.org/1-5aD

Subtractive tonewheel organ with cheap CPU usage.

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\organTonewheel2, {
	arg
	//Standard Values
	out = 0, pan = 0.5, freq = 440, att_ = 0.001, rel_ = 0.1, gate_ = 1,
	//Other controls (blend goes from 0 to 1)
	vibRate = 6.0, vibHarmonic = 1.017, filterHarmonic = 5.04, rq = 1, blend = 0.83;

	var snd, env, vibrato, amp;

	amp = 0.45;

	env = Env.asr(attackTime: att_, sustainLevel: amp, releaseTime: rel_).kr(gate: gate_, doneAction: 2);

	vibrato = SinOsc.ar(freq: vibRate).range(freq, freq * vibHarmonic);

	snd = LFPulse.ar(freq: freq, width: 0.5, mul: 1 - blend) + LFPulse.ar(freq: freq + vibrato, width: 0.18, mul: blend);

	snd = RLPF.ar(in: snd, freq: filterHarmonic * freq, rq: rq, mul: env);

    snd = LeakDC.ar(snd);

    Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));

},
metadata: (
	credit: "Zé Craum",
	category: \organ,
	tags: [\pitched]
	)
).add;