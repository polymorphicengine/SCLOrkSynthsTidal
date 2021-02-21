/* Retrieved from
http://sccode.org/1-5aD

Original by Nathan Ho aka Snappizz
http://sccode.org/1-523

Modified by Bruno Ruviaro and Josh Mitchell 8/19

//Edited by Martin Gius 02/21 to work with SuperDirt.
*/

SynthDef(\kick_electro, {
    arg out = 0, pan = 0.5, att_ = 0.005, rel_ = 0.3;

    var body, bodyFreq, bodyAmp, pop, popFreq, popAmp, click, clickAmp, snd, amp;

	amp = 0.3;

    // body starts midrange, quickly drops down to low freqs, and trails off
    bodyFreq = Env.new(
		    levels: [261, 120, 51],
		    times: [rel_ / 8.57, rel_ / 3.75],
		    curve: \exp
		).kr;

    bodyAmp = Env.linen(
		    attackTime: att_,
		    sustainTime: rel_ / 3,
		    releaseTime: rel_
	    ).kr;

    body = SinOsc.ar(freq: bodyFreq, mul: bodyAmp);

    // pop sweeps over the midrange
    popFreq = XLine.kr(start: 750, end: 261, dur: 0.02);

	popAmp = Env.linen(
		    attackTime: att_ / 5,
		    sustainTime: rel_ / 15,
		    releaseTime: rel_ / 30,
		    level: 0.15
	    ).kr;

    pop = SinOsc.ar(freq: popFreq, mul: popAmp);

    // click is spectrally rich, covering the high-freq range
    // you can use Formant, FM, noise, whatever
    clickAmp = Env.perc(
		    attackTime: att_ / 5,
		    releaseTime: rel_ / 300,
		    level: 0.15
	    ).kr;

    click = LPF.ar(
	    	in: Formant.ar(fundfreq: 910, formfreq: 4760, bwfreq: 2110),
	    	freq: 3140,
	    	mul: clickAmp
	    );

	//Putting it all together:
	snd = Mix.ar([body, pop, click]);
    snd = snd.tanh * amp;

	DetectSilence.ar(in: snd, doneAction: 2);

    Out.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan));
},
metadata: (
	credit: "By Nathan Ho aka Snappizz",
	category: \drums,
	tags: [\percussive, \bass, \kick, \electronic]
	)
).add;