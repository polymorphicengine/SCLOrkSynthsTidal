/*
Original Author Unknown.

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

//Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("kickRingz", {
	arg out = 0, pan = 0.5, freq = 40, dec_ = 0.25, ffreq = 1000;

	var snd, amp;

	amp = 1;

	snd = Ringz.ar(
		    in: LPF.ar(in: Impulse.ar(0), freq: ffreq),
		    freq: freq,
		    decaytime: dec_,
		    mul: amp
	);

	snd = snd.tanh.sin * 2;

	DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "Author Unknown",
	category: \drums,
	tags: [\unpitched, \bass]
	)
).add;