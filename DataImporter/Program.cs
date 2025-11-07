using System;
using System.IO;
using Microsoft.Data.SqlClient;

var connectionString = "Server=localhost,1433;Database=Bloomie;User Id=sa;Password=Minhlion02052004;TrustServerCertificate=True";
var sqlFile = args.Length > 0 ? args[0] : "../Bloomie (1).sql";

if (!File.Exists(sqlFile))
{
    Console.WriteLine($"❌ Error: File '{sqlFile}' not found!");
    return 1;
}

Console.WriteLine($"📖 Reading SQL file: {sqlFile}");
var sqlContent = File.ReadAllText(sqlFile);

// Split by GO statements
var batches = sqlContent.Split(new[] { "\r\nGO\r\n", "\nGO\n", "\r\nGO", "\nGO" }, StringSplitOptions.RemoveEmptyEntries);

Console.WriteLine($"📊 Found {batches.Length} SQL batches to execute\n");

try
{
    using var connection = new SqlConnection(connectionString);
    connection.Open();
    Console.WriteLine("✅ Connected to database successfully!\n");

    int successCount = 0;
    int errorCount = 0;

    for (int i = 0; i < batches.Length; i++)
    {
        var batch = batches[i].Trim();
        if (string.IsNullOrWhiteSpace(batch) || batch.StartsWith("--"))
            continue;

        try
        {
            using var command = new SqlCommand(batch, connection);
            command.CommandTimeout = 120;
            command.ExecuteNonQuery();
            successCount++;

            if (successCount % 50 == 0)
            {
                Console.WriteLine($"⏳ Executed {successCount} batches...");
            }
        }
        catch (Exception ex)
        {
            errorCount++;
            Console.WriteLine($"\n⚠️  [Error {errorCount}] Batch {i + 1}: {ex.Message}");
            var preview = batch.Length > 120 ? batch.Substring(0, 120) + "..." : batch;
            Console.WriteLine($"   SQL: {preview}\n");
        }
    }

    Console.WriteLine($"\n========================================");
    Console.WriteLine($"✅ Import completed!");
    Console.WriteLine($"   Success: {successCount} batches");
    Console.WriteLine($"   Errors: {errorCount} batches");
    Console.WriteLine($"========================================");

    return errorCount > 0 ? 1 : 0;
}
catch (Exception ex)
{
    Console.WriteLine($"\n❌ Fatal error: {ex.Message}");
    return 1;
}
