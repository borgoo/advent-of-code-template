# advent-of-code-template
A .NET10 TDD Template for Advent of Code challenges (Visual Studio 2022-2026).

## Remember

This repository is a fully scripted, test driven workflow for Advent of Code. Use Visual Studio 2022 (or above), keep the terminal docked, and let the `template.bat` script scaffold each day for you.

## Getting Started

1. Clone the template  
   ```bash
   git clone https://github.com/borgoo/advent-of-code-template.git
   ```
2. Open the solution  
   - Start Visual Studio 2022.  
   - `File > Open > Project/Solution…` and select `advent-of-code-template/AdventOfCode/AdventOfCode.slnx`.
3. Restore dependencies (Visual Studio will prompt automatically, or run `dotnet restore` from the terminal if you prefer).
4. Open the integrated terminal  
   - Press `Ctrl+ò` (Italian keyboard) or choose `View > Terminal`.
5. Move to the repository root  
   ```powershell
   cd ..
   # you should now be in C:\...\advent-of-code-template
   ```
6. Generate your first day  
   ```powershell
   .\template.bat 1
   ```
   The script creates all Day 1 folders and files under `AdventOfCode/docs`, `AdventOfCode/src`, and `AdventOfCode/tests`.

## Project Structure

```
advent-of-code-template/
├── AdventOfCode/
│   ├── AdventOfCode.slnx
│   ├── docs/                     # Holds DayN/DayN.md, reference only
│   ├── src/AdventOfCode.Core/    # Production code
│   └── tests/AdventOfCode.NUnit.Tests/   # NUnit tests & input data
└── template.bat                  # Day scaffolding script
```

## Day Template Details

Running `template.bat <day>` with
```powershell
.\template.bat <day>
```
 creates:

- `docs/Day<day>/Day<day>.md` – optional notes or puzzle breakdown.  
- `src/AdventOfCode.Core/Day<day>/Day<day>.Part1.cs` and `Day<day>.Part2.cs` – the two solution entry points with `Solve(string rawText)` placeholders.  
- `tests/AdventOfCode.NUnit.Tests/Day<day>/Day<day>.Part1.Test.cs` and `Day<day>.Part2.Test.cs` – NUnit fixtures already wired to load sample/puzzle inputs.  
- `tests/AdventOfCode.NUnit.Tests/Day<day>/Day<day>.Part1.SampleInput.txt` / `Day<day>.Part2.SampleInput.txt` / `Day<day>.PuzzleInput.txt` – start empty; paste puzzle data here.

To remove a day and start over, run:

```powershell
.\template.bat <day> -rf
```

## Working Through Each Day

After running the template for a new day, follow this loop:

1. **Populate inputs**  
   - Paste the Advent of Code sample example into `tests/AdventOfCode.NUnit.Tests/Day<day>/Day<day>.Part1.SampleInput.txt` (and Part2 if provided).  
   - Paste the effective challenge (usually big) input into `tests/AdventOfCode.NUnit.Tests/Day<day>/Day<day>.PuzzleInput.txt`.  
   - If you have extra scenarios, add them as additional `[Test]` methods inside `Day<day>.Part1.Test.cs` or `Day<day>.Part2.Test.cs`.
2. **Shape the API if needed**  
   Rename `Solve` or adjust method signatures to better suit the puzzle. Update the corresponding calls in the test files so they stay in sync.
3. **Work test-first**  
   - Open the Test Explorer (`Test > Test Explorer`).  
   - Run the Day <day> tests; they fail because `Solve` still throws.  
   - Implement the solution in `src/AdventOfCode.Core/Day<day>/Day<day>.Part1.cs`, rerun the tests until the sample passes.
4. **Lock in the answer**  
   Once the puzzle input test passes, replace the placeholder expected value in the test with the real answer so regressions are caught later.
5. **Repeat for Part 2**  
   Use the same flow for `Day<day>.Part2.cs` and its test file.
6. **Commit your progress**  
   With all tests green, commit and push. Every commit captures both the implementation and the verified answers.

Rinse and repeat for each Advent of Code day. The files stay organised, inputs live under version control, and your answers are always backed by passing NUnit tests.
