#define SDL_MAIN_HANDLED
#include <SDL.h>
#include <iostream>

#include "Calculator.hpp"

#define SCREEN_WIDTH 640
#define SCREEN_HEIGHT 480

int main()
{
    SDL_Window* window = NULL;
    SDL_Surface* screenSurface = NULL;

    if (SDL_Init(SDL_INIT_VIDEO) < 0)
    {
        fprintf(stderr, "could not initialize sdl2: %s\n", SDL_GetError());
        return 1;
    }

    window = SDL_CreateWindow(
        "hello_sdl2",
        SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
        SCREEN_WIDTH, SCREEN_HEIGHT,
        SDL_WINDOW_SHOWN);

    if (window == NULL)
    {
        std::cerr << "could not create window: " << SDL_GetError() << std::endl;
        return 1;
    }

    std::cout << "Test!" << std::endl;

    screenSurface = SDL_GetWindowSurface(window);

    SDL_FillRect(screenSurface, NULL, SDL_MapRGB(screenSurface->format, 0xFF, 0x00, 0x00));
    SDL_UpdateWindowSurface(window);

    // commented just to see the red screen
    //SDL_DestroyWindow(window);
    //SDL_Quit();

    return 0;
}
