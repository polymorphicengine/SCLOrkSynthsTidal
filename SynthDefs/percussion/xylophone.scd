/* Retrieved from
http://sccode.org/1-5aD

Glockenspiel, xylophone, and tubularBell are all based on a very similar structure.
By nicolaariutti and edited by Zé Craum
http://sccode.org/1-5ay#c835

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\xylophone, {
	arg freq = 440, pan = 0.5, out = 0, rel_ = 2, exciterRel = 0.05;

	var exciter, snd, amp;

	amp = 0.01;

	exciter = Impulse.ar(0);

	snd = DynKlank.ar(
		specificationsArrayRef:
	        	Ref.new([
	        		[1, 3, 3.971, 5.024, 5.903, 7.13, 8.91],   // harmonics
			        [1, 0.95, 0.0891, 0.65, 0.794, 0.53, 0.1], // amplitudes
		        	[1, 0.593, 0.19, 0.16, 0.26, 0.02, 0.05]     // ring times
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

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "nicolaariutti and Ze Craum",
	category: \bells,
	tags: [\pitched]
	)
).add;
