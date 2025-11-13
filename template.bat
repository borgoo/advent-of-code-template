@echo off
REM Template generator for Advent of Code 2023
REM Usage: template.bat [day_number]
REM Example: template.bat 19

REM Enable ANSI escape sequences
for /f %%A in ('echo prompt $E ^| cmd') do set "ESC=%%A"

setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"
set "SOLUTION_ROOT=%SCRIPT_DIR%AdventOfCode"
set "DOCS_DIR=%SOLUTION_ROOT%\docs"
set "CORE_DIR=%SOLUTION_ROOT%\src\AdventOfCode.Core"
set "TEST_DIR=%SOLUTION_ROOT%\tests\AdventOfCode.NUnit.Tests"

if "%1"=="" (
    echo Error: Day number is required
    echo Usage: template.bat [day_number] [-rf]
    echo Example: template.bat 19
    echo          template.bat 18 -rf ^(to remove Day 18^)
    exit /b 1
)

set "DAY=%1"
set "ACTION=%2"

REM Validate day number
if not "%DAY:~0,1%"=="%DAY%" set "DAY=%DAY%"
for /f "delims=0123456789" %%i in ("%DAY%") do (
    echo Error: Day number must be a positive integer
    exit /b 1
)

REM Check for remove flag
if /i "%ACTION%"=="-rf" (
    if exist "%DOCS_DIR%\Day%DAY%" (
        rmdir /s /q "%DOCS_DIR%\Day%DAY%" 2>nul
        if not exist "%DOCS_DIR%\Day%DAY%" echo %ESC%[92mRemoved:%ESC%[0m %DOCS_DIR:\=/%/Day%DAY%
    ) else (
        echo %ESC%[93mWarning:%ESC%[0m %DOCS_DIR:\=/%/Day%DAY% does not exist
    )
    
    if exist "%CORE_DIR%\Day%DAY%" (
        rmdir /s /q "%CORE_DIR%\Day%DAY%" 2>nul
        if not exist "%CORE_DIR%\Day%DAY%" echo %ESC%[92mRemoved:%ESC%[0m %CORE_DIR:\=/%/Day%DAY%
    ) else (
        echo %ESC%[93mWarning:%ESC%[0m %CORE_DIR:\=/%/Day%DAY% does not exist
    )
    
    if exist "%TEST_DIR%\Day%DAY%" (
        rmdir /s /q "%TEST_DIR%\Day%DAY%" 2>nul
        if not exist "%TEST_DIR%\Day%DAY%" echo %ESC%[92mRemoved:%ESC%[0m %TEST_DIR:\=/%/Day%DAY%
    ) else (
        echo %ESC%[93mWarning:%ESC%[0m %TEST_DIR:\=/%/Day%DAY% does not exist
    )
    
    echo.
    echo Day%DAY% directories removed%ESC%[92m successfully!%ESC%[0m
    echo.
    exit /b 0
)

REM Check if directories already exist
if exist "%DOCS_DIR%\Day%DAY%" (
    echo %ESC%[91mERROR:%ESC%[0m Directory %DOCS_DIR:\=/%/Day%DAY% already exists!
    echo Cannot create template - Day %DAY% has already been initialized.
    exit /b 1
)

if exist "%CORE_DIR%\Day%DAY%" (
    echo %ESC%[91mERROR:%ESC%[0m Directory %CORE_DIR:\=/%/Day%DAY% already exists!
    echo Cannot create template - Day %DAY% has already been initialized.
    exit /b 1
)

if exist "%TEST_DIR%\Day%DAY%" (
    echo %ESC%[91mERROR:%ESC%[0m Directory %TEST_DIR:\=/%/Day%DAY% already exists!
    echo Cannot create template - Day %DAY% has already been initialized.
    exit /b 1
)

REM 1. Create docs directory and markdown file
if not exist "%DOCS_DIR%" mkdir "%DOCS_DIR%" 2>nul
mkdir "%DOCS_DIR%\Day%DAY%" 2>nul
echo. > "%DOCS_DIR%\Day%DAY%\Day%DAY%.md"
echo Created: %DOCS_DIR:\=/%/Day%DAY%/Day%DAY%.md

REM 2. Create src directory structure
if not exist "%CORE_DIR%" mkdir "%CORE_DIR%" 2>nul
mkdir "%CORE_DIR%\Day%DAY%" 2>nul

REM Create Part1.cs with template
call :CreatePart1File %DAY% "%CORE_DIR%\Day%DAY%\Day%DAY%.Part1.cs"
echo Created: %CORE_DIR:\=/%/Day%DAY%/Day%DAY%.Part1.cs

REM Create Part2.cs with template
call :CreatePart2File %DAY% "%CORE_DIR%\Day%DAY%\Day%DAY%.Part2.cs"
echo Created: %CORE_DIR:\=/%/Day%DAY%/Day%DAY%.Part2.cs

REM 3. Create test directory structure
if not exist "%TEST_DIR%" mkdir "%TEST_DIR%" 2>nul
mkdir "%TEST_DIR%\Day%DAY%" 2>nul

REM Create Part1.Test.cs with template
call :CreatePart1TestFile %DAY% "%TEST_DIR%\Day%DAY%\Day%DAY%.Part1.Test.cs"
echo Created: %TEST_DIR:\=/%/Day%DAY%/Day%DAY%.Part1.Test.cs

REM Create Part2.Test.cs with template
call :CreatePart2TestFile %DAY% "%TEST_DIR%\Day%DAY%\Day%DAY%.Part2.Test.cs"
echo Created: %TEST_DIR:\=/%/Day%DAY%/Day%DAY%.Part2.Test.cs

REM Create empty sample and puzzle input files
echo. > "%TEST_DIR%\Day%DAY%\Day%DAY%.Part1.SampleInput.txt"
echo Created: %TEST_DIR:\=/%/Day%DAY%/Day%DAY%.Part1.SampleInput.txt

echo. > "%TEST_DIR%\Day%DAY%\Day%DAY%.Part2.SampleInput.txt"
echo Created: %TEST_DIR:\=/%/Day%DAY%/Day%DAY%.Part2.SampleInput.txt

echo. > "%TEST_DIR%\Day%DAY%\Day%DAY%.PuzzleInput.txt"
echo Created: %TEST_DIR:\=/%/Day%DAY%/Day%DAY%.PuzzleInput.txt

echo.
echo Template for Day%DAY% created %ESC%[92msuccessfully%ESC%[0m!
echo.

endlocal

exit /b 0

REM ========================================
REM Helper Subroutines
REM ========================================

:CreatePart1File
echo namespace AdventOfCode.Core.Day%~1; > "%~2"
echo. >> "%~2"
echo internal static partial class Day%~1 { >> "%~2"
echo. >> "%~2"
echo     internal static class Part1 { >> "%~2"
echo. >> "%~2"
echo         internal static long Solve^(string rawText^) { >> "%~2"
echo. >> "%~2"
echo             throw new NotImplementedException^(); >> "%~2"
echo         } >> "%~2"
echo. >> "%~2"
echo     } >> "%~2"
echo } >> "%~2"
goto :eof

:CreatePart2File
echo namespace AdventOfCode.Core.Day%~1; > "%~2"
echo. >> "%~2"
echo internal static partial class Day%~1 { >> "%~2"
echo. >> "%~2"
echo     internal static class Part2 { >> "%~2"
echo. >> "%~2"
echo         internal static long Solve^(string rawText^) { >> "%~2"
echo. >> "%~2"
echo             throw new NotImplementedException^(); >> "%~2"
echo         } >> "%~2"
echo. >> "%~2"
echo     } >> "%~2"
echo } >> "%~2"
goto :eof

:CreatePart1TestFile
echo using static AdventOfCode.Core.Day%~1.Day%~1; > "%~2"
echo. >> "%~2"
echo namespace AdventOfCode.NUnit.Tests.Day%~1; >> "%~2"
echo. >> "%~2"
echo public class Day%~1Part1Test >> "%~2"
echo { >> "%~2"
echo     [Test] >> "%~2"
echo     public void Day%~1Part1_Solve_WithSampleInput_ReturnsExpectedValue^(^) >> "%~2"
echo     { >> "%~2"
echo         string rawText = TestDataHelper.LoadSampleInput^(day: %~1, part: 1^); >> "%~2"
echo         const long expected = -1; >> "%~2"
echo. >> "%~2"
echo         var result = Part1.Solve^(rawText^); >> "%~2"
echo. >> "%~2"
echo         Assert.That^(result, Is.EqualTo^(expected^)^); >> "%~2"
echo     } >> "%~2"
echo. >> "%~2"
echo     [Test] >> "%~2"
echo     public void Day%~1Part1_Solve_WithPuzzleInput_ReturnsExpectedValue^(^) >> "%~2"
echo     { >> "%~2"
echo         string rawText = TestDataHelper.LoadPuzzleInput^(day: %~1^); >> "%~2"
echo         const long expected = -1; >> "%~2"
echo. >> "%~2"
echo         var result = Part1.Solve^(rawText^); >> "%~2"
echo. >> "%~2"
echo         Assert.That^(result, Is.EqualTo^(expected^)^); >> "%~2"
echo     } >> "%~2"
echo } >> "%~2"
goto :eof

:CreatePart2TestFile
echo using static AdventOfCode.Core.Day%~1.Day%~1; > "%~2"
echo. >> "%~2"
echo namespace AdventOfCode.NUnit.Tests.Day%~1; >> "%~2"
echo. >> "%~2"
echo public class Day%~1Part2Test >> "%~2"
echo { >> "%~2"
echo     [Test] >> "%~2"
echo     public void Day%~1Part2_Solve_WithSampleInput_ReturnsExpectedValue^(^) >> "%~2"
echo     { >> "%~2"
echo         string rawText = TestDataHelper.LoadSampleInput^(day: %~1, part: 2^); >> "%~2"
echo         const long expected = -1; >> "%~2"
echo. >> "%~2"
echo         var result = Part2.Solve^(rawText^); >> "%~2"
echo. >> "%~2"
echo         Assert.That^(result, Is.EqualTo^(expected^)^); >> "%~2"
echo     } >> "%~2"
echo. >> "%~2"
echo     [Test] >> "%~2"
echo     public void Day%~1Part2_Solve_WithPuzzleInput_ReturnsExpectedValue^(^) >> "%~2"
echo     { >> "%~2"
echo         string rawText = TestDataHelper.LoadPuzzleInput^(day: %~1^); >> "%~2"
echo         const long expected = -1; >> "%~2"
echo. >> "%~2"
echo         var result = Part2.Solve^(rawText^); >> "%~2"
echo. >> "%~2"
echo         Assert.That^(result, Is.EqualTo^(expected^)^); >> "%~2"
echo     } >> "%~2"
echo } >> "%~2"
goto :eof
