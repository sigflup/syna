
enum {
 BUZZ,
 SINE,
 TRI,
 NOISE
};

enum {
 A,S,R, REST
};

typedef struct {
 float a,s,r;
 float v;
 int phase;
} env_t;

typedef struct {
 int on;
 float attack;
 float note;
} beeps_song_t;

#ifndef Uint8
typedef unsigned char Uint8;
#endif

#ifndef Sint8
typedef char Sint8;
#endif

#ifndef Uint16
typedef unsigned short Uint16;
#endif

#ifndef Sint16
typedef short Sint16;
#endif

#ifndef Uint32
typedef unsigned int Uint32;
#endif

#ifndef Sint32
typedef int Sint32;
#endif
