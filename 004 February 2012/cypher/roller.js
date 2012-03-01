function exec (input) {
    console.log("Evaluating " + input + ": ");
    require("./diceroller").parse(input);
    return;
}

exec("3");
exec("3 + 4");
exec("3+4");
exec("3 - 2");
exec("3 * 3");
exec("9 / 3");
exec("(3 + 6) / 3");
exec("d6");
exec("d100");
exec("3 d6");
exec("1 d2 + 1");
exec("1 d2+1");
exec("1d2+1");
exec("(3d4)d5")
exec("(5d3)d(7d6)")
exec("(5d3)d(7d6) + 3")
exec("((5d3)d(7d6) + 3) * 5")
exec("((5d3)d(7d6) + 3) * 5 / 3")
