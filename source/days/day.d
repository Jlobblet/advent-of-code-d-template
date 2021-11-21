module days.day;

import std.stdio;
import std.file;
import std.traits;
import timer;

auto run(D)(D day)
        if (hasMember!(D, "run") && isFunction!(D.run) && !Parameters!(D.run).length)
{
    return &day.run;
}

interface Day(TInput, TResult, string path)
{
    final void run()
    {
        auto t = Timer();
        t.start;
        auto data = parseData(readFile, &t);
        t.lap("Parsing data");
        auto answerA = problemA(data, &t);
        t.lap("Answer A total");
        auto answerB = problemB(data, &t);
        t.stop;
        t.lap("Answer B total");
        writefln("Answer A: %s", answerA);
        writefln("Answer B: %s", answerB);
        t.tabulate.writeln;
        t.reset;
    }

    final string readFile()
    in
    {
        assert(path.exists && path.isFile);
    }
    out (r)
    {
        assert(r.length > 0);
    }
    do
    {
        return path.readText;
    }

    TInput parseData(string data, Timer* timer);
    TResult problemA(TInput data, Timer* timer);
    TResult problemB(TInput data, Timer* timer);
}
