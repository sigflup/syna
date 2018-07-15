CC= gcc
CFLAGS=`sdl-config --cflags`
LDFLAGS=`sdl-config --libs` 

OBJS=main.o syna.o

syna: ${OBJS}
	${CC} -o syna ${LDFLAGS} ${OBJS} -lm

main.o: main.c
	${CC} -c ${CFLAGS} main.c

syna.o: syna.c
	${CC} -c ${CFLAGS} syna.c

clean:
	rm -rf ${OBJS} syna
