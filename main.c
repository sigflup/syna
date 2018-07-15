#include <stdio.h>
#include <stdlib.h>
#include <SDL.h>

#include "syna.h"
#include "wav_header.h"

int main(void) {
 FILE *fp;
 Uint8 buffer[BUFFER_SIZE * 2]; 
  /* BUFFER_SIZE * 2 because each sample is 2 bytes (s16bit) and 
     BUFFER_SIZE only describes the number of samples in a buffer
     BUFFER_SIZE is defined in syna.h */ 

 printf("*** TOP THE FUCKING SECRET ***\n"
        " for Sickest Ravers On the Planet Earth eye's only\n"
	" unauthorized viewing subject to punishment under federal law\n"
	" **THIS MEANS YOU!**\n\n"
	" For details on how to use read syna.h and main.c\n"
	" this message will now dump to pants.wav... and then explode\n");

 syna_init();
 if(!(fp = fopen("pants.wav", "wb"))) {
  perror("pants.wav");
  exit(-1);
 }
 fwrite(wav_header, 1, 44, fp);

 /* all you have to do is call syna_lump(buffer) over and over again,
  * each time it will fill buffer with the number of samples you've 
  * specified in BUFFER_SIZE * the sample size (which is two bytes).
  * syna_lump(buffer) will return "DONE" when finished. DONE is 
  * defined in syna.h */
 while(syna_lump(buffer)!=DONE) 
  fwrite(buffer, BUFFER_SIZE,2, fp); 

 printf("**BOOM!!**\n");
 return 0; 
}
