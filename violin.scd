/* Retrieved from
http://sccode.org/1-5aD

by nicolaariutti
http://sccode.org/1-5as

Modifications from the original include:

-Added Vibrato.ar, to better simulate left hand movement alongside the pre-existing pwm.
-Changed ASR envelope to ADSR and "scratch" envelopes, to simulate the attack of a bow.
-Added filters, to simulate tone brightening from the bridge and back of the instrument.

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\violin, {
	arg
	//Standard Definitions
	freq = 440, gate_ = 1, pan = 0.5, out = 0, att_ = 0.1, dec_ = 0.1, sus_ = 0.5, rel_ = 0.1,
	//Vibrato Controls
	vRate = 4.6, vDepth = 0.02, vAtt = 0.15, vRateVar = 0.25, vDepthVar = 0.05,
	//PWM Controls (pwmMax and pwmMin are 0 - 1)
	pwmVarRate = 2, pwmMin = 0.7, pwmMax = 0.8, pwmRate = 5,
	//Other Controls
	bridgeFreq = 2500, scratchDepth = 0.15;

	var scratch, env, pwm, snd, amp;

	amp = 1;

	scratch = 1.015 + Env.perc(att_, dec_ * 1.25, scratchDepth).kr;

	env = Env.adsr(att_, dec_, sus_, rel_).kr(gate: gate_, doneAction: 2);

	freq = Vibrato.kr(
		            freq: freq,
		            rate: vRate,
		            depth: vDepth,
	            	delay: (att_ + dec_),
		            onset: vAtt,
		            rateVariation: vRateVar,
		            depthVariation: vDepthVar
            	);

	pwm = SinOsc.kr(freq: pwmRate, phase: Rand(0.0, 1.0)).range(pwmMin, pwmMax);
	pwm = pwm * LFNoise2.kr(pwmVarRate).range(0.2, 0.8);

	snd = VarSaw.ar(
		freq: Lag.kr(freq) * LFPulse.ar(freq * 1.5).range(1/scratch, scratch),
		width: pwm,
		mul: amp
	);

	snd = (snd * 0.7) + BPF.ar(snd, bridgeFreq, 2, 2);
	snd = snd + HPF.ar(snd, bridgeFreq * 2);
	snd = snd * env;
	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "Original by nicolaariutti, modified by Josh Mitchell",
	category: \strings,
	tags: [\bowed, \pitched, \violin]
	)
).add;