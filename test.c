#include "answer.h"

#include <string.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
    FILE *fp = fopen("patterns.tsv", "r");
    if(fp == NULL)
    {
        return 1;
    }

    char s[STRING_MAX_LENGTH];
    while(fgets(s, STRING_MAX_LENGTH - 1, fp) != NULL)
    {
        char *name     = s;
        char *input    = strchr(s, '\t');
        char *expected = strchr(input + 1, '\t');
        char actual[STRING_MAX_LENGTH];
        *input++    = '\0';
        *expected++ = '\0';
        expected[strlen(expected) - 1] = '\0';
        solve(input, actual);
        if(strcmp(actual, expected) != 0)
        {
            printf("Failure in %s\n", name);
            printf("expected: %s\n", expected);
            printf("  actual: %s\n", actual);
        }
    }
    fclose(fp);

    return 0;
}
