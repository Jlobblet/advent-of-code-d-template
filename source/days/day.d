module days.day;

import std.stdio;
import std.file;
import std.traits;
import core.time;

auto run(D)(D day)
if (hasMember!(D, "run") && isFunction!(D.run) && !Parameters!(D.run).length)
{
    return &day.run;
}

interface Day(TInput, TResult, string path)
{
    final void run()
    {
        auto data = parseData(readFile);
        auto ta1 = MonoTime.currTime;
        auto answerA = problemA(data);
        auto ta2 = MonoTime.currTime;
        writefln("A: %s (%s ns)", answerA, (ta2 - ta1).total!"nsecs");
        auto tb1 = MonoTime.currTime;
        auto answerB = problemB(data);
        auto tb2 = MonoTime.currTime;
        writefln("B: %s (%s ns)", answerB, (tb2 - tb1).total!"nsecs");
    }

    final string readFile()
    in
    {
        assert(path.exists && path.isFile);
    }
    out(r)
    {
        assert(r.length > 0);
    }
    do
    {
        return path.readText;
    }

    TInput parseData(string data);
    TResult problemA(TInput data);
    TResult problemB(TInput data);
}
