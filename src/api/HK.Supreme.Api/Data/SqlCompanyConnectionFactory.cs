using System.Data.Common;
using Microsoft.Data.SqlClient;

namespace HK.Supreme.Api.Data;

/// <summary>
/// Builds a connection per company from the "Training" connection string. The server can be overridden
/// with the SQLCMDSERVER environment variable, and the password is never stored in configuration: it is
/// read from SQLCMDPASSWORD. Both are the variables sqlcmd uses.
/// </summary>
public sealed class SqlCompanyConnectionFactory : ICompanyConnectionFactory
{
    private readonly string _baseConnectionString;

    public SqlCompanyConnectionFactory(IConfiguration configuration)
    {
        _baseConnectionString = configuration.GetConnectionString("Training")
            ?? throw new InvalidOperationException("Connection string 'Training' is missing.");
    }

    public async Task<DbConnection> OpenAsync(string company, CancellationToken cancellationToken)
    {
        var builder = new SqlConnectionStringBuilder(_baseConnectionString)
        {
            InitialCatalog = Companies.CatalogFor(company),
        };
        var server = Environment.GetEnvironmentVariable("SQLCMDSERVER");
        if (!string.IsNullOrEmpty(server))
        {
            builder.DataSource = server;
        }

        var password = Environment.GetEnvironmentVariable("SQLCMDPASSWORD");
        if (!string.IsNullOrEmpty(password))
        {
            builder.Password = password;
        }

        var connection = new SqlConnection(builder.ConnectionString);
        await connection.OpenAsync(cancellationToken);
        return connection;
    }
}
