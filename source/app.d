import std.array;
import std.conv;
import std.stdio;
import std.functional;
import std.string;
import days.day;
import days.days;

void main()
{
    // Add a reference to each day here
    //void delegate()[] days = [run!Day01(new Day01), run!Day02(new Day02), ...];
    void delegate()[] days = [];
    auto length = days.length;
    if (length == 0) {
        writeln("No days present!");
        return;
    }
    for (;;)
    {
        writef("Enter a day to run (1 - %s) or 'q' to quit: ", length);
        stdout.flush;
        auto input = readln.strip;
        if (input == "q")
        {
            break;
        }
        else
        {
            auto index = input.to!ulong - 1;
            days[index]();
        }
    }
}
