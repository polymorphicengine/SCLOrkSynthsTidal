// By Martin Gius 02/21

(
SynthDef(\sineBass, {

	arg out = 0, pan = 0.5, freq=50, att_= 0.01, rel_ = 1, crv = -9;
	var snd,env;

	snd = SinOsc.ar(freq);
	env = EnvGen.kr(Env.perc(atackTime:att_ ,releaseTime: rel_,curve: crv), doneAction:2);

	snd = snd * env;

	Out.ar(out,DirtPan.ar(snd, ~dirt.numChannels, pan));

}).add;
)


