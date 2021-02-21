/* Retrieved from
http://sccode.org/1-5aD

Harpsichord based on Pluck Ugen
Original by Zé Craum

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\harpsichord2, {
	arg
	//Standard Values
	out = 0, freq = 440, pan = 0.5, rel_ = 5,
	//Pluck arguments (blend goes from 0 to 1)
	trig = 1, coef = 0.1, blend = 0.6;

	var exciter, root, octave, snd, amp;

	amp = 0.1;

        // You can use white noise here, but Pink is more realistic
	exciter = PinkNoise.ar(amp);

	// Fundamental
        root = Pluck.ar(
	        in: exciter,
	        trig: trig,
	        maxdelaytime: 1/freq,
	        delaytime: 1/freq,
	        decaytime: rel_,
	        coef: coef,
	        mul: blend
        );

	// Octave Above
	octave = Pluck.ar(
	        in: exciter,
	        trig: trig,
	        maxdelaytime: 1/(2 * freq),
	        delaytime: 1/(2 * freq),
	        decaytime: rel_,
	        coef: coef,
	        mul: (1 - blend)
        );

	// Output Stuff
	snd = Mix.ar(root + octave);
	snd = Limiter.ar(snd);

    DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "Zé Craum",
	category: \keyboards,
	tags: [\pitched]
	)
).add;
