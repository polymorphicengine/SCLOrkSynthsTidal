/* Retrieved from
http://sccode.org/1-5aD

Glockenspiel, xylophone, and tubularBell are all based on a very similar structure.
By nicolaariutti and edited by Zé Craum
http://sccode.org/1-5ay#c835

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\tubularBell, {
	arg freq = 440, pan = 0.5, out = 0, att_ = 0.005, rel_ = 9, exciterRel = 0.05;

	var env, snd, exciter, amp;

	amp = 0.1;

	env = Env.perc(att_, exciterRel, 0.05).kr;

	exciter = GrayNoise.ar(env);

	snd = DynKlank.ar(
		specificationsArrayRef:
	        	Ref.new([
	        		[1.013, 1.512, 2.113, 2.525, 3.35, 4.57, 6.48],   // harmonics
			        [1, 0.78, 0.89, 0.63, 0.31, 0.56, 0.25], // amplitudes
		        	[1, 0.9, 0.8, 0.65, 0.45, 0.3, 0.1]     // ring times
		        ]),
		input: exciter,
		freqscale: freq,
		decayscale: rel_
	);

	snd = LPF.ar(snd, freq * 9.5);

	DetectSilence.ar(
		        in: snd,
		        amp: 0.001,
		        time: 0.5,
		        doneAction: 2
		    );

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "nicolaariutti, Zé Craum, Josh Mitchell",
	category: \bells,
	tags: [\pitched, \tubular, \bell]
	)
).add;
