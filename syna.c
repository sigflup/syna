#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "types.h"
#include "syna.h"
#include "song.h"

int syna_clock;

Uint16 rnd_x,rnd_y,rnd_z,rnd_v;

#define DELAY	0x1fff
#define REGEN	0.25f
float delay[DELAY];

#define PI2	(2*M_PI)

float accum[BUFFER_SIZE];

env_t beeps, bass_drum, snare_drum, hi_drum;
beeps_song_t beeps_song[(16*32)+1]; 

void seed(Uint16 in) {
 rnd_x = in * 8 +3;
 rnd_y = in * 2 +1;
 rnd_z = in | 1;
}

Uint16 rnd(void) {
 rnd_v = rnd_x * rnd_y;
 rnd_x = rnd_y;
 rnd_y = rnd_v;
 rnd_z = (rnd_x&(65535>>1))*(30903>>1) + (rnd_z >> 8);
 return rnd_y + rnd_z;
}

float osc(int type, float freq) {
 float j;
 switch(type) {
  case TRI:
   j = ((float)((int)((float)syna_clock * freq) % 0xff) / 256.0f);
   if(j < 0.5f) j = 1.0f - j;
   return (j - 0.75f)*2.0f;
  case BUZZ:
   return ((float)((int)((float)syna_clock * freq) % 0xff) / 256.0f)-0.5f;
  case SINE:
   return sin(((float)syna_clock / 256.0f) * freq * PI2); 
  case NOISE:
   return ((float)rnd()/65536.0f)*0.2f;
 }
}

float env(env_t *in) {
 switch(in->phase) {
  case A:
   in->v+=in->a;
   if(in->v >= 1.0f){
    in->v = 1.0f;
    in->phase = S;
   }
   break;
  case S:
   in->v-=in->s;
   if(in->v<=0.0f)
    in->v = 0.0f;
   break;
  case R:
   in->v-=in->r;
   if(in->v<=0.0f) {
    in->v = 0.0f;
    in->phase = REST;
   }
 }
}

float D1=0.0f, D2=0.0f, fil_f, fil_q;
float filter(float in, float mod) {
 float rmod;
 if(mod>1.0f)
  rmod = mod-1.0f;
 else
  rmod = mod;
 float f = fil_f * rmod;
 float out = D2 + f * D1;
 float hpout = in - out - (fil_q * D1);
 D1 = f * hpout + D1;
 D2 = out;
 if(mod > 1.0f)
  return hpout;
 else
  return out;
}

void proc_accum(void) {
 int i;
 float q;
 for(i = 0;i<BUFFER_SIZE;i++) {
  accum[i] = osc(BUZZ, beeps_song[syna_clock / (0xffff/16)].note);
  accum[i] += osc(BUZZ, beeps_song[syna_clock / (0xffff/16)].note+0.01f);
  accum[i]*= beeps.v * (float)beeps_song[syna_clock / (0xffff/16)].on;
  accum[i]*= beeps_song[syna_clock / (0xffff/16)].attack;
  accum[i] = filter(accum[i],fabs(2.0f*osc(SINE,0.003f)));
  delay[(syna_clock%DELAY)] = accum[i] + (delay[(syna_clock%DELAY)&and_sequence[SEQ]]*REGEN);
  accum[i]+= delay[(syna_clock+1)%DELAY];  
  accum[i]+= (beeps.v * osc(SINE, 0.5f)) * (float)beeps_song[syna_clock / (0xffff/16)].on;
  if((syna_clock % (0xffff/16))==0) {  /*beeps.v =0.0f; */ beeps.phase=A; }
  env(&beeps);

  q =bass_drum.v*osc(TRI,0.50f)*10.0f;
  if(q>1.5f) q = 1.5f;
  if(q<-1.5f) q = -1.5f;
  accum[i]+=q*0.5f;

  q =snare_drum.v*(osc(TRI,osc(TRI,0.34f))); 
  accum[i]+=q*0.07f;

  accum[i]+=hi_drum.v*osc(NOISE,1.0f);



  if((syna_clock % (0xffff/32))==0) {
   if(((drum_sequence[syna_clock / 0xffff]>>(syna_clock / (0xffff/32)))&1) == 1) {
 //   bass_drum.v =0.0f;
    bass_drum.phase = A;
   }
   if(((snare_sequence[syna_clock / 0xffff]>>(syna_clock / (0xffff/32)))&1) == 1) {
//    snare_drum.v =0.0f;
    snare_drum.phase = A;
   }
   if(((hi_sequence[syna_clock / 0xffff]>>(syna_clock / (0xffff/32)))&1) == 1) {
//    hi_drum.v =0.0f;
    hi_drum.phase = A;
   }

  }
  env(&bass_drum);
  env(&snare_drum);
  env(&hi_drum);



  syna_clock++;
 }
}

int syna_lump(Uint8 *buffer) {
 int i,j;
 int data;
 proc_accum();
 syna_clock -= BUFFER_SIZE;
 j = 0;
 for(i = 0;i< BUFFER_SIZE;i++) {
  if(drum_sequence[SEQ] == END_OF_SONG) return DONE;

  if(accum[i] > 1.5f) accum[i] = 1.5f; 
  if(accum[i] < -1.5f) accum[i] = -1.5f;
  data = accum[i] * 20000;

  buffer[j++] = (data&0xff);
  buffer[j++] = (data&0xff00) >> 8;

  syna_clock++;
 }
 return NOT_DONE;
}

void syna_init(void) {
 int i;
 syna_clock = 1;

 fil_f = 1.0f;
 fil_q = 1.4f;

 bass_drum.a = 0.001f;
 bass_drum.s = 0.00015f;
 bass_drum.r = 0.15f;
 bass_drum.v = 0.0f;

 memcpy(&snare_drum, &bass_drum, sizeof(env_t));
 memcpy(&hi_drum, &bass_drum, sizeof(env_t));

 hi_drum.s = 0.8f;
 snare_drum.a =0.004f;

 beeps.a = 0.004f;
 beeps.s = 0.00016f;
 beeps.r = 1.0f;
 beeps.v = 0.0f;
 beeps.phase = REST;

 for( i = 0;i<16*32;i++) {
  if((i%16) == 0) 
   seed( beeps_sequence[i/16]);
  beeps_song[i].on = rnd()&1;
  beeps_song[i].attack = (float)rnd()/65536.0f;
  beeps_song[i].note = ((float)rnd()/16384.0f);
 }
}
