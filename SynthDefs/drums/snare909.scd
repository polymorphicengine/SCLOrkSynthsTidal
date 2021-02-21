/* Retrieved from
http://sccode.org/1-5aD

The original used WhiteNoise for noise.
This was replaced with Latch.ar(WhiteNoise.ar, Impulse.ar(nyquist * 2))
for an added aliasing effect

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

//Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("snare909", {
	arg
	//Standard Values
	out = 0, pan = 0.5, freq = 185, att_ = 0.0005, curve = -2,
	//Other Controls
	toneRel = 0.075, toneAmp = 0.25, noiseRel = 0.4, noiseAmp = 0.2,
	nyquist = 500, lpFreq = 7040, hpFreq = 523;

	var relTimes, env, tone, noise, snd, amp;

	amp = 1;

	relTimes = ([1, 0.733] * toneRel) ++ ([1, 0.708] * noiseRel);

	env = Env.perc(attackTime: att_, releaseTime: relTimes, level: amp, curve: curve).kr;

	tone = LFTri.ar(freq: [1, 1.78] * freq, mul: toneAmp);

	noise = Latch.ar(WhiteNoise.ar, Impulse.ar(nyquist * 2));

	noise = LPF.ar(in: noise, freq: lpFreq, mul: noiseAmp);

	snd = tone ++ [noise, HPF.ar(in: noise, freq: hpFreq)];

	snd = Mix.ar(snd * env);

	DetectSilence.ar(in: snd, doneAction: 2);

    Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));

},
metadata: (
	credit: "Author Unknown",
	category: \drums,
	tags: [\unpitched, \snare, \synth, \909]
	)
).add;