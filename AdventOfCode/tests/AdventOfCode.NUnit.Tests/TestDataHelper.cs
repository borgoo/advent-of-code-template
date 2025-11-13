namespace AdventOfCode.NUnit.Tests;

/// <summary>
/// Helper class for loading test data files.
/// Follows the convention:
/// Sample inputs -> Day{N}/Day{N}.Part{P}.SampleInput.txt
/// Puzzle input  -> Day{N}/Day{N}.PuzzleInput.txt
/// </summary>
internal static class TestDataHelper
{
    /// <summary>
    /// Loads puzzle input for a specific day.
    /// </summary>
    /// <param name="day">The day number (1-25)</param>
    /// <returns>The content of the puzzle input file</returns>
    /// <exception cref="FileNotFoundException">If the input file doesn't exist</exception>
    internal static string LoadPuzzleInput(int day)
    {
        string fileName = $"Day{day}/Day{day}.PuzzleInput.txt";
        return LoadFile(fileName);
    }

    /// <summary>
    /// Loads sample input for a specific day and part.
    /// </summary>
    /// <param name="day">The day number (1-25)</param>
    /// <param name="part">The part number (1-2)</param>
    /// <returns>The content of the sample input file</returns>
    /// <exception cref="FileNotFoundException">If the input file doesn't exist</exception>
    internal static string LoadSampleInput(int day, int part)
    {
        string fileName = $"Day{day}/Day{day}.Part{part}.SampleInput.txt";
        return LoadFile(fileName);
    }

    /// <summary>
    /// Loads any file relative to the test output directory.
    /// </summary>
    /// <param name="relativePath">Path relative to the test assembly output directory</param>
    /// <returns>The content of the file</returns>
    /// <exception cref="FileNotFoundException">If the file doesn't exist</exception>
    private static string LoadFile(string relativePath)
    {
        if (!File.Exists(relativePath))
        {
            throw new FileNotFoundException(
                $"Test data file not found: {relativePath}. " +
                $"Current directory: {Directory.GetCurrentDirectory()}");
        }

        return File.ReadAllText(relativePath);
    }

    /// <summary>
    /// Converts a raw text to a rectangular array.
    /// </summary>
    /// <typeparam name="T">The type of the elements in the array</typeparam>
    /// <param name="rawText">The raw text to convert</param>
    /// <param name="trim">Whether to trim (Start and End) the lines</param>
    /// <returns>The rectangular array</returns>
    internal static T[,] RawTextToRectangularArray<T>(string rawText, bool trim = false)
        where T : notnull
    {

        string[] lines = rawText.Split(Environment.NewLine);
        if (trim) lines = [.. lines.Select(line => line.Trim())];
        int l = lines.Length;
        T[,] result = new T[l, l];
        for (int i = 0; i < l; i++)
        {
            for (int j = 0; j < l; j++)
            {
                result[i, j] = (T)Convert.ChangeType(lines[i][j], typeof(T));
            }
        }
        return result;

    }

    /// <summary>
    /// Converts a raw text to a bidimensional array.
    /// </summary>
    /// <typeparam name="T">The type of the elements in the array</typeparam>
    /// <param name="rawText">The raw text to convert</param>
    /// <param name="trim">Whether to trim (Start and End) the lines</param>
    /// <returns>The bidimensional array</returns>
    internal static T[][] RawTextToBidimensionalArray<T>(string rawText, bool trim = false)
        where T : notnull
    {

        string[] lines = rawText.Split(Environment.NewLine);
        if (trim) lines = [.. lines.Select(line => line.Trim())];
        int rows = lines.Length;
        T[][] result = new T[rows][];
        for (int i = 0; i < rows; i++)
        {
            result[i] = [.. lines[i].Select(c => (T)Convert.ChangeType(c, typeof(T)))];
        }
        return result;

    }


}
