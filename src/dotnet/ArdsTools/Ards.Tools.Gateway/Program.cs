using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;

namespace Ards.Tools.Gateway
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateWebHostBuilder(args).Build().Run();
        }

        // Ocelot Ref: https://medium.com/hypertrends/microservices-api-gateways-ocelot-for-net-core-video-8bbd4ed3be8f
        // This is just one way of implementing Ocelot, there are many other.
        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
            .ConfigureAppConfiguration((host, config) => {
                config.AddJsonFile("ocelot.json");
            })
            .UseStartup<Startup>();
    }
}
