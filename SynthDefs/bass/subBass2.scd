/*
A sub Bass based on octave-down guitar/bass effects from the 80s or so.
This version changes where on the input wave switching happens,
meaning the sub octave is more distorted and gritty than subBass1.

Josh Mitchell, 8/19.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\subBass2, {
    arg
	//Blend goes from 0 to 1
	out = 0, pan = 0.5, freq = 440, att_ = 0.001, rel_ = 1, curve = 8, blend = 0.5;

    var env, in, ina, synca, octa, inb, syncb, octb, octave, snd, amp;

	amp = 0.5;

	//A slightly rounded percussive envelope
	env = Env.perc(att_, rel_, amp, [curve, -1 * curve]).kr(doneAction: 2);

	/*  Input wave +/- 90 degrees - To use SinOsc.ar, replace:
	        -"iphase:  0" with "phase: pi/2"
	        -"iphase:  1" with "phase: 0"
	        -"iphase: -1" with "phase: pi"   */
	in = LFPar.ar(freq: freq * 2, iphase: 0);
	ina = LFPar.ar(freq: freq * 2, iphase: 1);
	inb = LFPar.ar(freq: freq * 2, iphase: -1);

	//Two square waves exactly out of phase and an octave below the input wave
	synca = LFPulse.ar(freq: freq, iphase: 0);
	syncb = LFPulse.ar(freq: freq, iphase: 0.5);

	//This smoothly swaps between outputting the +90 degree wave and -90 degree wave
	octa = ina * synca;
	octb = inb * syncb;
	octave = Mix.ar([octa, octb]);

	//Mixer stage, volume adjustments, envelope, and output
	snd = Mix.ar([octave * blend, in * (blend - 1)]);
    snd = LeakDC.ar(snd);
	snd = Limiter.ar(in: snd, level: 1);
	snd = snd * env;


	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "Josh Mitchell, 2019",
	category: \bass,
	tags: [\pitched, \sub]
	)
).add;