CXX = /usr/bin/g++


SRC = PlayVideo.cpp
EXE = PlayVideo

PATH = -I"/opt/local/include" -L"/opt/local/lib"
LIBS = -lopencv_highgui.2.4.8 -lopencv_core.2.4.8

default: $(SRC)
	$(CXX) -o $(EXE) $(SRC) $(PATH) $(LIBS)
