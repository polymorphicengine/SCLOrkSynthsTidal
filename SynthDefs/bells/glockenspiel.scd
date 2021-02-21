/* Retrieved from
http://sccode.org/1-5aD

Glockenspiel, xylophone, and tubularBell are all based on a very similar structure.
By nicolaariutti and edited by Zé Craum
http://sccode.org/1-5ay#c835

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\glockenspiel, {
	arg freq = 440, pan = 0.5, out = 0, att_ = 0.001, rel_ = 6, exciterRel = 0.05;

	var env, snd, exciter, amp;

	amp = 0.01;

	env = Env.perc(att_, exciterRel, 0.25).kr;

	exciter = WhiteNoise.ar(env);

	snd = DynKlank.ar(
		specificationsArrayRef:
	        	Ref.new([
	        		[1, 2, 2.803, 3.871, 5.074, 7.81, 10.948, 14.421],   // harmonics
			        [1, 0.044, 0.891, 0.0891, 0.794, 0.1, 0.281, 0.079], // amplitudes
		        	[1, 0.205, 1, 0.196, 0.339, 0.047, 0.058, 0.047]     // ring times
		        ]),
		input: exciter,
		freqscale: freq,
		decayscale: rel_
	);

	DetectSilence.ar(
		        in: snd,
		        amp: 0.001,
		        time: 0.5,
		        doneAction: 2
		    );

	snd = snd * 0.1;

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "http://sccode.org/1-5aD",
	category: \bells,
	tags: [\pitched]
	)
).add