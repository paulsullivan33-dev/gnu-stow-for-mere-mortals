/* hello -- a tiny program that exists only to be installed,
 * upgraded and removed again with Stow in chapter 11.
 * The version string is baked in at build time by the Makefile.
 */
#include <stdio.h>

#ifndef VERSION_STR
#define VERSION_STR "0.0"
#endif

int main(void)
{
    printf("hello, version %s\n", VERSION_STR);
    return 0;
}
