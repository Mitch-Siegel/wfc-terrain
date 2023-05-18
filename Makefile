CC = g++
OBJDIR = builddir

GAME_SRCS = $(basename $(wildcard *.cpp))
GAME_OBJS = $(GAME_SRCS:%=%.o)

CFLAGS_NOWARNINGS = -g -O2
CFLAGS_WARNINGS = $(CFLAGS_NOWARNINGS) -Werror -Wall -I./simplenets-0.01

OBJS = $(IMGUI_OBJS) $(BACKEND_OBJS) $(IMPLOT_OBJS) $(SIMPLENETS_OBJS) $(GAME_OBJS)

programs: wfc

wfc: $(addprefix $(OBJDIR)/,$(OBJS))
# @echo Final executable:
	$(CC) $(CFLAGS_WARNINGS)  `sdl2-config --cflags` -o $@ $^ `sdl2-config --libs` -lboost_thread 

$(OBJDIR)/%.o: %.cpp
# @echo game file:
	$(CC) -c $(CFLAGS_WARNINGS) -o $@ $< -I./imgui-1.88 -I./implot-0.14

$(OBJDIR)/main.o: main.cpp
	$(CC) -c $(CFLAGS_WARNINGS) -I./imgui-1.88 -I./imgui-1.88/backends -I./implot-0.14 -o $@ $<



clean:
	rm $(OBJDIR)/*.o
	rm ./lel

cleangame:
# IMGUI_SRCS = $(basename $(wildcard $(IMGUI_VERSION)/*.cpp))
	rm $(addprefix $(OBJDIR)/,$(GAME_OBJS))
	rm ./lel

test:
	$(info OBJS="$(IMGUI_OBJS)")
	$(info SRCS="$(IMGUI_SRCS)")
	$(info BACKEND_OBJS="$(BACKEND_OBJS)")
	$(info BACKEND_SRCS="$(BACKEND_SRCS)")
	$(info SIMPLENETS_OBJS="$(SIMPLENETS_OBJS)")
	$(info SIMPLENETS_SRCS="$(SIMPLENETS_SRCS)")
	$(info OBJS="$(OBJS)")