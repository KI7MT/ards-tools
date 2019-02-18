using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;

namespace Ards.NetCore.Ards.Api
{
    /// <summary>
    /// Main Startup Class
    /// </summary>
    public class Program
    {
        /// <summary>
        /// Main API Program
        /// </summary>
        /// <param name="args"></param>
        public static void Main(string[] args)
        {
            CreateWebHostBuilder(args).Build().Run();
        }

        /// <summary>
        /// Web Host Builder
        /// </summary>
        /// <param name="args"></param>
        /// <returns></returns>
        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>();
    }
}
