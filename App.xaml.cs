using System.Windows;
using Serilog;

namespace NetPhantom;

public partial class App : Application
{
    protected override void OnStartup(StartupEventArgs e)
    {
        base.OnStartup(e);

        Log.Logger = new LoggerConfiguration()
            .MinimumLevel.Debug()
            .WriteTo.File("logs/netphantom-.log", rollingInterval: RollingInterval.Day)
            .CreateLogger();

        Log.Information("NetPhantom 启动");
    }

    protected override void OnExit(ExitEventArgs e)
    {
        Log.Information("NetPhantom 退出");
        Log.CloseAndFlush();
        base.OnExit(e);
    }
}
