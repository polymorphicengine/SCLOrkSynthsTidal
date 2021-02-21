/* Received from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/snare_stein.scd

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

//Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef("snareStein", {
	arg
	//Standard Arguments
	out = 0, pan = 0.5, att_ = 0.0005, curve = -4, tonerel = 0.075, noiserel = 0.2,
	//Other Controls, blend ranges from 0 to 1.
	noisetop = 7040, noisebottom = 523, noiseamp = 0.2, tonelo = 185, tonehi = 330, toneamp = 0.5, blend = 0.2;

    var tone, noise, snd, amp;

	amp = 1;

	//Sines for the frequency of the drum:
    tone = SinOsc.ar(freq: [tonelo, tonehi]);

	tone = tone * Env.perc(
		                attackTime: att_,
		                releaseTime: [tonerel, 0.73 * tonerel],
		                level: toneamp,
		                curve: curve
	                ).kr;

	//Noise for the rattling of the snares: (original used WhiteNoise alone)
	noise = PinkNoise.ar(noiseamp * (1 - blend)) + WhiteNoise.ar(noiseamp * blend);

	noise = LPF.ar(in: noise, freq: noisetop);

	snd = noise * Env.perc(
		                attackTime: att_,
		                releaseTime: noiserel,
		                curve: curve
	                ).kr;

	snd = snd +	HPF.ar(
		            in: noise,
		            freq: noisebottom,
		            mul: Env.perc(
			                    attackTime: att_,
			                    releaseTime: 0.915 * noiserel,
			                    curve: curve
			                ).kr
	            );

	//Mix it all together:
	snd = Mix.ar(snd + tone) * amp;

	DetectSilence.ar(in: snd, doneAction: 2);

    Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));

},
metadata: (
	credit: "Original snare written by Esben Stein, I believe",
	category: \drums,
	tags: [\percussion, \drum, \snare]
	)
).add;