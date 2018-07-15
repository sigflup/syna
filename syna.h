
#define BUFFER_SIZE	512   /* number of samples to buffer, read main.c */
#define NOT_DONE	0
#define DONE		1


int syna_lump(Uint8 *buffer); /* read main.c */
void syna_init(void); /* call this once before everthing to initialize the synth */
