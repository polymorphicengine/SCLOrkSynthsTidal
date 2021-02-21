/*
A silly little sound from my ongoing quest to make Pluck sound a little bit
less like Pluck. Here, the sound going in isn't a normal short impulse, but
a sine wave that gets quickly swept from one frequency down (or up!) to
another one. The idea comes from some percussion and modal synthesis
experiments I've done, and I wondered what this same technique would do to
Pluck. Turns out, it sounds kinda like a cartoony rubber band! So, I added a
little bit of pitch bend at the beginning of the note, controlled by bendTime
and bendMultiple, and called it a day.

By Josh Mitchell July 2020.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\rubberBand, {
	arg
	// Standard Values
	out = 0, freq = 75, pan = 0.5, rel_ = 1,
	// Impulse arguments (onFraction goes from 0 to 1, coef from -1 to 1)
	bendMultiple = 0.25, bendTime = 0.075, impulseStartFreq = 800,
	impulseStopFreq = 120, onFraction = 1, coef = 0.125;

	var impulse, freqline, snd, amp;

	amp = 1;

	// Stuff that gets sent into Pluck
	freqline = Line.ar(
		start: freq * bendMultiple,
		end: freq,
		dur: bendTime);

	impulse = SinOsc.ar(
		freq: Line.ar(
			start: impulseStartFreq,
			end: impulseStopFreq,
			dur: 1/freq * onFraction));

	// Pluck
    snd = Pluck.ar(
	    in: impulse,
	    trig: Impulse.ar(0),
	    maxdelaytime: 1/(freq * bendMultiple),
	    delaytime: 1/freqline,
	    decaytime: rel_,
	    coef: coef,
		mul: amp);

	// Output Stuff
    DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "Josh Mitchell",
	category: \bass,
	tags: [\pitched]
	)
).add;
