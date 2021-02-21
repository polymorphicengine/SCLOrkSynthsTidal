/*
I believe the original is by Bruno Ruviaro?

Modified by Josh Mitchell 8/19.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("sillyVoice", { arg
	out = 0, pan = 0.5, freq = 220, vibSpeed = 6, vibDepth = 0.04, vowel_ = 0, att_ = 0.05, rel_ = 0.1, lag = 1, gate_ = 1, crv = -4, kAmp = 0.05, kRel = 1;

	var vibrato, env, kEnv, in, va, ve, vi, vo, vu, snd, amp;

	amp = 0.5;

	vibrato = SinOsc.kr(freq: vibSpeed).range(1 / (1 + vibDepth), (1 + vibDepth));

	env = Env.asr(
		attackTime: att_,
		sustainLevel: amp,
		releaseTime: rel_,
		curve: crv).kr(gate: gate_, doneAction: 2);

	kEnv = Env.perc(attackTime: att_, releaseTime: kRel, level: kAmp, curve: crv).kr;

	in = Saw.ar(freq: Lag.kr(in: freq, lagTime: lag) * vibrato, mul: env);

	in = in + WhiteNoise.ar(kEnv);

	va = BBandPass.ar(
		in: in,
		freq: [ 600,  1040,   2250,   2450,   2750  ],
		bw:   [ 0.1,  0.067,  0.049,  0.049,  0.047 ],
		mul:  [ 1,    0.447,  0.355,  0.355,  0.1   ]);

	ve = BBandPass.ar(
		in: in,
		freq: [ 400,  1620,   2400,   2800,   3100  ],
		bw:   [ 0.1,  0.049,  0.042,  0.043,  0.039 ],
		mul:  [ 1,    0.251,  0.355,  0.251,  0.126 ]);

	vi = BBandPass.ar(
		in: in,
		freq: [ 250,   1750,   2600,   3050,   3340  ],
		bw:   [ 0.24,  0.051,  0.038,  0.039,  0.036 ],
		mul:  [ 1,     0.032,  0.158,  0.079,  0.04  ] );

	vo = BBandPass.ar(
		in: in,
		freq: [ 400,  750,    2400,   2600,   2900  ],
		bw:   [ 0.1,  0.107,  0.042,  0.046,  0.041 ],
		mul:  [ 1,    0.282,  0.089,  0.1,    0.01  ]);

	vu = BBandPass.ar(
		in: in,
		freq: [ 350,    600,    2400,   2675,   2950  ],
		bw:   [ 0.114,  0.133,  0.042,  0.045,  0.041 ],
		mul:  [ 1,      0.1,    0.025,  0.04,   0.016 ]);

	snd = SelectX.ar(which: Lag.kr(in: vowel_, lagTime: lag), array: [va, ve, vi, vo, vu]);

	snd = Mix.ar(snd);

    Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));

},
metadata: (
	credit: "Bruno Ruviaro?",
	category: \misc,
	tags: [\pitched, \vocal]
	)
).add;