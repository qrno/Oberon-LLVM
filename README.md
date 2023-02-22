# Oberon-LLVM

## Resources

The following tutorial was very useful in the development of the project: [My First Language Frontend with LLVM Tutorial](https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/index.html)

## Missing Features

- All types besides integers

- Global Variables

- For Loops besides "FOR"

## Usage

- Compile the main.cpp program by running the compile.sh file.

- Move a .oberon file into the directory and rename it "code.oberon".

- Export the program's AST into a file named "code.json" by running the following command:

```
java -jar oberon.jar -i code.oberon -o code.json -b json
```

The oberon.jar file is obtained by compiling the Oberon-Scala project

- Run the "main" executable to generate the "code.ll" file.

- Run the genexec.sh to generate the "app" executable.
