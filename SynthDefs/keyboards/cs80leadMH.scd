/* Recieved from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/cs80lead_mh.scd

Vangelis/Blade Runner lead sound, based on tutorial by meastempo @ http://www.youtube.com/watch?v=Fne0oIEv-WI

Original by Mike Hairston

Pbindef notes copied from https://alijamieson.co.uk/2016/01/08/replicating-blade-runner-soundtrack

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("cs80leadMH", {
	arg
	//Standard Values
	freq = 440, gate_ = 1.0, pan = 0.5, out = 0,
	//Amplitude Controls
	att_ = 0.75, dec_ = 0.5, sus_ = 0.8, rel_ = 1.0,
	//Filter Controls
	fatt = 0.75, fdec = 0.5, fsus = 0.8, frel = 1.0, cutoff_ = 200,
	//Pitch Controls
	dtune = 0.002, vibspeed = 4, vibdepth = 0.015, ratio = 0.8, glide = 0.15;

	var env, fenv, vib, ffreq, snd, amp;

	amp = 0.5;


	//Envelopes for amplitude and frequency:
	env = Env.adsr(att_, dec_, sus_, rel_).kr(gate: gate_, doneAction: 2);
	fenv = Env.adsr(fatt, fdec, fsus, frel, curve:2).kr(gate: gate_);

	//Giving the input freq vibrato:
	vib = SinOsc.kr(vibspeed).range(1 / (1 + vibdepth), (1 + vibdepth));
	freq = Line.kr(start: freq * ratio, end: freq, dur: glide);
	freq = freq * vib;

	//See beatings.scd for help with dtune
	snd = Saw.ar([freq, freq * (1 + dtune)], mul: env * amp);
	snd = Mix.ar(snd);

	//Sending it through an LPF: (Keep ffreq below nyquist!!)
	ffreq = max(fenv * freq * 12, cutoff_) + 100;
	snd = LPF.ar(snd, ffreq);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "Mike Hairston",
	category: \keyboards,
	tags: [\lead, \modulation, \analog, \cs80, \vangelis, \bladerunner]
	)
).add;