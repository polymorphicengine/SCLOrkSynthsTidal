/*
This SynthDef uses BPF in a manner similar to DynKlank.
BPF gets hit with an impulse (Saw.ar(0)), and outputs a sine wave
with a sharp attack, and a decay and amplitude both determined by rq.

Modified by Bruno Ruviaro and Josh Mitchell July 2019 and June 2020.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\marimba1, {
	arg
	// Standard values
	freq = 440, out = 0, pan = 0.5, rq = 0.02,
        // Controls for BLowShelf
	shelffreq = 220, rs = 0.81, shelfamp = 2;

	var snd, amp;

	amp = 0.4;

	snd = BPF.ar(
		in: Saw.ar(0),
		freq: freq,
		rq: rq);

	snd = BLowShelf.ar(
		in: snd,
		freq: shelffreq,
		rs: rs,
		db: shelfamp.ampdb);

	snd = Limiter.ar(snd) * amp;

	DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "unknown",
	category: \percussion,
	tags: [\percussion, \marimba, \pitched, \keyboard]
)
).add;
