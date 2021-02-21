/* Retrieved from
http://sccode.org/1-5aD

By Nathan Ho aka Snappizz
http://sccode.org/1-51l

This kalimba is based on a bank of resonators:
The basic tone is a SinOsc, whose release is randomized a little to add variation.
The "clicking" sounds are modeled with a bank of resonators excited by a short burst of noise.
There are two high resonant freqs, and one quiet "bass" freq to give it some depth.
These resonant freqs are randomized a little to add variation.

Modified By Josh Mitchell and Bruno Ruviaro July 2019.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\kalimba, {
	arg
	// Standard values
	out = 0, freq = 440, att_ = 0.001, rel_ = 3, pan = 0.5, crv = -8,
	// Other controls (mix control goes from 0 to 1)
	mix = 0.1, clickRel = 0.01;

	var note, env, body, snd, amp;

	amp = 0.1;

	env = Env.perc(
		attackTime:att_ * 3, releaseTime: rel_,
		curve: crv).kr(doneAction: 2);

	note = SinOsc.ar(freq) * env;

	body = DynKlank.ar(
		specificationsArrayRef:
		Ref.new([
			[240 * ExpRand(0.9, 1.1), 2020 * ExpRand(0.9, 1.1), 3151 * ExpRand(0.9, 1.1)],
			[-7, 0, 3].dbamp, // same as 10.pow([-7, 0, 3] / 20),
			[0.75, 0.04, 0.06] + clickRel
		]),
		input:
		// Try BrownNoise, GrayNoise, etc. here, but you may need to change ring times above
		(PinkNoise.ar * Env.perc(att_, clickRel).kr)
	);

	snd = (note * (1 - mix)) + (body * mix) * amp;

	DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "by Nathan Ho aka Snappizz",
	category: \percussion,
	tags: [\pitched, \kalimba]
)
).add;
