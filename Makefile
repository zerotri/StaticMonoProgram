EXECUTABLE_NAME=HelloWorld
SOURCES=src/hello.cs
ASSEMBLY=hello.exe

OBJS=$(ASSEMBLY:src/*.exe=objs/*.o)
MONO_LIBS=$(shell pkg-config --cflags --libs mono-2)

all: $(EXECUTABLE_NAME)

$(EXECUTABLE_NAME):
	@mkdir -p objs
	
	@echo "Building assembly"
	@mcs $(SOURCES) -out:objs/$(ASSEMBLY)

	@echo "Generating C bundle"
	@mkbundle --deps -c -oo objs/temp.o -o objs/temp.c objs/$(ASSEMBLY)
	
	@echo "Building final executable"
	@$(CC) $(MONO_LIBS) -framework Foundation -o $(EXECUTABLE_NAME) objs/temp.c objs/temp.o
clean:
	@echo "Cleaning up objects"
	@rm -rf objs $(EXECUTABLE_NAME)