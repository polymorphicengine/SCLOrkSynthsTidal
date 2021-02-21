/* Received from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/ping_mh.scd

Note from the author:

Your basic percussive synth instrument, a good default sound for testing patterns, etc.

Modified By Bruno Ruviaro and Josh Mitchell 8/19.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\ping_mh,{

	arg freq = 440, dur_ = 1, att_ = 0.001, crv = -4, pan = 0.5, out = 0, rate = 4, depth = 0.03;

	var snd, lfo, env, amp;

	amp = 0.2;

	lfo = LFNoise2.ar(rate).range(1 / (1 + depth), (1 + depth));

	env = Env.perc(attackTime: att_, releaseTime: dur_, level: amp, curve: crv).kr(doneAction:2);

	snd = SinOsc.ar(freq: [freq, freq * lfo], mul: env);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));

},
metadata: (
	credit: "Author Unknown",
	category: \misc,
	tags: [\percussive, \ping, \default, \simple, \stereo, \detuned, \tuned]
	)
).add;