#include "answer.hpp"

#include <string>
#include <iostream>
#include <fstream>

struct Pattern
{
    Pattern(const std::string& s) : name(), input(), expected()
    {
        std::size_t d1 = s.find('\t');
        std::size_t d2 = s.find('\t', d1 + 1);
        if((d1 != std::string::npos) && (d2 != std::string::npos))
        {
            name     = s.substr(0, d1);
            input    = s.substr(d1 + 1, d2 - d1 - 1);
            expected = s.substr(d2 + 1);
        }
    }

    std::string name;
    std::string input;
    std::string expected;
};

int main(int, char* [])
{
    std::ifstream patterns("patterns.tsv");
    std::string   s;
    while(std::getline(patterns, s).good())
    {
        Pattern     pattern(s);
        std::string actual = solve(pattern.input);
        if(actual != pattern.expected)
        {
            std::cout << "Failure in " << pattern.name << "\n"
                      << "expected: \"" << pattern.expected << "\"\n"
                      << "  actual: \"" << actual << "\"\n";
        }
    }

    return 0;
}
