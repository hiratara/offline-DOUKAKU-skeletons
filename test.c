#include "answer.h"

#include <string.h>
#include <stdio.h>

#define TEST_PATTERNS_FILE "patterns.tsv"

int main(int argc, char* argv[])
{
    FILE *fp = fopen(TEST_PATTERNS_FILE, "r");
    if(fp == NULL)
    {
        printf("Cannot open test patterns file: %s\n", TEST_PATTERNS_FILE);
        return 1;
    }

    int count_cases   = 0;
    int count_falures = 0;
    char s[STRING_MAX_LENGTH];
    while(fgets(s, STRING_MAX_LENGTH - 1, fp) != NULL)
    {
        ++count_cases;
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
            ++count_falures;
            printf("Failure in %s\n", name);
            printf("expected: %s\n", expected);
            printf("  actual: %s\n", actual);
        }
    }
    fclose(fp);

    printf("\nCases: %d  Failures: %d\n", count_cases, count_falures);

    return 0;
}

/*
% gcc answer.c test.c -o c_test; ./c_test
Failure in #2
expected: 13245
  actual: 12345

Cases: 3  Failures: 1
*/
