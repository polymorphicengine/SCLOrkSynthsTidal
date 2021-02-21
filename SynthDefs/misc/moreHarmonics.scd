/*
moreHarmonics does exactly what it says: it gives an input more harmonics.

It uses a few methods for doing so (but not every possible method):
-two methods for saturation (.softclip and .tanh, which is more distorted),
-two methods for wavefolding, one smooth (SinOsc.ar) and one sharp (.fold),
-a way of wrapping waves around from 1 to -1, like the sides in pacman (.wrap),
-and a sort of square-wave-ifier using a Schmitt trigger.

You can mix between them with blend, select, and focus. Blend goes from 0 to 1,
and determines the amount of square-wave-ification. Select goes from 0 to 4, and
chooses between the other 5 methods in the order I listed them. Focus blends in
adjacent methods from that list.

Preamp sets the gain of the sine wave going into all this stuff, and determines
the timbre of the sound. Threshold is the threshold of the Schmitt trigger.

By Josh Mitchell June 2020.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("moreHarmonics", {
    arg
	// Standard Values^
	out = 0, pan = 0.5, freq = 160, gate_ = 1,
	att_ = 0.05, dec_ = 0.1, sus_ = 0.6, rel_ = 0.7, crv = -2,
	// Other controls
	preamp = 15, blend = 0, select = 2, focus = 0, threshold = 0.1;

	var env, snd, thresh, amp;

	amp = 0.1;


	// Envelope:
	env = Env.adsr(
		attackTime: att_,
		decayTime: dec_,
		sustainLevel: sus_,
		releaseTime: rel_,
		curve: crv).ar(gate: gate_, doneAction: 2);
	env = env * preamp;

	// The sound being sent through everything:
	snd = SinOsc.ar(freq: freq, mul: env);

	// The list of tricks:
	snd = [
		snd.softclip,
		snd.tanh,
		SinOsc.ar(freq: 0, phase: (snd * pi/2).mod(2pi)),
		snd.fold(-1, 1),
		snd.wrap(-1, 1)
	];

	// Schmitt trigger
	thresh = threshold.clip(0, 0.9999);
	snd = (Schmidt.ar(snd, -1 * thresh, thresh) * blend) + (snd * (1 - blend));

	// Mixing it all together
	snd = SelectXFocus.ar(
		which: select.clip(0, 4),
		array: snd,
		focus: 1 - focus.clip(0, 1).sqrt,
		wrap: false);

	// Output Stuff:
	snd = Mix.ar(snd) * amp;
	snd = Limiter.ar(snd);

    Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));

},
metadata: (
	credit: "Josh Mitchell",
	category: \misc,
	tags: [\pitched]
	)
).add;