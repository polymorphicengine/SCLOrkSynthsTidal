/* Received from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/kick_oto309.scd

A wide variety of sounds can be achieved through changing the "Other Controls" section.
A siren sound is also available if you extend the attack and release.

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

//Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("kick_oto309", {
	arg
	//Standard Values:
	out = 0, pan = 0.5, att_ = 0.005, rel_ = 0.29, curve = -4,
	//Other Controls:
	filterHarmonic = 1.5, preamp = 1.25, pulseAmp = 0.5, noiseAmp = 1, sineAmp = 1;

	var env, envp, snd, amp;

	amp = 0.1;

	env = Env.new(levels: [0.5, 1, 0.5, 0], times: [att_, rel_ * 0.2, rel_ * 0.9], curve: [curve, curve/2, curve]).kr(doneAction:2);
	envp = Env.new(levels: [110, 59, 29], times: [att_, rel_], curve: [curve, curve * 1.25]).kr.midicps;

	snd = LFPulse.ar(freq: envp).range(-1 * pulseAmp, pulseAmp);
	snd = snd + WhiteNoise.ar(mul: noiseAmp);
	snd = LPF.ar(in: snd, freq: envp * filterHarmonic, mul: env);
	snd = snd + SinOsc.ar(freq: envp, phase: 0.5, mul: env * sineAmp);

	snd = Mix.ar(snd) * preamp;
	snd = snd.clip2(1) * amp;

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "Originally from 08091500Acid309 by_otophilia",
	category: \drums,
	tags: [\kick, \drum, \percussion]
	)
).add;