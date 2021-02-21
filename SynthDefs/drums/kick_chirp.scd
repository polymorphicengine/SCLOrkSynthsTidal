/* Recieved from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/kick_chrp.scd

A kick made using what radio folks would call a "chirp"

Modified by Bruno Ruviaro and Josh Mitchell 8/19.

//Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\kick_chirp, {

	arg out = 0, pan = 0, curve = -20, att_ = 0.001, rel_ = 0.5, maxFreq = 500;

    var env, snd, amp;

	amp = 0.1;

	env = Env.perc(attackTime: att_, releaseTime: rel_, curve: curve).exprange(0, maxFreq).kr(doneAction: 2);

    snd = SinOsc.ar(freq: env, mul: amp);
    snd = LeakDC.ar(snd);

	Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "Original by dan stowell. public domain",
	category: \drums,
	tags: [\kick, \drum, \percussion, \chirp]
	)
).add;