/* Retrieved from
http://sccode.org/1-5aD
Original by Zé Craum

Crude simulation of old sinusoidal generators - with random vibrato and a high noise floor.

50hz mains hum emulation and slightly distorted sine (a clipped triangle wave) added by Josh Mitchell.

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\vintageSine, {
	arg
	//Standard Definitions
	freq = 440, pan = 0.5, att_ = 0.001, sus_ = 1, rel_ = 0.5, gate_ = 1, out = 0,
	//Noise Arguments (mainsDepth is 0 to 1)
	noiseAmp = 0.06, mainsDepth = 0.1, mainsHz = 50,
	//Sine Arguments
	vrate = 2, vdepth = 0.005, sineClip = 0.825;

	var noise, env, snd, vibrato, amp;

	amp = 0.2;

	env = Env.asr(att_, amp, rel_, curve: \lin).kr(gate: gate_, doneAction: 2);

	noise = PinkNoise.ar(noiseAmp * LFPar.ar(mainsHz * 2).range((1 - mainsDepth), 1));
	noise = noise + LFPar.ar(freq: mainsHz, mul: noiseAmp/8);

	vibrato = freq * LFNoise2.ar(vrate).range(1/(1 + vdepth), (1 + vdepth));

	snd = Clip.ar(LFTri.ar(vibrato), -1 * sineClip, sineClip).softclip;
	snd = ((snd * amp) + noise) * env;

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));

},
metadata: (
	credit: "Zé Craum; Josh Mitchell",
	category: \misc,
	tags: [\vintage, \pitched]
	)
).add;