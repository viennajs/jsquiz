function exec (input) {
    console.log("Evaluating " + input)
    return require("./diceroller").parse(input);
    console.log("\n\n")
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
